//
//  ThreadSafeItems.swift
//  Podo
//
//  Created by m3g0byt3 on 06/08/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RealmSwift

/// Simple wrapper for management mix of managed and unmanaged
/// Realm objects in multi-thread environment.
struct ThreadSafeItems<T> where T: Object {

    // MARK: - Private properties

    private let items: [T]

    private let threadSafeReferences: [ThreadSafeReference<T>]

    // MARK: - Public properties

    /// An array of managed Realm objects (not-thread-safe).
    var managedObjects: [T] {
        return items.filter { $0.realm != nil }
    }

    /// An array of unmanaged Realm objects (not-thread-safe).
    var unmanagedObjects: [T] {
        return items.filter { $0.realm == nil }
    }

    // MARK: - Public API

    /// Get thread-safe managed and unmanaged Realm objects for the given realm.
    /// - parameter realm: A Realm instance for specific thread
    /// - returns: Array of managed and unmanaged Realm objects for the given realm.
    func objectsResolved(by realm: Realm) -> [T] {
        let resolvedObjects = threadSafeReferences.compactMap(realm.resolve)
        return Array([unmanagedObjects, resolvedObjects].joined())
    }

    // MARK: - Lifecycle

    /// Initialize wrapper with not-thread-safe objects.
    /// - items: Array of not thread-safe managed and unmanaged.
    init(_ items: [T]) {
        self.items = items
        self.threadSafeReferences = items
            .filter { $0.realm != nil }
            .map(ThreadSafeReference.init(to:))
    }
}

extension ThreadSafeItems: CustomStringConvertible {

    var description: String {
        return """
        An instance of \(type(of: self)) contains \(managedObjects.count)\
         managed and \(unmanagedObjects.count) unmanaged Realm objects\n.
        """
    }
}
