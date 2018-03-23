//
//  DatabaseServiceImpl.swift
//  Podo
//
//  Created by m3g0byt3 on 21/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RealmSwift

/**
 Generic DatabaseService implementation using Realm ORM.
 `T` - type of Realm object.
 */
final class DatabaseServiceImpl<T> where T: Object {

    // MARK: - Properties

    private let realm: Realm

    // MARK: - Initialization

    /**
     Initialize service with custom Realm
     */
    init(configuration: Realm.Configuration) throws {
        self.realm = try Realm(configuration: configuration)
    }

    /**
     Initialize service with default Realm
     */
    convenience init() throws {
        try self.init(configuration: Realm.Configuration())
    }
}

// MARK: - DatabaseService protocol conformance

extension DatabaseServiceImpl: DatabaseService {

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
        // Create an array
        completion(results.map { $0 })
    }
}
