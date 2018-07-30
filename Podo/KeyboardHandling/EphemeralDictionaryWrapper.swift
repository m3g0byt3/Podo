//
//  EphemeralDictionaryWrapper.swift
//  Podo
//
//  Created by m3g0byt3 on 22/07/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

/**
 Generic opaque wrapper above `Dictionary` collection with subscript with following rules:
 - Setter: value for key will be set only if current value for this key equals `nil`.
 - Getter: value for key will be set to `nil` upon returned.
 */
struct EphemeralDictionaryWrapper<K, V> where K: Hashable {

    private var _dictionary: [K: V]

    subscript(_ key: K) -> V? {
        mutating get {
            defer { _dictionary[key] = nil }
            return _dictionary[key]
        }
        set {
            guard _dictionary[key] == nil else { return }
            _dictionary[key] = newValue
        }
    }
}

extension EphemeralDictionaryWrapper: ExpressibleByDictionaryLiteral {

    init(dictionaryLiteral elements: (K, V)...) {
        self._dictionary = [:]
        for (key, value) in elements {
            self._dictionary[key] = value
        }
    }
}

extension EphemeralDictionaryWrapper: Equatable where V: Equatable {

    static func == (lhs: EphemeralDictionaryWrapper<K, V>, rhs: EphemeralDictionaryWrapper<K, V>) -> Bool {
        return lhs._dictionary == rhs._dictionary
    }
}

extension EphemeralDictionaryWrapper: CustomStringConvertible {

    var description: String {
        return _dictionary.description
    }
}

extension EphemeralDictionaryWrapper: CustomDebugStringConvertible {

    var debugDescription: String {
        return _dictionary.debugDescription
    }
}
