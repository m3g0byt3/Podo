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
        view.onSideMenuEntrySelection = { [weak self] sideMenuItem in
            self?.router.dismiss(animated: true, completion: nil)
            switch sideMenuItem.type {
            case .main: break
            case .settings: self?.startSettingsFlow()
            case .contacts: self?.showContacts()
            case .help: self?.showAbout()
            }
        }
        view.onSideMenuClose = { [weak self] in
            self?.router.dismiss(animated: true, completion: nil)
        }
        router.present(view, animated: true, completion: nil)
    }

    private func showContacts() {
        guard let view = assembler.resolver.resolve(ContactsView.self) else { return }
        router.push(view, animated: true)
    }

    private func showAbout() {
        guard let view = assembler.resolver.resolve(HelpView.self) else { return }
        router.push(view, animated: true)
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
        let coordinator = assembler.resolver.resolve(Coordinator.self,
                                                     flow: .addNewCard,
                                                     argument: router)
        addChild(coordinator)
        coordinator?.onFlowFinish = { [weak self, weak coordinator] in
            self?.removeChild(coordinator)
        }
        coordinator?.start()
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
