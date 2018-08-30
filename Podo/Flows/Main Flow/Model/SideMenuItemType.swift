//
//  SideMenuItemType.swift
//  Podo
//
//  Created by m3g0byt3 on 23/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

/// Strongly-typed representation of model type
/// - Remark: Raw value is `String` - for serialization/deserialization
enum SideMenuItemType: String {

    case main
    case settings
    case contacts
    case help
    case unknown
}
