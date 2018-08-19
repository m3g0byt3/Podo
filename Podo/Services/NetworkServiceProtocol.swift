//
//  NetworkServiceProtocol.swift
//  Podo
//
//  Created by m3g0byt3 on 28/02/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RxSwift
import BSK
import Result

protocol NetworkServiceProtocol {

    func topUp(
        transportCard: BSKTransportCard,
        from paymentType: BSKPaymentType,
        amount: Int
    ) -> Observable<Result<URLRequest, BSKError>>

    var validator: Single<BSKWebViewHandlerProtocol> { get }
}
