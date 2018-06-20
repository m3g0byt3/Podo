//
//  AnyMethodWrapper.swift
//  Podo
//
//  Created by m3g0byt3 on 14/04/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

/**
 Wraps closure passed at initialization in Selector, available for the Objective-C runtime.
 Workaround due to [SR-3349](https://bugs.swift.org/browse/SR-3349).
 - Note: See also [this SO thread](https://stackoverflow.com/questions/36629301/calling-selector-from-protocol-extension).
 */
final class AnyMethodWrapper<T> {

    // MARK: - Typealiases

    typealias Closure = (T?) -> Void

    // MARK: - Properties

    private let closure: Closure

    /// Calls inner closure with optional `Any` parameter.
    var selector: Selector {
        return #selector(perform(_:))
    }

    // MARK: - Initialization

    init(_ closure: @escaping Closure) {
        self.closure = closure
    }

    // MARK: - Private API

    @objc private func perform(_ object: Any?) {
        closure(object as? T)
    }
}
