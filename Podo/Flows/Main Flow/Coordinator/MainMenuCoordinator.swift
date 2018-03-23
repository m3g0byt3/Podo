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

    // MARK: - Internal flows

    private func showMainMenu() {
        guard let view = assembler.resolver.resolve(MainMenuView.self) else { return }
        view.onSideMenuSelection = { [weak self] in
            self?.showSideMenu()
        }
        view.onAddNewCardSelection = { [weak self] in
            self?.startAddNewCardFlow()
        }
        view.onCardSelection = { [weak self] card in
            self?.startTopUpFlowForCard(card)
        }
        router.setRootView(view, animated: true, fullscreen: false)
    }

    private func showSideMenu() {
        guard let view = assembler.resolver.resolve(SideMenuView.self) else { return }
        view.onSideMenuEntrySelection = { _ in
            fatalError("\(#function) not implemented yet!")
        }
        view.onSideMenuClose = { [weak self] in
            self?.router.dismiss(animated: true, completion: nil)
        }
        router.present(view, animated: true, completion: nil)
    }

    private func showContacts() {
        fatalError("\(#function) not implemented yet!")
    }

    private func showAbout() {
        fatalError("\(#function) not implemented yet!")
    }

    // MARK: - External flows

    private func startSettingsFlow() {
        let coordinator = assembler.resolver.resolve(Coordinator.self,
                                                     flow: .settings,
                                                     argument: router)
        addChild(coordinator)
        coordinator?.onFlowFinish = { [weak self, weak coordinator] in
            self?.removeChild(coordinator)
        }
        coordinator?.start()
    }

    private func startAddNewCardFlow() {
        fatalError("\(#function) not implemented yet!")
    }

    private func startTopUpFlowForCard(_ card: Any) {
        fatalError("\(#function) not implemented yet!")
    }

    // MARK: - Coordinator protocol conformance

    override func start() {
        showMainMenu()
    }

    override func start(with option: StartOption?) {
        switch option {
        // TODO: Find transport card by `cardIdentifier` and pass it to the `startTopUpFlowForCard` func
        case .some(.topUp(let cardIdentifier)): startTopUpFlowForCard(cardIdentifier)
        case .some(.addNewCard): startAddNewCardFlow()
        case .some(.settings): startSettingsFlow()
        default: break
        }
    }
}
