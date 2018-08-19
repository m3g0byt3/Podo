//
//  PaymentCompositionViewModel.swift
//  Podo
//
//  Created by m3g0byt3 on 21/06/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RxSwift
import BSK
import Result

final class PaymentCompositionViewModel: PaymentCompositionViewModelProtocol,
                                         PaymentCompositionViewModelInputProtocol,
                                         PaymentCompositionViewModelOutputProtocol {

    // MARK: - Private properties

    private let childViewModels: [PaymentCompositionSectionViewModelWrapper]
    private let networkService: NetworkServiceProtocol
    private let paymentCardModel: Observable<BSKPaymentMethod.CreditCard>
    private let transportCardModel: Observable<BSKTransportCard>
    private let amountModel: Observable<Int>

    // MARK: - PaymentCompositionViewModelProtocol protocol conformance

    var input: PaymentCompositionViewModelInputProtocol { return self }
    var output: PaymentCompositionViewModelOutputProtocol { return self }

    // MARK: - PaymentCompositionViewModelInputProtocol protocol conformance

    let startPayment = PublishSubject<Void>()

    // MARK: - PaymentConfirmationViewModelOutputProtocol protocol conformance

    let paymentButtonTitle: Single<String>
    let isPaymentValid: Observable<Bool>

    var sections: Observable<[PaymentCompositionSectionViewModelWrapper]> {
        return Observable.just(childViewModels)
    }

    lazy var confirmationRequest: Observable<Result<URLRequest, BSKError>> = {
        let paymentDataObservable = Observable
            .combineLatest(self.transportCardModel, self.paymentCardModel, self.amountModel)

        return startPayment
            .asObservable()
            .take(1)
            .withLatestFrom(paymentDataObservable)
            .flatMapLatest { [unowned self] paymentData -> Observable<Result<URLRequest, BSKError>> in
                let (transportCard, paymentCard, amount) = paymentData
                return self.networkService.topUp(transportCard: transportCard,
                                                 from: .creditCard(paymentCard),
                                                 amount: amount)
            }
            .share(replay: 1, scope: .whileConnected)
    }()

    // MARK: - Initialization

    init(transportCardViewModel: TransportCardViewModelProtocol,
         paymentAmountViewModel: PaymentAmountCellViewModelProtocol,
         paymentCardViewModel: PaymentCardCellViewModelProtocol,
         service: NetworkServiceProtocol) {

        let isTransportCardValid = transportCardViewModel.output.isCardValid
        let isPaymentAmoundValid = paymentAmountViewModel.output.isAmountValid
        let isPaymentCardValid = paymentCardViewModel.output.isCardValid

        self.networkService = service

        self.paymentCardModel = paymentCardViewModel.link.model
        self.amountModel = paymentAmountViewModel.link.model
        self.transportCardModel = transportCardViewModel.link.model

        self.paymentButtonTitle = Single
            .just(R.string.localizable.startTopupButton())

        self.isPaymentValid = Observable
            .combineLatest(isTransportCardValid, isPaymentCardValid, isPaymentAmoundValid) { $0 && $1 && $2 }

        self.childViewModels = [.paymentCardSection(title: R.string.localizable.paymentCardSection(),
                                                    items: [.paymentCardSectionItem(viewModel: paymentCardViewModel)]),
                                .transportCardSection(title: R.string.localizable.transportCardSection(),
                                                      items: [.transportCardSectionItem(viewModel: transportCardViewModel)]),
                                .amountFieldSection(title: R.string.localizable.amountFieldSection(),
                                                    items: [.amountFieldSectionItem(viewModel: paymentAmountViewModel)])]
    }
}
