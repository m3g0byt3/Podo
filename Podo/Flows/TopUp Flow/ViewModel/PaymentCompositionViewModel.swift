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
    private let reportingService: ReportingServiceProtocol
    private let paymentCardModel: Observable<BSKPaymentMethod.CreditCard>
    private let transportCardModel: Observable<BSKTransportCard>
    private let amountModel: Observable<Int>
    private lazy var paymentDataObservable = Observable
        .combineLatest(transportCardModel, paymentCardModel, amountModel)

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
        return startPayment
            .asObservable()
            .withLatestFrom(paymentDataObservable)
            // Reporting
            .do(onNext: { [weak self] paymentData in self?.reportInitiatedPayment(paymentData) })
            // Network request
            .flatMapLatest { [unowned self] paymentData -> Observable<Result<URLRequest, BSKError>> in
                let (transportCard, paymentCard, amount) = paymentData
                return self.networkService.topUp(transportCard: transportCard,
                                                 from: .creditCard(paymentCard),
                                                 amount: amount)
            }
            // Reporting
            .do(onNext: { [weak self] result in self?.reportFailedPayment(result) })
            .share(replay: 1, scope: .whileConnected)
    }()

    // MARK: - Initialization

    init(transportCardViewModel: TransportCardViewModelProtocol,
         paymentAmountViewModel: PaymentAmountCellViewModelProtocol,
         paymentCardViewModel: PaymentCardCellViewModelProtocol,
         networkService: NetworkServiceProtocol,
         reportingService: ReportingServiceProtocol) {

        let isTransportCardValid = transportCardViewModel.output.isCardValid
        let isPaymentAmoundValid = paymentAmountViewModel.output.isAmountValid
        let isPaymentCardValid = paymentCardViewModel.output.isCardValid

        self.networkService = networkService
        self.reportingService = reportingService

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

    // MARK: - Private API

    // swiftlint:disable:next large_tuple
    private func reportInitiatedPayment(_ paymentData: (BSKTransportCard, BSKPaymentMethod.CreditCard, Int)) {
        let (_, _, amount) = paymentData
        let event: ReportingEvent = .paymentInitiated(type: .bankCard, sum: amount)
        reportingService.report(event: event)
    }

    private func reportFailedPayment(_ result: Result<URLRequest, BSKError>) {
        guard case .failure(let error) = result else { return }
        let event: ReportingEvent = .paymentFailed(type: .bankCard, reason: error.description)
        reportingService.report(event: event)
    }
}
