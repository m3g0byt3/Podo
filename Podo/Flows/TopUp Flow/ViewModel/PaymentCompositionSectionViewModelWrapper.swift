//
//  PaymentCompositionSectionViewModelWrapper.swift
//  Podo
//
//  Created by m3g0byt3 on 21/06/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RxDataSources

// swiftlint:disable:next type_name
enum PaymentCompositionSectionViewModelWrapper {
    case transportCardSection(title: String, items: [PaymentCompositionSectionItemViewModelWrapper])
    case paymentCardSection(title: String, items: [PaymentCompositionSectionItemViewModelWrapper])
    case amountFieldSection(title: String, items: [PaymentCompositionSectionItemViewModelWrapper])
}

extension PaymentCompositionSectionViewModelWrapper: SectionModelType {

    var items: [PaymentCompositionSectionItemViewModelWrapper] {
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

    init(original: PaymentCompositionSectionViewModelWrapper, items: [PaymentCompositionSectionItemViewModelWrapper]) {
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
