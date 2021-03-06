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

    // swiftlint:disable:next type_name
    private typealias T = TransportCardViewModelProtocol

    // swiftlint:disable:next function_body_length cyclomatic_complexity
    func assemble(container: Container) {

        container.register(MainMenuViewModel.self) { resolver in
            let dependencyType = AnyDatabaseService<PaymentItem>.self
            guard let model = resolver.resolve(dependencyType) else {
                unableToResolve(dependencyType)
            }
            return MainMenuViewModel(model)
        }

        container.register(CardsViewModelProtocol.self) { resolver in
            let dependencyType = AnyDatabaseService<TransportCard>.self
            guard let model = resolver.resolve(dependencyType) else {
                unableToResolve(dependencyType)
            }
            return CardsViewModel(model)
        }

        container.register(SideMenuViewModelProtocol.self) { resolver in
            let dependencyType = AnyDatabaseService<SideMenuItem>.self
            guard let model = resolver.resolve(dependencyType) else {
                unableToResolve(dependencyType)
            }
            return SideMenuViewModel(model)
        }

        container.register(AddNewCardViewModelProtocol.self) { resolver in
            let databaseDependencyType = AnyDatabaseService<TransportCard>.self
            let reportingDependencyType = ReportingServiceProtocol.self

            guard let model = resolver.resolve(databaseDependencyType) else {
                unableToResolve(databaseDependencyType)
            }
            guard let reportingService = resolver.resolve(reportingDependencyType) else {
                unableToResolve(reportingDependencyType)
            }
            return AddNewCardViewModel(model: model, reportingService: reportingService)
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

        container.register(PaymentCompositionViewModelProtocol.self) { (resolver, transportCardViewModel: T) in
            let paymentAmountDependencyType = PaymentAmountCellViewModelProtocol.self
            let paymentCardDependencyType = PaymentCardCellViewModelProtocol.self
            let networkServiceDependencyType = NetworkServiceProtocol.self
            let reportingServiceDependencyType = ReportingServiceProtocol.self

            guard let paymentAmountViewModel = resolver.resolve(paymentAmountDependencyType) else {
                unableToResolve(paymentAmountDependencyType)
            }
            guard let paymentCardViewModel = resolver.resolve(paymentCardDependencyType) else {
                unableToResolve(paymentCardDependencyType)
            }
            guard let networkService = resolver.resolve(networkServiceDependencyType) else {
                unableToResolve(networkServiceDependencyType)
            }
            guard let reportingService = resolver.resolve(reportingServiceDependencyType) else {
                unableToResolve(reportingServiceDependencyType)
            }

            return PaymentCompositionViewModel(transportCardViewModel: transportCardViewModel,
                                               paymentAmountViewModel: paymentAmountViewModel,
                                               paymentCardViewModel: paymentCardViewModel,
                                               networkService: networkService,
                                               reportingService: reportingService)
        }

        container.register(PaymentConfirmationViewModelProtocol.self) { (resolver, request: URLRequest) in
            let serviceDependencyType = NetworkServiceProtocol.self
            guard let networkService = resolver.resolve(serviceDependencyType) else {
                unableToResolve(serviceDependencyType)
            }
            return PaymentConfirmationViewModel(request: request, networkService: networkService)
        }

        container.register(PaymentResultViewModelProtocol.self) { resolver in
            let locationDependencyType = LocationServiceProtocol.self
            let stationDependencyType = StationServiceProtocol.self

            guard let locationService = resolver.resolve(locationDependencyType) else {
                unableToResolve(locationDependencyType)
            }
            guard let stationService = resolver.resolve(stationDependencyType) else {
                unableToResolve(stationDependencyType)
            }

            return PaymentSuccessfulResultViewModel(locationService: locationService,
                                                    stationService: stationService)
        }

        container.register(PaymentResultViewModelProtocol.self) { _, error in
            return PaymentFailedResultViewModel(error: error)
        }
    }
}
