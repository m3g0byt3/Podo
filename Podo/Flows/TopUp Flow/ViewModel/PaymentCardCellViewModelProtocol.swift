//
//  PaymentCardCellViewModelProtocol.swift
//  Podo
//
//  Created by m3g0byt3 on 06/07/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RxSwift
import BSK

protocol PaymentCardCellViewModelProtocol {

    var input: PaymentCardCellViewModelInputProtocol { get }
    var output: PaymentCardCellViewModelOutputProtocol { get }
    var link: PaymentCardCellViewModelLinkProtocol { get }
}

protocol PaymentCardCellViewModelInputProtocol {

    var cardNumberInput: PublishSubject<String> { get }
    var cvcNumberInput: PublishSubject<String> { get }
    var expiryDateInput: PublishSubject<String> { get }
}

protocol PaymentCardCellViewModelOutputProtocol {

    var isCardValid: Observable<Bool> { get }

    var cardTitle: Single<String> { get }

    var cardNumberOutput: Observable<String> { get }
    var cardNumberLabel: Single<String> { get }
    var cardNumberPlaceholder: Single<String> { get }

    var cvcNumberOutput: Observable<String> { get }
    var cvcNumberLabel: Single<String> { get }
    var cvcNumberPlaceholder: Single<String> { get }

    var expiryDateOutput: Observable<String> { get }
    var expiryDateLabel: Single<String> { get }
    var expiryDatePlaceholder: Single<String> { get }
}

protocol PaymentCardCellViewModelLinkProtocol {

    var model: Observable<BSKPaymentMethod.CreditCard> { get }
}
