//
//  DatabaseService.swift
//  Podo
//
//  Created by m3g0byt3 on 28/02/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

/**
 Represents sorting by keypath
 */
enum SortOption {

    case ascending(keyPath: String)
    case descending(keyPath: String)

    // MARK: - Properties

    var ascending: Bool {
        if case .ascending = self { return true }
        return false
    }

    var keyPath: String {
        switch self {
        case .ascending(let keyPath), .descending(let keyPath): return keyPath
        }
    }
}

protocol DatabaseService: class {

    associatedtype Item

    func save(item: Item) throws

    func save(items: [Item]) throws

    func delete(item: Item) throws

    func delete(items: [Item]) throws

    func deleteAll() throws

    func fetch(predicate: NSPredicate?, sorted: SortOption?, completion: @escaping ([Item]) -> Void) throws

    func update(in block: @escaping () -> Void) throws
}

// MARK: - Convenience default implementation for some methods

extension DatabaseService {

    func save(item: Item) throws {
        try save(items: [item])
    }

    func delete(item: Item) throws {
        try delete(items: [item])
    }
}
