//
//  String+Localized.swift
//  Podo
//
//  Created by m3g0byt3 on 23/03/2018.
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
}
