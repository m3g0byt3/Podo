//
//  ViewAssembly.swift
//  Podo
//
//  Created by m3g0byt3 on 28/02/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit
import Swinject

final class ViewAssembly: Assembly {

    // swiftlint:disable:next type_name
    private typealias T = TransportCardViewModelProtocol

    // swiftlint:disable:next function_body_length
    func assemble(container: Container) {

        container.register(MainMenuView.self) { resolver in
            guard let viewController = MainMenuViewController.storyboardInstance() else {
                unableToResolve(MainMenuView.self)
            }
            viewController.assembler = ApplicationAssembler.defaultAssembler
            viewController.viewModel = resolver.resolve(MainMenuViewModel.self)
            return viewController
        }

        container.register(MainMenuChildView.self) { resolver in
            guard let viewController = CardsViewController.storyboardInstance() else {
                unableToResolve(MainMenuChildView.self)
            }
            viewController.viewModel = resolver.resolve(CardsViewModelProtocol.self)
            return viewController
        }

        container.register(SideMenuView.self) { resolver in
            let viewController = SideMenuViewController()
            viewController.viewModel = resolver.resolve(SideMenuViewModelProtocol.self)
            return viewController
        }

        container.register(TutorialView.self) { _ in
            guard let viewController = TutorialViewController.storyboardInstance() else {
                unableToResolve(TutorialView.self)
            }
            return viewController
        }

        container.register(SettingsView.self) { _ in
            guard let viewController = SettingsViewController.storyboardInstance() else {
                unableToResolve(SettingsView.self)
            }
            return viewController
        }

        container.register(ContactsView.self) { _ in
            guard let viewController = ContactsViewController.storyboardInstance() else {
                unableToResolve(ContactsView.self)
            }
            return viewController
        }

        container.register(HelpView.self) { _ in
            guard let viewController = HelpViewController.storyboardInstance() else {
                unableToResolve(HelpView.self)
            }
            return viewController
        }

        container.register(AddNewCardView.self) { resolver in
            guard let viewController = AddNewCardViewController.storyboardInstance() else {
                unableToResolve(AddNewCardView.self)
            }
            viewController.viewModel = resolver.resolve(AddNewCardViewModelProtocol.self)
            return viewController
        }

        container.register(PaymentMethodsView.self) { resolver in
            guard let viewController = R.storyboard.topUpViewController.instantiateInitialViewController() else {
                unableToResolve(PaymentMethodsView.self)
            }
            viewController.viewModel = resolver.resolve(PaymentMethodViewModelProtocol.self)
            return viewController
        }

        container.register(PaymentCompositionView.self) { (resolver: Resolver, transportCardViewModel: T) in
            guard let viewController = R.storyboard.topUpViewController.paymentViewController() else {
                unableToResolve(PaymentCompositionView.self)
            }
            viewController.viewModel = resolver.resolve(PaymentCompositionViewModelProtocol.self,
                                                        argument: transportCardViewModel)
            return viewController
        }

        container.register(PaymentConfirmationView.self) { (resolver: Resolver, request: URLRequest) in
            guard let viewController = R.storyboard.topUpViewController.paymentConfirmationViewController() else {
                unableToResolve(PaymentConfirmationView.self)
            }
            viewController.viewModel = resolver.resolve(PaymentConfirmationViewModelProtocol.self,
                                                        argument: request)
            return viewController
        }

        container.register(PaymentResultView.self) { resolver in
            let viewController = PaymentResultViewController()
            viewController.viewModel = resolver.resolve(PaymentResultViewModelProtocol.self)
            return viewController
        }

        container.register(PaymentResultView.self) { (resolver: Resolver, error: Error) in
            let viewController = PaymentResultViewController()
            viewController.viewModel = resolver.resolve(PaymentResultViewModelProtocol.self, argument: error)
            return viewController
        }
    }
}
