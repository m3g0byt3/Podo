//
//  TutorialCoordinator.swift
//  Podo
//
//  Created by m3g0byt3 on 09/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

final class TutorialCoordinator: AbstractCoordinator {

    // MARK: - Private API

    // MARK: - Internal flows

    private func showTutorial() {
        guard let view = assembler.resolver.resolve(TutorialView.self) else { return }
        view.onNext = { [weak self] in
            self?.onFlowFinish?()
        }
        view.onSkip = { [weak self] in
            self?.onFlowFinish?()
        }
        router.setRootView(view, animated: false, fullscreen: true)
    }

    // MARK: - Coordinator protocol conformance

    override func start() {
        showTutorial()
    }

    override func start(with option: StartOption?) {
        guard case .some(.tutorial) = option else { return }
        showTutorial()
    }
}
