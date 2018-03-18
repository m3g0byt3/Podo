//
//  SideMenuView.swift
//  Podo
//
//  Created by m3g0byt3 on 12/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

protocol SideMenuView: View {

    var onSideMenuEntrySelection: ((SideMenuCellViewModel) -> Void)? { get set }
    var onSideMenuClose: Completion? { get set }
}
