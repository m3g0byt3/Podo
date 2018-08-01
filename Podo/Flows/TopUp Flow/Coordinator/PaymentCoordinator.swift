//
//  PaymentCoordinator.swift
//  Podo
//
//  Created by m3g0byt3 on 16/04/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

final class PaymentCoordinator: AbstractCoordinator {

    // MARK: - Private Properties

    private var transportCard: TransportCardViewModelProtocol?

    // MARK: - Private API

    // MARK: - Internal flows

    private func showPaymentMethods() {
        guard let view = assembler.resolver.resolve(PaymentMethodsView.self) else { return }
        view.onPaymentMethodSelection = { [weak self] paymentMethod in
            self?.showPaymentComposition(for: paymentMethod)
        }
        view.onPaymentCancel = { [weak self] in
            self?.transportCard = nil
            self?.onFlowFinish?()
        }
        router.push(view, animated: true)
    }

    private func showPaymentComposition(for paymentMethod: PaymentMethodCellViewModelProtocol) {
        switch paymentMethod.output.type {
        case .bankCard:
            guard
                let card = transportCard,
                let view = assembler.resolver.resolve(PaymentCompositionView.self, argument: card)
            else { return }
            router.push(view, animated: true)
        case .applePay, .cellphoneBalance, .qiwiWallet, .yandexMoney:
            // TODO: Handle .applePay, .cellphoneBalance, .qiwiWallet and .yandexMoney payment methods
            assertionFailure("Unable to top up using payment method \"\(paymentMethod.output.type)\"")
        case .unknown: break
        }
    }

    // MARK: - Coordinator protocol conformance

    override func start() {
        preconditionFailure("Can't start without option")
    }

    override func start(with option: StartOption?) {
        guard case .some(.topUp(let card)) = option else { return }
        transportCard = card
        showPaymentMethods()
    }
}
