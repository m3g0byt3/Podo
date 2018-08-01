//
//  PaymentConfirmationSectionItemViewModelWrapper.swift
//  Podo
//
//  Created by m3g0byt3 on 21/06/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

// swiftlint:disable:next type_name
enum PaymentConfirmationSectionItemViewModelWrapper {

    case transportCardSectionItem(viewModel: TransportCardViewModelProtocol)
    case paymentCardSectionItem(viewModel: PaymentCardCellViewModelProtocol)
    case amountFieldSectionItem(viewModel: PaymentAmountCellViewModelProtocol)
}
