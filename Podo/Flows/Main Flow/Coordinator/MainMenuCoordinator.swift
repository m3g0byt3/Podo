//
//  MainMenuCoordinator.swift
//  Podo
//
//  Created by m3g0byt3 on 05/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import Swinject

final class MainMenuCoordinator: AbstractCoordinator {

    // MARK: - Private Properties

    private let reportingService: ReportingServiceProtocol

    // MARK: - Initialization

    init(router: RouterProtocol, assembler: Assembler, reportingService: ReportingServiceProtocol) {
        self.reportingService = reportingService
        super.init(router: router, assembler: assembler)
    }

    @available(*, unavailable, message: "Use init(router:assembler:reportingService:) instead")
    required init(router: RouterProtocol, assembler: Assembler) {
        fatalError("Unable to initialize instance of class \(MainMenuCoordinator.self) without all dependencies.")
    }

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
            self?.startTopUpFlowFor(card)
        }
        router.setRootView(view, animated: true, fullscreen: false)
    }

    private func showSideMenu() {
        guard let view = assembler.resolver.resolve(SideMenuView.self) else { return }
        view.onSideMenuEntrySelection = { [weak self] sideMenuItem in
            let itemType = sideMenuItem.output.type
            self?.reportingService.report(event: .sideMenuItemSelected(type: itemType))
            self?.router.dismiss(animated: true, completion: nil)
            switch sideMenuItem.output.type {
            case .main: self?.router.popToRootView(animated: false)
            case .settings: self?.startSettingsFlow()
            case .contacts: self?.showContacts()
            case .help: self?.showAbout()
            case .unknown: break
            }
        }
        view.onSideMenuClose = { [weak self] in
            self?.router.dismiss(animated: true, completion: nil)
        }
        router.present(view, animated: true, completion: nil)
    }

    private func showContacts() {
        guard let view = assembler.resolver.resolve(ContactsView.self) else { return }
        view.onSideMenuSelection = { [weak self] in
            self?.showSideMenu()
        }
        router.push(view, animated: false)
    }

    private func showAbout() {
        guard let view = assembler.resolver.resolve(HelpView.self) else { return }
        view.onSideMenuSelection = { [weak self] in
            self?.showSideMenu()
        }
        router.push(view, animated: false)
    }

    // MARK: - External flows

    private func startSettingsFlow() {
        let coordinator = assembler.resolver.resolve(SideMenuCoordinator.self,
                                                     flow: .settings)
        addChild(coordinator)
        coordinator?.onFlowFinish = { [weak self, weak coordinator] in
            self?.removeChild(coordinator)
        }
        coordinator?.onSideMenuFlowStart = { [weak self] in
            self?.showSideMenu()
        }
        coordinator?.start()
    }

    private func startAddNewCardFlow() {
        let coordinator = assembler.resolver.resolve(Coordinator.self,
                                                     flow: .addNewCard)
        addChild(coordinator)
        coordinator?.onFlowFinish = { [weak self, weak coordinator] in
            self?.removeChild(coordinator)
        }
        coordinator?.start()
    }

    private func startTopUpFlowFor(_ card: TransportCardViewModelProtocol) {
        let coordinator = assembler.resolver.resolve(Coordinator.self,
                                                     flow: .topUp)
        addChild(coordinator)
        coordinator?.onFlowFinish = { [weak self, weak coordinator] in
            self?.removeChild(coordinator)
        }
        let option: StartOption = .topUp(transpordCard: card)
        coordinator?.start(with: option)
    }

    // MARK: - Coordinator protocol conformance

    override func start() {
        showMainMenu()
    }

    override func start(with option: StartOption?) {
        switch option {
        // TODO: Find transport card by `cardIdentifier` and pass it to the `startTopUpFlowFor(_:)` func
        case .some(.topUp(let cardIdentifier)): assertionFailure("Using identifier \(cardIdentifier) not supported yet")
        case .some(.addNewCard): startAddNewCardFlow()
        case .some(.settings): startSettingsFlow()
        default: break
        }
    }
}
