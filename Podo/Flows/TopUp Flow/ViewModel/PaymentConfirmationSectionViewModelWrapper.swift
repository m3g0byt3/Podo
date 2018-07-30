//
//  PaymentConfirmationSectionViewModelWrapper.swift
//  Podo
//
//  Created by m3g0byt3 on 21/06/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RxDataSources

enum PaymentConfirmationSectionViewModelWrapper {
    // swiftlint:disable:previous type_name
    // swiftlint:disable identifier_name
    case transportCardSection(title: String, items: [PaymentConfirmationSectionItemViewModelWrapper])
    case paymentCardSection(title: String, items: [PaymentConfirmationSectionItemViewModelWrapper])
    case amountFieldSection(title: String, items: [PaymentConfirmationSectionItemViewModelWrapper])
}

extension PaymentConfirmationSectionViewModelWrapper: SectionModelType {

    var items: [PaymentConfirmationSectionItemViewModelWrapper] {
        switch self {
        case .transportCardSection(_, let items): return items
        case .paymentCardSection(_, let items): return items
        case .amountFieldSection(_, let items): return items
        }
    }

    var headerTitle: String {
        switch self {
        case .transportCardSection(let title, _): return title
        case .amountFieldSection(let title, _): return title
        case .paymentCardSection(let title, _): return title
        }
    }

    init(original: PaymentConfirmationSectionViewModelWrapper, items: [PaymentConfirmationSectionItemViewModelWrapper]) {
        switch original {
        case .transportCardSection(let title, _):
            self = .transportCardSection(title: title, items: items)
        case .paymentCardSection(let title, _):
            self = .paymentCardSection(title: title, items: items)
        case .amountFieldSection(let title, _):
            self = .amountFieldSection(title: title, items: items)
        }
    }
}
