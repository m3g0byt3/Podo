//
//  PaymentAmountCellButtonViewModelProtocol.swift
//  Podo
//
//  Created by m3g0byt3 on 27/07/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RxSwift

protocol PaymentAmountCellButtonViewModelProtocol {

    var input: PaymentAmountCellButtonViewModelInputProtocol { get }
    var output: PaymentAmountCellButtonViewModelOutputProtocol { get }
}

protocol PaymentAmountCellButtonViewModelInputProtocol {

    var selected: PublishSubject<Void> { get }
}

protocol PaymentAmountCellButtonViewModelOutputProtocol {

    var value: Observable<Int> { get }
    var title: String { get }
}
