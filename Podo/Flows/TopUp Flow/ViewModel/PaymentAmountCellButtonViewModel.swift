//
//  PaymentAmountCellButtonViewModel.swift
//  Podo
//
//  Created by m3g0byt3 on 27/07/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RxSwift

struct PaymentAmountCellButtonViewModel: PaymentAmountCellButtonViewModelProtocol,
                                            PaymentAmountCellButtonViewModelInputProtocol,
                                            PaymentAmountCellButtonViewModelOutputProtocol {

    // MARK: - Constants

    private static let currencySign = "₽"

    // MARK: - PaymentAmountCellButtonViewModelProtocol protocol conformance

    var input: PaymentAmountCellButtonViewModelInputProtocol { return self }
    var output: PaymentAmountCellButtonViewModelOutputProtocol { return self }
    let selected: PublishSubject<Void>
    // TODO: Use single value instead `value` and `title`
    let value: Observable<Int>
    let title: String

    // MARK: - Initialization

    init(value: Int) {
        self.selected = PublishSubject<Void>()

        self.value = self.selected
            .asObservable()
            .map { value }

        self.title = String(value).appending(PaymentAmountCellButtonViewModel.currencySign)
    }
}
