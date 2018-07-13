//
//  UIView.AnimationOptions+Extensions.swift
//  Podo
//
//  Created by m3g0byt3 on 13/07/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit

extension UIView.AnimationOptions {

    /// Left shift for `UIView.AnimationCurve` -> `UIView.AnimationOptions` conversion.
    private static let shift = 16

    /**
     Convenience init from `UIView.AnimationCurve`.
     - parameter curve: an `UIView.AnimationCurve` enum.
     */
    init(curve: UIView.AnimationCurve) {
        let rawValue = curve.rawValue << UIView.AnimationOptions.shift
        self.init(rawValue: UInt(rawValue))
    }
}
