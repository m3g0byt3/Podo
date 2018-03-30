//
//  AddNewCardCoordinator.swift
//  Podo
//
//  Created by m3g0byt3 on 26/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

final class AddNewCardCoordinator: AbstractCoordinator {

    // MARK: - Private API

    // MARK: - Internal flows

    private func showAddNewCard() {
        guard let view = assembler.resolver.resolve(AddNewCardView.self) else { return }
        router.push(view, animated: true)
    }

    // MARK: - Coordinator protocol conformance

    override func start() {
        showAddNewCard()
    }

    override func start(with option: StartOption?) {
        guard case .some(.addNewCard) = option else { return }
        showAddNewCard()
    }
}
