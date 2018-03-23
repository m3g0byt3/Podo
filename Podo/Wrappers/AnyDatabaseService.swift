//
//  AnyDatabaseService.swift
//  Podo
//
//  Created by m3g0byt3 on 22/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

/**
 Type-erasure wrapper for DatabaseService protocol
 */
final class AnyDatabaseService<ItemType> {

    // MARK: - Properties

    private let _deleteAll: () throws -> Void
    private let _saveItem: (ItemType) throws -> Void
    private let _saveItems: ([ItemType]) throws -> Void
    private let _deleteItem: (ItemType) throws -> Void
    private let _deleteItems: ([ItemType]) throws -> Void
    private let _fetch: (NSPredicate?, SortOption?, (@escaping ([ItemType]) -> Void)) throws -> Void
    private let _update: (@escaping () -> Void) throws -> Void

    // MARK: - Initialization

    init<DatabaseType: DatabaseService>(_ database: DatabaseType) where DatabaseType.Item == ItemType {
        _saveItem = database.save
        _saveItems = database.save
        _deleteItem = database.delete
        _deleteItems = database.delete
        _deleteAll = database.deleteAll
        _fetch = database.fetch
        _update = database.update
    }
}

// MARK: - DatabaseService protocol conformance

extension AnyDatabaseService: DatabaseService {

    func save(item: ItemType) throws {
        return try _saveItem(item)
    }

    func save(items: [ItemType]) throws {
        return try _saveItems(items)
    }

    func delete(item: ItemType) throws {
        return try _deleteItem(item)
    }

    func delete(items: [ItemType]) throws {
        return try _deleteItems(items)
    }

    func deleteAll() throws {
        return try _deleteAll()
    }

    func fetch(predicate: NSPredicate?, sorted: SortOption?, completion: @escaping ([ItemType]) -> Void) throws {
        return try _fetch(predicate, sorted, completion)
    }

    func update(in block: @escaping () -> Void) throws {
        return try _update(block)
    }
}
