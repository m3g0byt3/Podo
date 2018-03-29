//
//  String+Extensions.swift
//  Podo
//
//  Created by m3g0byt3 on 28/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

extension String {

    /**
     Swifty way to get `NSLocalizedString`
     */
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }

    /**
     Returns optional NSRange from string.
     - Note: Based on [this SO answer](https://stackoverflow.com/a/46405096/7958744)
     - Requires: Swift >= 4
     */
    @available(swift 4)
    var nsRange: NSRange? {
        guard let _range = self.range(of: self) else { return nil }
        return NSRange(_range, in: self)
    }

    /**
     Returns a new string in which the characters in a specified CharacterSet are replaced by a given string.
     - parameter set: Set of characters
     - parameter replacement: Replacement string
     - returns: A new string with replacements
     */
    func replacingOccurrences<T>(of set: CharacterSet, with replacement: T) -> String where T: StringProtocol {
        var string = self
        while let range = string.rangeOfCharacter(from: set) {
            string = string.replacingCharacters(in: range, with: replacement)
        }
        return string
    }
}
