//
//  PaymentMethodCellViewModel.swift
//  Podo
//
//  Created by m3g0byt3 on 16/04/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RxSwift

struct PaymentMethodCellViewModel: PaymentMethodCellViewModelProtocol,
                                   PaymentMethodCellViewModelInputProtocol,
                                   PaymentMethodCellViewModelOutputProtocol {

    // MARK: - PaymentMethodCellViewModelProtocol protocol conformance

    var input: PaymentMethodCellViewModelInputProtocol { return self }
    var output: PaymentMethodCellViewModelOutputProtocol { return self }

    // MARK: - PaymentMethodCellViewModelOutputProtocol protocol conformance

    let title: Observable<String>
    let iconBlob: Observable<Data>
    let isEnabled: Observable<Bool>
    let type: PaymentMethodType

    // MARK: - Initialization

    init(_ model: PaymentMethod) {
        self.title = Observable.just(model.type)
            .map { $0.rawValue }
            .map { $0.localized }

        self.iconBlob = Observable.just(model.imageBlob)
            .filterNil()

        self.isEnabled = Observable.just(model.isEnabled)

        self.type = model.type
    }
}
