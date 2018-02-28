//
//  SideMenuEntry+ViewModel.swift
//  Podo
//
//  Created by m3g0byt3 on 15/02/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

extension SideMenuEntry {
    /**
     Fabric method that creates immutable view model for UI
    */
    var viewModel: SideMenuEntryViewModel? {
        return SideMenuEntryViewModel(title: title, type: type, icon: icon)
    }
}
