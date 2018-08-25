//
//  UIView+Extensions.swift
//  Podo
//
//  Created by m3g0byt3 on 18/07/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    /// All First Responders from view's subviews or this view itself if
    /// the view returns `true` in `canBecomeFirstResponder`.
    var responders: [UIResponder] {
        // Early exit if view is not a part of the active view hierarchy.
        guard let currentWindow = window, currentWindow.isKeyWindow else { return [] }

        if canBecomeFirstResponder {
            return [self]
        } else {
            return subviews.flatMap { $0.responders }
        }
    }

    /// A `frame` property, converted to `UIScreen.main.coordinateSpace`.
    var normalizedFrame: CGRect {
        return convert(frame, to: UIScreen.main.coordinateSpace)
    }

    /// A `bounds` property, converted to `UIScreen.main.coordinateSpace`.
    var normalizedBounds: CGRect {
        return convert(bounds, to: UIScreen.main.coordinateSpace)
    }
}
