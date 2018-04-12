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
            viewController.assembler = ApplicationAssembler.defaultAssembler
            return viewController
        }

        container.register(MainMenuChildView.self) { resolver in
            guard let viewController = CardsViewController.storyboardInstance() else {
                fatalError("Unable to instantiate \(CardsViewController.self)")
            }
            viewController.viewModel = resolver.resolve(CardsViewModel.self)
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

        container.register(SettingsView.self) { _ in
            guard let viewController = SettingsViewController.storyboardInstance() else {
                fatalError("Unable to instantiate \(SettingsViewController.self)")
            }
            return viewController
        }

        container.register(ContactsView.self) { _ in
            guard let viewController = ContactsViewController.storyboardInstance() else {
                fatalError("Unable to instantiate \(ContactsViewController.self)")
            }
            return viewController
        }

        container.register(HelpView.self) { _ in
            guard let viewController = HelpViewController.storyboardInstance() else {
                fatalError("Unable to instantiate \(HelpViewController.self)")
            }
            return viewController
        }

        container.register(AddNewCardView.self) { resolver in
            guard let viewController = AddNewCardViewController.storyboardInstance() else {
                fatalError("Unable to instantiate \(AddNewCardViewController.self)")
            }
            viewController.viewModel = resolver.resolve(AddNewCardViewModel.self)
            return viewController
        }
    }
}
