//
//  MainMenuViewModel.swift
//  Podo
//
//  Created by m3g0byt3 on 03/12/2017.
//  Copyright © 2017 m3g0byt3. All rights reserved.
//

import UIKit

final class MainMenuViewModel: MainMenuViewModelProtocol {

    // MARK: - MainMenuViewModel protocol conformance

    func numberOfChildViewModels(in section: Int) -> Int {
        // TODO: Add actual implementation
        return 10
    }

    func childViewModel(for indexPath: IndexPath) -> MainMenuCellViewModelProtocol {
        // TODO: Add actual implementation
        return MainMenuCellViewModel()
    }
}
