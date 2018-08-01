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

    // MARK: - Properties

    private let realm: Realm
    private var tokens = [NotificationToken]()

    // MARK: - Initialization

    /// Initialize service with custom Realm
    init(configuration: Realm.Configuration) throws {
        self.realm = try Realm(configuration: configuration)
    }

    /// Initialize service with default Realm
    convenience init() throws {
        try self.init(configuration: Realm.Configuration())
    }

    // MARK: - De-Initialization

    deinit {
        tokens.forEach { $0.invalidate() }
    }
}

// MARK: - DatabaseServiceProtocol protocol conformance

extension DatabaseService: DatabaseServiceProtocol {

    func save(items: [T]) throws {
        try realm.write {
            realm.add(items, update: true)
        }
    }

    func delete(items: [T]) throws {
        try realm.write {
            realm.delete(items)
        }
    }

    func deleteAll() throws {
        try realm.write {
            let objects = realm.objects(T.self)
            realm.delete(objects)
        }
    }

    func update(in block: @escaping () -> Void) throws {
        try realm.write {
            block()
        }
    }

    func fetch(predicate: NSPredicate?, sorted: SortOption?, completion: @escaping ([T]) -> Void) throws {
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
