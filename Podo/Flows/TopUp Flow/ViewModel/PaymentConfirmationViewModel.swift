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

struct PaymentConfirmationViewModel: PaymentConfirmationViewModelProtocol,
                                     PaymentConfirmationViewModelInputProtocol,
                                     PaymentConfirmationViewModelOutputProtocol {

    // MARK: - PaymentAmountCellViewModelProtocol protocol conformance

    var input: PaymentConfirmationViewModelInputProtocol { return self }
    var output: PaymentConfirmationViewModelOutputProtocol { return self }

    // MARK: - PaymentConfirmationViewModelOutputProtocol protocol conformance

    let confirmationRequest: Single<URLRequest>
    let validator: Single<BSKWebViewHandlerProtocol>

    // MARK: - Initialization

    init(request: URLRequest, service: NetworkServiceProtocol) {
        self.confirmationRequest = Single
            .just(request)

        self.validator = service.validator
    }
}
