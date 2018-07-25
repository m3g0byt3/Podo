//
//  TopUpCoordinator.swift
//  Podo
//
//  Created by m3g0byt3 on 16/04/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

final class TopUpCoordinator: AbstractCoordinator {

    // MARK: - Private Properties

    private var transportCard: TransportCardViewModelProtocol?

    // MARK: - Private API

    // MARK: - Internal flows

    private func showTopUpMethods() {
        guard let view = assembler.resolver.resolve(TopUpView.self) else { return }
        view.onPaymentMethodSelection = { [weak self] paymentMethod in
            self?.showPaymentDialog(for: paymentMethod)
        }
        view.onPaymentCancel = { [weak self] in
            self?.transportCard = nil
            self?.onFlowFinish?()
        }
        router.push(view, animated: true)
    }

    private func showPaymentDialog(for paymentMethod: PaymentMethodCellViewModel) {
        switch paymentMethod.type {
        case .bankCard:
            guard
                let card = transportCard,
                let view = assembler.resolver.resolve(PaymentView.self, argument: card)
            else { return }
            router.push(view, animated: true)
        case .applePay, .cellphoneBalance, .qiwiWallet, .yandexMoney:
            // TODO: Handle .applePay, .cellphoneBalance, .qiwiWallet and .yandexMoney payment methods
            assertionFailure("Unable to top up using payment method \"\(paymentMethod.type)\"")
        }
    }

    // MARK: - Coordinator protocol conformance

    override func start() {
        preconditionFailure("Can't start without option")
    }

    override func start(with option: StartOption?) {
        guard case .some(.topUp(let card)) = option else { return }
        transportCard = card
        showTopUpMethods()
    }
}
