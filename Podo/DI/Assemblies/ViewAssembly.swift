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
                    fatalError("Unable to instantiate \(MainMenuViewController.self)")
            }
            viewController.viewModel = resolver.resolve(AnyViewModel<MainMenuCellViewModel>.self)
            return viewController
        }
        container.register(MainMenuChildView.self) { resolver in
            guard let viewController = CardsViewController.storyboardInstance() else {
                fatalError("Unable to instantiate \(CardsViewController.self)")
            }
            viewController.viewModel = resolver.resolve(AnyViewModel<CardsCellViewModel>.self)
            return viewController
        }
        container.register(SideMenuView.self) { resolver in
            let viewController = SideMenuViewController()
            viewController.viewModel = resolver.resolve(AnyViewModel<SideMenuCellViewModel>.self)
            return viewController
        }
        container.register(TutorialView.self) { _ in
            guard let viewController = TutorialViewController.storyboardInstance() else {
                fatalError("Unable to instantiate \(TutorialViewController.self)")
            }
            return viewController
        }
    }
}
