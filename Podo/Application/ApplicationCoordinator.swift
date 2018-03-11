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

    private func startSettingsFlow() {
        fatalError("\(#function) not implemented yet!")
    }

    private func startTopUpFlowForCardWith(identifier: String) {
        fatalError("\(#function) not implemented yet!")
    }

    private func startAddNewCardFlow() {
        fatalError("\(#function) not implemented yet!")
    }

    // MARK: - Coordinator protocol conformance

    override func start() {
        start(with: nil)
    }

    override func start(with option: StartOption?) {
        switch option {
        // FIXME: For test purposes only! `.settings` must call `startSettingsFlow()` func
        case .some(.settings): startTutorialFlow()
        case .some(.tutorial): startTutorialFlow()
        case .some(.addNewCard): startAddNewCardFlow()
        case .some(.topUp(let cardIdentifier)): startTopUpFlowForCardWith(identifier: cardIdentifier)
        case .none: startMainFlow()
        }
    }
}
