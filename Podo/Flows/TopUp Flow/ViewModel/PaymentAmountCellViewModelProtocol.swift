//
//  PaymentAmountCellViewModelProtocol.swift
//  Podo
//
//  Created by m3g0byt3 on 25/07/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RxSwift

protocol PaymentAmountCellViewModelProtocol {

    var input: PaymentAmountCellViewModelInputProtocol { get }
    var output: PaymentAmountCellViewModelOutputProtocol { get }
}

protocol PaymentAmountCellViewModelInputProtocol {

    var amountInput: PublishSubject<String> { get }
}

protocol PaymentAmountCellViewModelOutputProtocol {

    var buttonViewModels: Observable<PaymentAmountCellButtonViewModelProtocol> { get }
    var amountOutput: Observable<String> { get }
    var isAmountValid: Observable<Bool> { get }
    var placeholder: Single<String> { get }
}
