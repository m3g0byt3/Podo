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
            AnyViewModel(MainMenuViewModelImpl())
        }

        container.register(AnyViewModel<CardsCellViewModel>.self) { _ in
            AnyViewModel(CardsViewModelImpl())
        }

        container.register(AnyViewModel<SideMenuCellViewModel>.self) { resolver in
            guard let model = resolver.resolve(AnyDatabaseService<SideMenuItem>.self) else {
                fatalError("Unable to instantiate model of type \(AnyDatabaseService<SideMenuItem>.self)")
            }
            return AnyViewModel(SideMenuViewModelImpl(model))
        }

        container.register(AddNewCardViewModel.self) { resolver in
            guard let model = resolver.resolve(AnyDatabaseService<TransportCard>.self) else {
                fatalError("Unable to instantiate model of type \(AnyDatabaseService<TransportCard>.self)")
            }
            return AddNewCardViewModelImpl(model)
        }
    }
}
