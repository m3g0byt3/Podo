//
//  String+Extensions.swift
//  Podo
//
//  Created by m3g0byt3 on 28/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

extension String {

    /// Swifty way to get `NSLocalizedString`
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }

    /// Returns optional NSRange from string.
    /// - Note: Based on [this SO answer](https://stackoverflow.com/a/46405096/7958744)
    /// - Requires: Swift >= 4
    @available(swift 4)
    var nsRange: NSRange? {
        // swiftlint:disable:next identifier_name
        guard let _range = self.range(of: self) else { return nil }
        return NSRange(_range, in: self)
    }

    /// Returns a new string in which the characters in a specified CharacterSet are replaced by a given string.
    /// - Parameters:
    ///     - set: Set of characters
    ///     - parameter replacement: Replacement string
    /// - returns: A new string with replacements
    func replacingOccurrences<T>(of set: CharacterSet, with replacement: T) -> String where T: StringProtocol {
        var string = self
        while let range = string.rangeOfCharacter(from: set) {
            string = string.replacingCharacters(in: range, with: replacement)
        }
        return string
    }

    /// Returns a new string from equal-size chunks of the original string, joined by the given separator.
    /// - Parameters:
    ///   - size: Size of individual chunk.
    ///   - separator: Separator between chunks.
    /// - Returns: String from equal-size chunks of the original string.
    func split(size: Int, separator: String) -> String {
        return self.indices
            .filter { self.distance(from: self.startIndex, to: $0) % size == 0 }
            .map { (index: String.Index) -> Substring in
                let endIndex = self.index(index, offsetBy: size, limitedBy: self.endIndex) ?? self.endIndex
                return self[index..<endIndex]
            }
            .joined(separator: separator)
    }
}
