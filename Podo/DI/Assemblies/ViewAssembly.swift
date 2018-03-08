//
//  ViewAssembly.swift
//  Podo
//
//  Created by m3g0byt3 on 28/02/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import Swinject
import UIKit

final class ViewAssembly: Assembly {

    func assemble(container: Container) {
        container.register(MainMenuView.self) { resolver in
            guard let viewController = MainMenuViewController.storyboardInstance() else {
                    fatalError("Unable to instantiate \(MainMenuCoordinator.self)")
            }
            viewController.viewModel = resolver.resolve(MainMenuViewModel.self)

            return viewController
        }
    }
}
