//
//  KeyboardHandling.swift
//  Podo
//
//  Created by m3g0byt3 on 11/07/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit
import ObjectiveC.runtime

/// Constants for associated objects
private enum AssociatedKeys {

    static var handler: Void?
}

/// Moving views behind keyboard automatically.
protocol KeyboardHandling: class {

    /// (Required) Array of views that should be managed.
    var manageableViews: [UIView] { get }

    /// (Optional) Ratio by which the keyboard height is multiplied.
    /// By default equals `1.0`.
    var keyboardOffsetRatio: CGFloat { get }
}

// MARK: - Default implementation for optional protocol requirements

extension KeyboardHandling {

    var keyboardOffsetRatio: CGFloat { return 1.0 }
}

// MARK: - Control methods

extension KeyboardHandling where Self: UIViewController {

    func beginKeyboardHandling() {
        objc_setAssociatedObject(self,
                                 &AssociatedKeys.handler,
                                 KeyboardHandler(delegate: self),
                                 .OBJC_ASSOCIATION_RETAIN)
    }

    func endKeyboardHandling() {
        objc_removeAssociatedObjects(self)
    }
}
