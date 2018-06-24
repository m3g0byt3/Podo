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
        .paymentCardSection(title: "Payment Card Section",
                            items: [.paymentCardSectionItem(title: "payment")]),
        .transportCardSection(title: "Transport Card Section",
                            items: [.transportCardSectionItem(title: "transport")]),
        .amountFieldSection(title: "Amount Field Section",
                            items: [.amountFieldSectionItem(title: "amount")])
    ]

    var sections: Driver<[PaymentConfirmationSectionViewModelImpl]> {
        return Driver.just(models)
    }
}
