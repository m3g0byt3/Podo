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

        container.register(AnyViewModel<MainMenuCellViewModel>.self) { _ in
            return AnyViewModel(MainMenuViewModelImpl())
        }

        container.register(CardsViewModel.self) { resolver in
            let dependencyType = AnyDatabaseService<TransportCard>.self
            guard let model = resolver.resolve(dependencyType) else {
                unableToResolve(dependencyType)
            }
            return CardsViewModelImpl(model)
        }

        container.register(AnyViewModel<SideMenuCellViewModel>.self) { resolver in
            let dependencyType = AnyDatabaseService<SideMenuItem>.self
            guard let model = resolver.resolve(dependencyType) else {
                unableToResolve(dependencyType)
            }
            return AnyViewModel(SideMenuViewModelImpl(model))
        }

        container.register(AddNewCardViewModel.self) { resolver in
            let dependencyType = AnyDatabaseService<TransportCard>.self
            guard let model = resolver.resolve(dependencyType) else {
                unableToResolve(dependencyType)
            }
            return AddNewCardViewModelImpl(model)
        }

        container.register(PaymentMethodViewModel.self) { resolver in
            let dependencyType = AnyDatabaseService<PaymentMethod>.self
            guard let model = resolver.resolve(dependencyType) else {
                unableToResolve(dependencyType)
            }
            return PaymentMethodViewModelImpl(model)
        }

        container.register(PaymentConfirmationViewModel.self) { _, transportCardViewModel in
            return PaymentConfirmationViewModelImpl(transportCardViewModel: transportCardViewModel)
        }
    }
}
