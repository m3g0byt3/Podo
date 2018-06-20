//
//  TopUpCoordinator.swift
//  Podo
//
//  Created by m3g0byt3 on 16/04/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

final class TopUpCoordinator: AbstractCoordinator {

    // MARK: - Private API

    // MARK: - Internal flows

    private func showTopUpMethods() {
        guard let view = assembler.resolver.resolve(TopUpView.self) else { return }
        view.onPaymentMethodSelection = { [weak self] paymentMethod in
            self?.showPaymentDialog(for: paymentMethod)
        }
        view.onPaymentCancel = { [weak self] in
            self?.onFlowFinish?()
        }
        router.push(view, animated: true)
    }

    private func showPaymentDialog(for paymentMethod: PaymentMethodCellViewModel) {
        guard let view = assembler.resolver.resolve(PaymentView.self) else { return }
        // FIXME: test only logging
        print(paymentMethod.type)
        router.push(view, animated: true)
    }

    // MARK: - Coordinator protocol conformance

    override func start() {
        preconditionFailure("Can't start without option")
    }

    override func start(with option: StartOption?) {
        guard case .some(.topUp(let card)) = option else { return }
        // FIXME: test only logging
        print(card)
        showTopUpMethods()
    }
}
