//
//  ApplicationCoordinator.swift
//  Podo
//
//  Created by m3g0byt3 on 02/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import Swinject

final class ApplicationCoordinator {

    // MARK: - Properties

    private let router: Router
    private let assembler: Assembler

    // MARK: - Initialization

    init(with router: Router, assembler: Assembler = ApplicationAssembler.defaultAssembler) {
        self.router = router
        self.assembler = assembler
    }

    // MARK: - Private API

    private func startMainFlow() {
        let coordinator = assembler.resolver.resolve(Coordinator.self, flow: Constant.Flows.main)
        let mainMenuView = assembler.resolver.resolve(MainMenuView.self)
        router.push(mainMenuView!, animated: true)
        coordinator?.start()
    }

    private func startContactsFlow() {
        fatalError("Not implemented yet!")
    }

    private func startSettingsFlow() {
        fatalError("Not implemented yet!")
    }

    private func startTutorialFlow() {
        fatalError("Not implemented yet!")
    }

    private func startTopUpFlowForCardWith(identifier: String) {
        fatalError("Not implemented yet!")
    }

    private func startAddNewCardFlow() {
        fatalError("Not implemented yet!")
    }
}

// MARK: - Coordinator protocol conformance

extension ApplicationCoordinator: Coordinator {

    func start(with option: StartOption?) {

        switch option {
        case .some(.contacts): startContactsFlow()
        case .some(.settings): startSettingsFlow()
        case .some(.tutorial): startTutorialFlow()
        case .some(.addNewCard): startAddNewCardFlow()
        case .some(.topUp(let cardIdentifier)): startTopUpFlowForCardWith(identifier: cardIdentifier)
        case .none: startMainFlow()
        }
    }
}
