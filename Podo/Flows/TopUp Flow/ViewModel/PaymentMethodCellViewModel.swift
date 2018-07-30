//
//  PaymentMethodCellViewModel.swift
//  Podo
//
//  Created by m3g0byt3 on 16/04/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit.UIImage
import RxSwift

struct PaymentMethodCellViewModel: PaymentMethodCellViewModelProtocol {

    // MARK: - PaymentMethodCellViewModelProtocol protocol conformance

    let title: Observable<String>
    let icon: Observable<UIImage>
    let type: PaymentMethodType

    // MARK: - Initialization

    init(_ model: PaymentMethod) {
        self.title = Observable.just(model.type)
            .map { $0.rawValue }
            .map { $0.localized }

        self.icon = Observable.just(model.imageBlob)
            .filterNil()
            .map(UIImage.init)
            .filterNil()

        self.type = model.type
    }
}
