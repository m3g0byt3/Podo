//
//  SideMenuViewModelImpl.swift
//  Podo
//
//  Created by m3g0byt3 on 18/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

struct SideMenuViewModelImpl: SideMenuViewModel {

    func numberOfChildViewModels(in section: Int) -> Int {
        // TODO: Add actual implementation
        return 3
    }

    func childViewModel(for indexPath: IndexPath) -> SideMenuCellViewModel? {
        // TODO: Add actual implementation
        return SideMenuCellViewModelImpl()
    }
}
