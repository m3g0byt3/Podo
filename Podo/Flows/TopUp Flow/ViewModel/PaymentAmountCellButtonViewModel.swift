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

    // MARK: - PaymentAmountCellButtonViewModelProtocol protocol conformance

    var input: PaymentAmountCellButtonViewModelInputProtocol { return self }
    var output: PaymentAmountCellButtonViewModelOutputProtocol { return self }
    let selected: PublishSubject<Void>
    let title: Observable<String>

    // MARK: - Initialization

    init(value: Int, sign: String) {
        let title = String(value).appending(sign)

        self.selected = PublishSubject<Void>()

        self.title = self.selected
            .asObservable()
            .map { title }
            .startWith(title)
    }
}
