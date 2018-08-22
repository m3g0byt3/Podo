//
//  CGRect+Extensions.swift
//  Podo
//
//  Created by m3g0byt3 on 19/07/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import CoreGraphics

extension CGRect {

    /// Returns whether a rectangle located on the left relative to another rectangle.
    func leftRelative(to rect: CGRect) -> Bool {
        return rect.minX >= maxX
    }

    /// Returns whether a rectangle located on the right relative to another rectangle.
    func rightRelative(to rect: CGRect) -> Bool {
        return rect.maxX <= minX
    }

    /// Returns whether a rectangle located above another rectangle.
    func aboveRelative(to rect: CGRect) -> Bool {
        return rect.minY >= maxY
    }

    /// Returns whether a rectangle located below another rectangle.
    func belowRelative(to rect: CGRect) -> Bool {
        return rect.maxY <= minY
    }
}

extension CGRect {

    /// Returns whether rect.minY <= self.maxY and rect.maxY >= self.minY
    func withinHorizontalBaselines(of rect: CGRect) -> Bool {
        let topBaselinePredicate = rect.minY <= maxY
        let bottomBaselinePredicate = rect.maxY >= minY

        return topBaselinePredicate && bottomBaselinePredicate
    }

    /// Returns whether rect.minX <= self.maxX and rect.maxX >= self.minX
    func withinVerticalBaselines(of rect: CGRect) -> Bool {
        let leftBaselinePredicate = rect.minX <= maxX
        let rightBaselinePredicate = rect.maxX >= minX

        return leftBaselinePredicate && rightBaselinePredicate
    }
}

extension CGRect {

    /// Create new `CGRect` scaled on X and Y axes by given multipliers.
    /// - parameters:
    ///     - dx: X axis multiplier
    ///     - dy: Y axis multiplier
    /// - returns: rect scaled by given multipliers.
    func scaledBy(dx: CGFloat, dy: CGFloat) -> CGRect {
        // swiftlint:disable:previous identifier_name
        let newWidth = width * dx
        let newHeight = height * dy
        let newX = midX - newWidth / 2
        let newY = midY - newHeight / 2
        return CGRect(x: newX, y: newY, width: newWidth, height: newHeight)
    }
}
