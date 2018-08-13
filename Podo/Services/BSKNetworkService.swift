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

final class BSKNetworkService {

    private let adapter: BSKAdapter

    init(_ adapter: BSKAdapter) {
        self.adapter = adapter
    }
}

extension BSKNetworkService: NetworkServiceProtocol {

    func topUp(
        transportCard: BSKTransportCard,
        from paymentType: BSKPaymentType,
        amount: Int
    ) -> Observable<Result<URLRequest, BSKError>> {
        adapter.topUpTransportCard(transportCard, from: paymentType, amount: amount)

        let success: Observable<Result<URLRequest, BSKError>> = adapter.rx.confirmationRequest
            .map(Result.success)

        let failure: Observable<Result<URLRequest, BSKError>> = adapter.rx.transactionFailed
            .map(Result.failure)

        return Observable.merge(success, failure)
    }
}
