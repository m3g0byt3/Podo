//
//  ViewAssembly.swift
//  Podo
//
//  Created by m3g0byt3 on 28/02/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//
// swiftlint:disable function_body_length

import UIKit
import Swinject

final class ViewAssembly: Assembly {

    func assemble(container: Container) {

        container.register(MainMenuView.self) { resolver in
            guard let viewController = MainMenuViewController.storyboardInstance() else {
                unableToResolve(MainMenuViewController.self)
            }
            viewController.viewModel = resolver.resolve(AnyViewModel<MainMenuCellViewModelProtocol>.self)
            viewController.assembler = ApplicationAssembler.defaultAssembler
            return viewController
        }

        container.register(MainMenuChildView.self) { resolver in
            guard let viewController = CardsViewController.storyboardInstance() else {
                unableToResolve(CardsViewController.self)
            }
            viewController.viewModel = resolver.resolve(CardsViewModelProtocol.self)
            return viewController
        }

        container.register(SideMenuView.self) { resolver in
            let viewController = SideMenuViewController()
            viewController.viewModel = resolver.resolve(AnyViewModel<SideMenuCellViewModelProtocol>.self)
            return viewController
        }

        container.register(TutorialView.self) { _ in
            guard let viewController = TutorialViewController.storyboardInstance() else {
                unableToResolve(TutorialViewController.self)
            }
            return viewController
        }

        container.register(SettingsView.self) { _ in
            guard let viewController = SettingsViewController.storyboardInstance() else {
                unableToResolve(SettingsViewController.self)
            }
            return viewController
        }

        container.register(ContactsView.self) { _ in
            guard let viewController = ContactsViewController.storyboardInstance() else {
                unableToResolve(ContactsViewController.self)
            }
            return viewController
        }

        container.register(HelpView.self) { _ in
            guard let viewController = HelpViewController.storyboardInstance() else {
                unableToResolve(HelpViewController.self)
            }
            return viewController
        }

        container.register(AddNewCardView.self) { resolver in
            guard let viewController = AddNewCardViewController.storyboardInstance() else {
                unableToResolve(AddNewCardViewController.self)
            }
            viewController.viewModel = resolver.resolve(AddNewCardViewModelProtocol.self)
            return viewController
        }

        container.register(TopUpView.self) { resolver in
            guard let viewController = TopUpViewController.storyboardInstance() else {
                unableToResolve(TopUpViewController.self)
            }
            viewController.viewModel = resolver.resolve(PaymentMethodViewModelProtocol.self)
            return viewController
        }

        container.register(PaymentView.self) { (resolver: Resolver, transportCardViewModel: TransportCardViewModelProtocol) in
            guard let viewController = R.storyboard.topUpViewController.paymentViewController() else {
                unableToResolve(PaymentView.self)
            }
            viewController.viewModel = resolver.resolve(PaymentConfirmationViewModelProtocol.self, argument: transportCardViewModel)
            return viewController
        }
    }
}
