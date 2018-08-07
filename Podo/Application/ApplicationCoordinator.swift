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
                                                     flow: .main)
        addChild(coordinator)
        coordinator?.start()
    }

    private func startTutorialFlow() {
        let coordinator = assembler.resolver.resolve(Coordinator.self,
                                                     flow: .tutorial)
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
        switch (option, coordinators.isEmpty) {
        // Always handle tutorial start option by self
        case (.some(.tutorial), _): startTutorialFlow()
        // If no flows are started yet (i.e. after cold launch from the 3Dtouch/push/handoff)
        // - start main flow explicitly, then fallthrough to the default case
        case (_, true): startMainFlow(); fallthrough
        // swiftlint:disable:previous fallthrough
        // Handle all other start options by the child coordinators
        default: coordinators.forEach { $0.start(with: option) }
        }
    }
}
