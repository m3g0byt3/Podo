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

        container.register(Coordinator.self) { _, router in
            return ApplicationCoordinator(router: router, assembler: ApplicationAssembler.defaultAssembler)
        }

        container.register(Coordinator.self, flow: .main) { _, router in
            return MainMenuCoordinator(router: router, assembler: ApplicationAssembler.defaultAssembler)
        }

        container.register(Coordinator.self, flow: .tutorial) { _, router in
            return TutorialCoordinator(router: router, assembler: ApplicationAssembler.defaultAssembler)
        }

        container.register(SideMenuCoordinator.self, flow: .settings) { _, router in
            return SettingsCoordinator(router: router, assembler: ApplicationAssembler.defaultAssembler)
        }

        container.register(Coordinator.self, flow: .addNewCard) { _, router in
            return AddNewCardCoordinator(router: router, assembler: ApplicationAssembler.defaultAssembler)
        }
    }
}
