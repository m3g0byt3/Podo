//
//  PaymentCompositionViewModel.swift
//  Podo
//
//  Created by m3g0byt3 on 21/06/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RxSwift

struct PaymentCompositionViewModel: PaymentCompositionViewModelProtocol,
                                    PaymentCompositionViewModelInputProtocol,
                                    PaymentCompositionViewModelOutputProtocol {

    // MARK: - Private properties

    private let childViewModels: [PaymentCompositionSectionViewModelWrapper]

    // MARK: - PaymentCompositionViewModelProtocol protocol conformance

    var input: PaymentCompositionViewModelInputProtocol { return self }
    var output: PaymentCompositionViewModelOutputProtocol { return self }

    // MARK: - PaymentConfirmationViewModelOutputProtocol protocol conformance

    let isPaymentValid: Observable<Bool>
    var sections: Observable<[PaymentCompositionSectionViewModelWrapper]> {
        return Observable.just(childViewModels)
    }

    // MARK: - Initialization

    init(transportCardViewModel: TransportCardViewModelProtocol,
         paymentAmountViewModel: PaymentAmountCellViewModelProtocol,
         paymentCardViewModel: PaymentCardCellViewModelProtocol) {

        let isPaymentCardValid = paymentCardViewModel.output.isCardValid
        let isTransportCardValid = transportCardViewModel.output.isCardValid
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
