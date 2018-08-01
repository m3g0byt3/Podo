//
//  Array+Extensions.swift
//  Podo
//
//  Created by m3g0byt3 on 23/07/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

extension Array {

    /// Prevents runtime crash if passed index out of bounds, returns `nil` in this case.
    /// - parameter index: Index of element to return.
    /// - returns: Element of the array (only if element's index within array's bounds).
    subscript(safe index: Index) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
