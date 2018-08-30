//
//  KeyboardHandling.swift
//  Podo
//
//  Created by m3g0byt3 on 11/07/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
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
