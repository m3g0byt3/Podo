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

            view.onPaymentConfirmation = { [weak self] result in
                switch result {

                case .success(let request): self?.showPaymentConfirmation(for: request)

                case .failure(let error): self?.showPaymentError(error, isRecoverable: error.isRecoverable)
                }
            }
            view.onScanButtonTap = { [weak self] in
                self?.showCardScanner()
            }
            // No-op on payment cancel in `PaymentCompositionView`
            view.onPaymentCancel = nil

            router.push(view, animated: true)

        case .applePay, .cellphoneBalance, .qiwiWallet, .yandexMoney:
            // TODO: Handle .applePay, .cellphoneBalance, .qiwiWallet and .yandexMoney payment methods
            assertionFailure("Unable to top up using payment method \"\(paymentMethod.output.type)\"")

        case .unknown: break
        }
    }

    private func showPaymentConfirmation(for request: URLRequest) {
        guard let view = assembler.resolver.resolve(PaymentConfirmationView.self, argument: request) else {
            return
        }

        view.onPaymentComplete = { [weak self] in
            self?.showPaymentCompletion()
        }
        view.onPaymentCancel = { [weak self] in
            self?.router.dismiss(animated: false, completion: nil)
            self?.router.popToRootView(animated: true)
        }

        router.present(view, animated: true, completion: nil)
    }

    private func showPaymentCompletion() {
        router.dismiss(animated: false, completion: nil)
        router.popToRootView(animated: true)

        guard let view = assembler.resolver.resolve(PaymentResultView.self) else { return }

        view.onPaymentResultClose = { [weak router = self.router] in
            router?.dismiss(animated: true, completion: nil)
        }

        view.onStationSelection = { [weak router = self.router] station in
            if let url = station.output.url {
                router?.open(url: url)
            }
        }

        router.present(view, animated: true, completion: nil)
    }

    private func showCardScanner() {
        // TODO: Add actual implementation
        assertionFailure("Not implemented")
    }

    private func showPaymentError(_ error: Error, isRecoverable: Bool) {
        router.dismiss(animated: false, completion: nil)

        if !isRecoverable {
            router.popToRootView(animated: true)
        }

        guard let view = assembler.resolver.resolve(PaymentResultView.self, argument: error) else { return }

        view.onPaymentResultClose = { [weak router = self.router] in
            router?.dismiss(animated: true, completion: nil)
        }

        router.present(view, animated: true, completion: nil)
    }

    // MARK: - Coordinator protocol conformance

    override func start() {
        assertionFailure("Can't start without option")
    }

    override func start(with option: StartOption?) {
        guard case .some(.topUp(let card)) = option else { return }
        transportCard = card
        showPaymentMethods()
    }
}
