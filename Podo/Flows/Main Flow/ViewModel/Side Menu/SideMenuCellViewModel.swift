//
//  SideMenuCellViewModel.swift
//  Podo
//
//  Created by m3g0byt3 on 17/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit.UIImage

protocol SideMenuCellViewModel {

    var title: String { get }
    var type: SideMenuItemType { get }
    var image: UIImage? { get }
}
