//
//  MainMenuViewModelImpl.swift
//  Podo
//
//  Created by m3g0byt3 on 03/12/2017.
//  Copyright © 2017 m3g0byt3. All rights reserved.
//

import UIKit

struct MainMenuViewModelImpl: MainMenuViewModel {

    // MARK: - MainMenuViewModel protocol conformance

    func numberOfChildViewModels(in section: Int) -> Int {
        // TODO: Add actual implementation
        return 10
    }

    func childViewModel(for indexPath: IndexPath) -> MainMenuCellViewModel? {
        // TODO: Add actual implementation
        return MainMenuCellViewModelImpl()
    }
}
