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
        container.register(Coordinator.self) { _, router, assembler in
            return ApplicationCoordinator(router: router, assembler: assembler)
        }
        container.register(Coordinator.self, flow: .main) { _, router, assembler in
            return MainMenuCoordinator(router: router, assembler: assembler)
        }
        container.register(Coordinator.self, flow: .tutorial) { _, router, assembler in
            return TutorialCoordinator(router: router, assembler: assembler)
        }
        container.register(Coordinator.self, flow: .settings) { _, router, assembler in
            return SettingsCoordinator(router: router, assembler: assembler)
        }
    }
}
