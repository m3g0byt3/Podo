//
//  SideMenuCellViewModelImpl.swift
//  Podo
//
//  Created by m3g0byt3 on 17/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit.UIImage

struct SideMenuCellViewModelImpl: SideMenuCellViewModel {

    // MARK: - SideMenuCellViewModel protocol conformance

    let title: String
    let type: SideMenuItemType
    let image: UIImage?

    // MARK: - Initialization

    init(_ model: SideMenuItem) {
        self.title = model.title.localized
        self.image = UIImage(data: model.imageBlob!)
        self.type = SideMenuItemType(rawValue: model.title)!
    }
}
