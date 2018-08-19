//
//  PaymentConfirmationViewModelProtocol.swift
//  Podo
//
//  Created by m3g0byt3 on 06/08/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RxSwift
import BSK

protocol PaymentConfirmationViewModelProtocol {

    var input: PaymentConfirmationViewModelInputProtocol { get }
    var output: PaymentConfirmationViewModelOutputProtocol { get }
}

protocol PaymentConfirmationViewModelInputProtocol {}

protocol PaymentConfirmationViewModelOutputProtocol {

    var confirmationRequest: Single<URLRequest> { get }
    var validator: Single<BSKWebViewHandlerProtocol> { get }
}
