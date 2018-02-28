//
//  ViewModelAssembly.swift
//  Podo
//
//  Created by m3g0byt3 on 28/02/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import Swinject

final class ViewModelAssembly: Assembly {

    func assemble(container: Container) {
        container.register(MainMenuViewModel.self) { _ in
            MainMenuViewModelImpl()
        }
        container.register(MainMenuCellViewModel.self) { _ in
            MainMenuCellViewModelImpl()
        }
    }
}
