//
//  PaymentConfirmationViewModel.swift
//  Podo
//
//  Created by m3g0byt3 on 06/08/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RxSwift
import BSK

final class PaymentConfirmationViewModel: PaymentConfirmationViewModelProtocol,
                                          PaymentConfirmationViewModelInputProtocol,
                                          PaymentConfirmationViewModelOutputProtocol {

    // MARK: - Private properties

    private let reportingService: ReportingServiceProtocol
    private let networkService: NetworkServiceProtocol

    // MARK: - PaymentAmountCellViewModelProtocol protocol conformance

    var input: PaymentConfirmationViewModelInputProtocol { return self }
    var output: PaymentConfirmationViewModelOutputProtocol { return self }

    // MARK: - PaymentConfirmationViewModelOutputProtocol protocol conformance

    let confirmationRequest: Single<URLRequest>

    var validator: Single<BSKWebViewHandlerProtocol> {
        return networkService.validator
    }

    lazy var paymentCompleted: Completable = {
        return networkService.paymentCompleted
            .do(onCompleted: { [weak self] in self?.reportSuccessfulPayment() })
    }()

    // MARK: - Initialization

    init(request: URLRequest,
         networkService: NetworkServiceProtocol,
         reportingService: ReportingServiceProtocol) {

        self.networkService = networkService

        self.reportingService = reportingService

        self.confirmationRequest = Single
            .just(request)
    }

    // MARK: - Private API

    private func reportSuccessfulPayment() {
        let event: ReportingEvent = .paymentSuccessful(type: .bankCard)
        reportingService.report(event: event)
    }
}
