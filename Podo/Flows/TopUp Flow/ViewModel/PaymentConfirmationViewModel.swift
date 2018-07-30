//
//  PaymentConfirmationViewModel.swift
//  Podo
//
//  Created by m3g0byt3 on 21/06/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RxSwift

struct PaymentConfirmationViewModel: PaymentConfirmationViewModelProtocol {

    // MARK: - Private properties

    private let childViewModels: [PaymentConfirmationSectionViewModelWrapper]

    // MARK: - PaymentConfirmationViewModelProtocol protocol conformance

    let isPaymentValid: Observable<Bool>
    var sections: Observable<[PaymentConfirmationSectionViewModelWrapper]> {
        return Observable.just(childViewModels)
    }

    // MARK: - Initialization

    init(transportCardViewModel: TransportCardViewModelProtocol,
         paymentAmountViewModel: PaymentAmountCellViewModelProtocol,
         paymentCardViewModel: PaymentCardCellViewModelProtocol) {

        let isPaymentCardValid = paymentCardViewModel.output.isCardValid
        let isTransportCardValid = transportCardViewModel.isCardValid
        let isPaymentAmoundValid = paymentAmountViewModel.output.isAmountValid

        self.isPaymentValid = Observable
            .combineLatest(isTransportCardValid, isPaymentCardValid, isPaymentAmoundValid) { $0 && $1 && $2 }

        self.childViewModels = [.paymentCardSection(title: R.string.localizable.paymentCardSection(),
                                                    items: [.paymentCardSectionItem(viewModel: paymentCardViewModel)]),
                                .transportCardSection(title: R.string.localizable.transportCardSection(),
                                                      items: [.transportCardSectionItem(viewModel: transportCardViewModel)]),
                                .amountFieldSection(title: R.string.localizable.amountFieldSection(),
                                                    items: [.amountFieldSectionItem(viewModel: paymentAmountViewModel)])
        ]
    }
}
