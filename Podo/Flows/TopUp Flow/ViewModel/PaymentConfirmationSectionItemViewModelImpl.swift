//
//  PaymentConfirmationSectionItemViewModelImpl.swift
//  Podo
//
//  Created by m3g0byt3 on 21/06/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//
// swiftlint:disable identifier_name type_name

import Foundation

enum PaymentConfirmationSectionItemViewModelImpl {

    case transportCardSectionItem(innerViewModel: TransportCardViewModelProtocol)
    case paymentCardSectionItem
    case amountFieldSectionItem
}
