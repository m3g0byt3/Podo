//
//  PaymentCardCellViewModelProtocol.swift
//  Podo
//
//  Created by m3g0byt3 on 06/07/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RxSwift

protocol PaymentCardCellViewModelProtocol {

    var input: PaymentCardCellViewModelInputProtocol { get }
    var output: PaymentCardCellViewModelOutputProtocol { get }
}

protocol PaymentCardCellViewModelInputProtocol {

    var cardNumber: PublishSubject<String> { get }
    var cvcNumber: PublishSubject<String> { get }
    var expiryDate: PublishSubject<String> { get }
}

protocol PaymentCardCellViewModelOutputProtocol {

    var isCardValid: Observable<Bool> { get }

    var cardTitle: Single<String> { get }

    var cardNumberText: Observable<String> { get }
    var cardNumberLabel: Single<String> { get }
    var cardNumberPlaceholder: Single<String> { get }

    var cvcNumberText: Observable<String> { get }
    var cvcNumberLabel: Single<String> { get }
    var cvcNumberPlaceholder: Single<String> { get }

    var expiryDateText: Observable<String> { get }
    var expiryDateLabel: Single<String> { get }
    var expiryDatePlaceholder: Single<String> { get }
}
