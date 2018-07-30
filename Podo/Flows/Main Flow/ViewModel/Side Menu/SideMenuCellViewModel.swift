//
//  SideMenuCellViewModel.swift
//  Podo
//
//  Created by m3g0byt3 on 17/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

struct SideMenuCellViewModel: SideMenuCellViewModelProtocol {

    // MARK: - SideMenuCellViewModelProtocol protocol conformance

    let title: String
    let type: SideMenuItemType
    let imageBlob: Data?

    // MARK: - Initialization

    init(_ model: SideMenuItem) {
        self.title = model.title.localized
        self.imageBlob = model.imageBlob
        self.type = SideMenuItemType(rawValue: model.title)!
    }
}
