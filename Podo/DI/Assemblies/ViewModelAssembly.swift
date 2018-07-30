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

        container.register(AnyViewModel<MainMenuCellViewModelProtocol>.self) { _ in
            return AnyViewModel(MainMenuViewModel())
        }

        container.register(CardsViewModelProtocol.self) { resolver in
            let dependencyType = AnyDatabaseService<TransportCard>.self
            guard let model = resolver.resolve(dependencyType) else {
                unableToResolve(dependencyType)
            }
            return CardsViewModel(model)
        }

        container.register(AnyViewModel<SideMenuCellViewModelProtocol>.self) { resolver in
            let dependencyType = AnyDatabaseService<SideMenuItem>.self
            guard let model = resolver.resolve(dependencyType) else {
                unableToResolve(dependencyType)
            }
            return AnyViewModel(SideMenuViewModel(model))
        }

        container.register(AddNewCardViewModelProtocol.self) { resolver in
            let dependencyType = AnyDatabaseService<TransportCard>.self
            guard let model = resolver.resolve(dependencyType) else {
                unableToResolve(dependencyType)
            }
            return AddNewCardViewModel(model)
        }

        container.register(PaymentMethodViewModelProtocol.self) { resolver in
            let dependencyType = AnyDatabaseService<PaymentMethod>.self
            guard let model = resolver.resolve(dependencyType) else {
                unableToResolve(dependencyType)
            }
            return PaymentMethodViewModel(model)
        }

        container.register(PaymentAmountCellViewModelProtocol.self) { _ in
            return PaymentAmountCellViewModel()
        }

        container.register(PaymentCardCellViewModelProtocol.self) { _ in
            return PaymentCardCellViewModel()
        }

        container.register(PaymentConfirmationViewModelProtocol.self) { (resolver, viewModel: TransportCardViewModelProtocol) in
            let paymentAmountDependencyType = PaymentAmountCellViewModelProtocol.self
            let paymentCardDependencyType = PaymentCardCellViewModelProtocol.self

            guard let paymentAmountViewModel = resolver.resolve(paymentAmountDependencyType) else {
                unableToResolve(paymentAmountDependencyType)
            }
            guard let paymentCardViewModel = resolver.resolve(paymentCardDependencyType) else {
                unableToResolve(paymentCardDependencyType)
            }

            return PaymentConfirmationViewModel(transportCardViewModel: viewModel,
                                                paymentAmountViewModel: paymentAmountViewModel,
                                                paymentCardViewModel: paymentCardViewModel)
        }
    }
}
