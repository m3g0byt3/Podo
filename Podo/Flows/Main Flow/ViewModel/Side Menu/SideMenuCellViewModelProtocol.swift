//
//  SideMenuCellViewModelProtocol.swift
//  Podo
//
//  Created by m3g0byt3 on 17/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

protocol SideMenuCellViewModelProtocol {

    var input: SideMenuCellViewModelInputProtocol { get }
    var output: SideMenuCellViewModelOutputProtocol { get }
}

protocol SideMenuCellViewModelInputProtocol {}

protocol SideMenuCellViewModelOutputProtocol {

    var title: String { get }
    var type: SideMenuItemType { get }
    var imageBlob: Data? { get }
}
