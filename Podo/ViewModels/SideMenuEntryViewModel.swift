//
//  SideMenuEntryViewModel.swift
//  Podo
//
//  Created by m3g0byt3 on 15/02/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit

/**
 Immutable view-model for SideMenuEntry class
 */
struct SideMenuEntryViewModel {

    let title: String
    let type: SideMenuEntryType
    let icon: UIImage?

    init?(title: String, type: String, icon: UIImage? = nil) {
        guard let _type = SideMenuEntryType(rawValue: type) else { return nil }
        self.type = _type
        self.title = title
        self.icon = icon
    }
}
