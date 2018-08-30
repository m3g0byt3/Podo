//
//  BSKNetworkService.swift
//  Podo
//
//  Created by m3g0byt3 on 06/08/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import BSK
import RxSwift
import Result

final class BSKNetworkService: NetworkServiceProtocol {

    // MARK: - Private properties

    private let adapter: BSKAdapter
    private let delegateForwarder = PublishSubject<Result<URLRequest, BSKError>>()

    // MARK: - Initialization

    init(_ adapter: BSKAdapter) {
        self.adapter = adapter
        self.validator = Single.just(adapter.webViewHandler)
        self.adapter.delegate = self
    }

    // MARK: - NetworkServiceProtocol protocol conformance

    let validator: Single<BSKWebViewHandlerProtocol>

    var paymentCompleted: Completable {
        return delegateForwarder
            .asObservable()
            .ignoreElements()
    }

    func topUp(
        transportCard: BSKTransportCard,
        from paymentType: BSKPaymentType,
        amount: Int
    ) -> Observable<Result<URLRequest, BSKError>> {
        adapter.topUpTransportCard(transportCard, from: paymentType, amount: amount)
        return delegateForwarder
    }
}

// MARK: - BSKTransactionDelegate protocol conformance

extension BSKNetworkService: BSKTransactionDelegate {

    func didReceiveConfirmationRequest(_ request: URLRequest) {
        delegateForwarder.onNext(.success(request))
    }

    func transactionDidFailWithError(_ error: BSKError) {
        delegateForwarder.onNext(.failure(error))
    }

    func transactionDidComplete() {
        delegateForwarder.onCompleted()
    }
}
