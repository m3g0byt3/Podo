//
//  MainMenuCoordinator.swift
//  Podo
//
//  Created by m3g0byt3 on 05/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

final class MainMenuCoordinator: AbstractCoordinator {

    // MARK: - Private API

    private func startMainFlow() {
        guard let view = assembler.resolver.resolve(MainMenuView.self) else { return }
        router.setRootView(view, animated: true, fullscreen: false)
    }

    // MARK: - Coordinator protocol conformance

    override func start() {
        startMainFlow()
    }
}
