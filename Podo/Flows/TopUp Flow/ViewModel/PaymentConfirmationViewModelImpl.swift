//
//  PaymentConfirmationViewModelImpl.swift
//  Podo
//
//  Created by m3g0byt3 on 21/06/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct PaymentConfirmationViewModelImpl: PaymentConfirmationViewModel {

    // MARK: - Properties

    private let models: [PaymentConfirmationSectionViewModelImpl] = [
        .paymentCardSection(title: R.string.localizable.paymentCardSection(),
                            items: [.paymentCardSectionItem(title: "payment")]),
        .transportCardSection(title: R.string.localizable.transportCardSection(),
                            items: [.transportCardSectionItem(title: "transport")]),
        .amountFieldSection(title: R.string.localizable.amountFieldSection(),
                            items: [.amountFieldSectionItem(title: "amount")])
    ]

    var sections: Driver<[PaymentConfirmationSectionViewModelImpl]> {
        return Driver.just(models)
    }
}
