//
//  UIFont+Extensions.swift
//  Podo
//
//  Created by m3g0byt3 on 11/04/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {

    /// Returns an instance of the system font for the specified text style and symbolic traits,
    /// scaled appropriately for the user's selected content size category.
    /// - parameters:
    ///    - style: The text style for which to return a font.
    ///    - traits: The symbolic traits for which to return a font.
    /// - returns: The system font associated with the specified text style.
    /// - warning: Returns system font without given symbolic traits if none of them found in the system.
    class func preferredFont(forTextStyle style: UIFontTextStyle, withSymbolicTraits traits: UIFontDescriptorSymbolicTraits) -> UIFont {
        let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style)
        let descriptorWithSymbolicTraits = descriptor.withSymbolicTraits(traits) ?? descriptor

        return UIFont(descriptor: descriptorWithSymbolicTraits, size: descriptorWithSymbolicTraits.pointSize)
    }
}
