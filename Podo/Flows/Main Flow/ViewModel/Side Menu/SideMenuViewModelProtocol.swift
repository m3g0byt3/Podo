//
//  SideMenuViewModel.swift
//  Podo
//
//  Created by m3g0byt3 on 18/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RxSwift

protocol SideMenuViewModelProtocol {

    var input: SideMenuViewModelInputProtocol { get }
    var output: SideMenuViewModelOutputProtocol { get }
}

protocol SideMenuViewModelInputProtocol {}

protocol SideMenuViewModelOutputProtocol {

    var sideMenuItems: Observable<[SideMenuCellViewModelProtocol]> { get }
}
