//
//  SettingsCoordinator.swift
//  Podo
//
//  Created by m3g0byt3 on 18/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

final class SettingsCoordinator: AbstractCoordinator {

    // MARK: - Private API

    // MARK: - Internal flows

    private func showSettings() {
        guard let view = assembler.resolver.resolve(SettingsView.self) else { return }
        view.onClose = { [weak self] in
            self?.onFlowFinish?()
        }
        router.push(view, animated: true)
    }

    // MARK: - Coordinator protocol conformance

    override func start() {
        showSettings()
    }

    override func start(with option: StartOption?) {
        guard case .some(.settings) = option else { return }
        showSettings()
    }
}
