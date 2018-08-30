//
//  CoordinatorAssembly.swift
//  Podo
//
//  Created by m3g0byt3 on 05/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import Swinject

final class CoordinatorAssembly: Assembly {

    func assemble(container: Container) {

        container.register(Coordinator.self) { resolver in
            let dependencyType = RouterProtocol.self
            guard let router = resolver.resolve(dependencyType) else {
                unableToResolve(dependencyType)
            }
            return ApplicationCoordinator(router: router, assembler: ApplicationAssembler.defaultAssembler)
        }

        container.register(Coordinator.self, flow: .main) { resolver in
            let routerDependencyType = RouterProtocol.self
            let reportingDependencyType = ReportingServiceProtocol.self

            guard let router = resolver.resolve(routerDependencyType) else {
                unableToResolve(routerDependencyType)
            }
            guard let reportingService = resolver.resolve(reportingDependencyType) else {
                unableToResolve(reportingDependencyType)
            }

            return MainMenuCoordinator(router: router,
                                       assembler: ApplicationAssembler.defaultAssembler,
                                       reportingService: reportingService)
        }

        container.register(Coordinator.self, flow: .tutorial) { resolver in
            let dependencyType = RouterProtocol.self
            guard let router = resolver.resolve(dependencyType) else {
                unableToResolve(dependencyType)
            }
            return TutorialCoordinator(router: router, assembler: ApplicationAssembler.defaultAssembler)
        }

        container.register(SideMenuCoordinator.self, flow: .settings) { resolver in
            let dependencyType = RouterProtocol.self
            guard let router = resolver.resolve(dependencyType) else {
                unableToResolve(dependencyType)
            }
            return SettingsCoordinator(router: router, assembler: ApplicationAssembler.defaultAssembler)
        }

        container.register(Coordinator.self, flow: .addNewCard) { resolver in
            let dependencyType = RouterProtocol.self
            guard let router = resolver.resolve(dependencyType) else {
                unableToResolve(dependencyType)
            }
            return AddNewCardCoordinator(router: router, assembler: ApplicationAssembler.defaultAssembler)
        }

        container.register(Coordinator.self, flow: .topUp) { resolver in
            let dependencyType = RouterProtocol.self
            guard let router = resolver.resolve(dependencyType) else {
                unableToResolve(dependencyType)
            }
            return PaymentCoordinator(router: router, assembler: ApplicationAssembler.defaultAssembler)
        }
    }
}
