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

    // MARK: - Private properties

    private let models: [PaymentConfirmationSectionViewModelImpl]

    // MARK: - PaymentConfirmationViewModel protocol conformance
    
    var sections: Driver<[PaymentConfirmationSectionViewModelImpl]> {
        return Driver.just(models)
    }

    // MARK: - Initialization

    init(transportCardViewModel: CardsCellViewModel) {
        models = [.paymentCardSection(title: R.string.localizable.paymentCardSection(),
                                      items: [.paymentCardSectionItem]),
                  .transportCardSection(title: R.string.localizable.transportCardSection(),
                                        items: [.transportCardSectionItem(innerViewModel: transportCardViewModel)]),
                  .amountFieldSection(title: R.string.localizable.amountFieldSection(),
                                      items: [.amountFieldSectionItem])
        ]
    }
}
