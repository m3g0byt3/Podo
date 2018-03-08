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
            return ApplicationCoordinator(with: router)
        }
        container.register(Coordinator.self, flow: Constant.Flows.main) { _ in
            return MainMenuCoordinator()
        }
    }
}
