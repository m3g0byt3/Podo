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
        container.register(MainView.self) { resolver in
            // TODO: - instantiate views in separate factory
            guard let viewController = MainViewController.storyboardInstance() else {
                    fatalError("Unable to instantiate MainViewController")
            }
            viewController.viewModel = resolver.resolve(MainMenuViewModel.self)

            return viewController
        }
    }
}
