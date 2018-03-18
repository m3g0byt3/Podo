//
//  ApplicationCoordinator.swift
//  Podo
//
//  Created by m3g0byt3 on 02/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

final class ApplicationCoordinator: AbstractCoordinator {

    // MARK: - Private API

    // MARK: - External flows

    private func startMainFlow() {
        let coordinator = assembler.resolver.resolve(Coordinator.self,
                                                     flow: .main,
                                                     arguments: router, assembler)
        addChild(coordinator)
        coordinator?.start()
    }

    private func startTutorialFlow() {
        let coordinator = assembler.resolver.resolve(Coordinator.self,
                                                     flow: .tutorial,
                                                     arguments: router, assembler)
        addChild(coordinator)
        coordinator?.onFlowFinish = { [weak self, weak coordinator] in
            self?.removeChild(coordinator)
            self?.start()
        }
        coordinator?.start()
    }

    // MARK: - Coordinator protocol conformance

    override func start() {
        start(with: nil)
    }

    override func start(with option: StartOption?) {
        switch option {
        // Handle tutorial start option by itself
        case .some(.tutorial): startTutorialFlow()
        // Handle all other start options by the child coordinators
        default:
            // If no flows are started yet (i.e. after cold launch
            // from the 3Dtouch/push/handoff) - start main flow explicitly
            if coordinators.isEmpty {
                startMainFlow()
            }
            coordinators.forEach { $0.start(with: option) }
        }
    }
}
