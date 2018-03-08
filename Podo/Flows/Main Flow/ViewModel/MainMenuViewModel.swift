//
//  MainMenuViewModel.swift
//  Podo
//
//  Created by m3g0byt3 on 25/02/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

protocol MainMenuViewModel {

    // TODO: - Add protocol inheritance to avoid duplicated code?

    var childViewModelsCount: Int { get }

    func childViewModelForIndexPath(_ indexPath: IndexPath) -> MainMenuCellViewModel
}
