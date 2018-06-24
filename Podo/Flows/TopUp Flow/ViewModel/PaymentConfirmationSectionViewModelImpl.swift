//
//  PaymentConfirmationSectionViewModelImpl.swift
//  Podo
//
//  Created by m3g0byt3 on 21/06/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RxDataSources

enum PaymentConfirmationSectionViewModelImpl {
    // swiftlint:disable identifier_name
    case transportCardSection(title: String, items: [PaymentConfirmationSectionItemViewModelImpl])
    case paymentCardSection(title: String, items: [PaymentConfirmationSectionItemViewModelImpl])
    case amountFieldSection(title: String, items: [PaymentConfirmationSectionItemViewModelImpl])
}

extension PaymentConfirmationSectionViewModelImpl: SectionModelType {

    var items: [PaymentConfirmationSectionItemViewModelImpl] {
        switch self {
        case .transportCardSection(_, items: let items): return items
        case .paymentCardSection(_, items: let items): return items
        case .amountFieldSection(_, items: let items): return items
        }
    }

    var headerTitle: String {
        switch self {
        case .transportCardSection(let title, _): return title
        case .amountFieldSection(let title, _): return title
        case .paymentCardSection(let title, _): return title
        }
    }

    init(original: PaymentConfirmationSectionViewModelImpl, items: [PaymentConfirmationSectionItemViewModelImpl]) {
        switch original {
        case .transportCardSection(title: let title, _):
            self = .transportCardSection(title: title, items: items)
        case .paymentCardSection(title: let title, _):
            self = .paymentCardSection(title: title, items: items)
        case .amountFieldSection(title: let title, _):
            self = .amountFieldSection(title: title, items: items)
        }
    }
}
