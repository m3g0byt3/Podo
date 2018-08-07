//
//  DatabaseService.swift
//  Podo
//
//  Created by m3g0byt3 on 21/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RealmSwift

/// Generic DatabaseServiceProtocol implementation using Realm ORM.
/// `T` - type of Realm object.
final class DatabaseService<T> where T: Object {

    // MARK: - Typealiases

    private typealias BackgroundBlock = (_ items: [T], _ realm: Realm) -> Void

    // MARK: - Properties

    // Store configuration instead of Realm instance to provide thread safety
    private let configuration: Realm.Configuration
    private var tokens = [NotificationToken]()
    private let semaphore = DispatchSemaphore(value: 1)
    private let queue = DispatchQueue(label: "com.m3g0byt3.databaseServiceQueue.\(UUID().uuidString)",
                                      qos: .background,
                                      attributes: .concurrent)

    // MARK: - Initialization

    /// Initialize service with custom Realm
    init(configuration: Realm.Configuration) throws {
        self.configuration = configuration
    }

    /// Initialize service with default Realm Configuration
    convenience init() throws {
        try self.init(configuration: Realm.Configuration())
    }

    // MARK: - De-Initialization

    deinit {
        tokens.forEach { $0.invalidate() }
    }

    // MARK: - Private API

    private func process(_ items: [T], in block: @escaping BackgroundBlock) {
        autoreleasepool {
            let wrappedItems = ThreadSafeItems(items)

            queue.async { [weak self] in
                guard
                    let `self` = self,
                    let realm = try? Realm(configuration: self.configuration)
                else { return }

                let resolvedObjects = wrappedItems.objectsResolved(by: realm)

                try? realm.write {
                    block(resolvedObjects, realm)
                }
            }
        }
    }
}

// MARK: - DatabaseServiceProtocol protocol conformance

extension DatabaseService: DatabaseServiceProtocol {

    func save(items: [T]) {
        semaphore.wait()
        process(items) { [weak self] threadSafeObjects, realm in
            realm.add(threadSafeObjects, update: true)
            self?.semaphore.signal()
        }
    }

    func delete(items: [T]) {
        semaphore.wait()
        process(items) { [weak self] threadSafeObjects, realm in
            realm.delete(threadSafeObjects)
            self?.semaphore.signal()
        }
    }

    func deleteAll() {
        guard let realm = try? Realm(configuration: configuration) else { return }
        let items: [T] = realm.objects(T.self).map { $0 }

        semaphore.wait()
        process(items) { [weak self] threadSafeObjects, realm in
            realm.delete(threadSafeObjects)
            self?.semaphore.signal()
        }
    }

    func update(_ items: [T], in block: @escaping ([T]) -> Void) throws {
        semaphore.wait()
        process(items) { [weak self] threadSafeObjects, _ in
            block(threadSafeObjects)
            self?.semaphore.signal()
        }
    }

    // Not using bg queue for querying because Realm already has bg queue where queries performed.
    func fetch(predicate: NSPredicate?, sorted: SortOption?, completion: @escaping ([T]) -> Void) throws {
        guard let realm = try? Realm(configuration: configuration) else { return }
        // Fetch objects
        var results = realm.objects(T.self)
        // Filtering
        results = predicate.map { results.filter($0) } ?? results
        // Sorting
        results = sorted.map { results.sorted(byKeyPath: $0.keyPath, ascending: $0.ascending) } ?? results
        // Start observing objects changes (only if our realm is RW) and return array with objects in block
        if realm.configuration.readOnly {
            completion(results.map { $0 })
        } else {
            let token = results.observe { changes in
                switch changes {
                case .initial(let collection), .update(let collection, _, _, _):
                    completion(collection.map { $0 })
                case .error(let error):
                    assertionFailure("Realm database error: \(error)")
                }
            }
            tokens.append(token)
        }
    }
}
