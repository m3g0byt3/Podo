//
//  PaymentConfirmationViewModelImpl.swift
//  Podo
//
//  Created by m3g0byt3 on 21/06/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RxSwift

struct PaymentConfirmationViewModelImpl: PaymentConfirmationViewModel {

    // MARK: - Private properties

    private let models: [PaymentConfirmationSectionViewModelImpl]

    // MARK: - PaymentConfirmationViewModel protocol conformance

    let isPaymentValid: Observable<Bool>
    var sections: Observable<[PaymentConfirmationSectionViewModelImpl]> {
        return Observable.just(models)
    }

    // MARK: - Initialization

    init(transportCardViewModel: TransportCardViewModelProtocol) {
        self.isPaymentValid = PaymentConfirmationViewModelImpl
            .isValid()

        self.models = [.paymentCardSection(title: R.string.localizable.paymentCardSection(),
                                      items: [.paymentCardSectionItem]),
                  .transportCardSection(title: R.string.localizable.transportCardSection(),
                                        items: [.transportCardSectionItem(innerViewModel: transportCardViewModel)]),
                  .amountFieldSection(title: R.string.localizable.amountFieldSection(),
                                      items: [.amountFieldSectionItem])
        ]
    }

    private static func isValid() -> Observable<Bool> {
        return Observable.create { observer in
            // TODO: replace with real logic!
            return Disposables.create()
        }
    }
}
