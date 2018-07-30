//
//  PaymentMethodViewModel.swift
//  Podo
//
//  Created by m3g0byt3 on 16/04/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class PaymentMethodViewModel: PaymentMethodViewModelProtocol {

    // MARK: - Properties

    private let model: AnyDatabaseService<PaymentMethod>
    private let viewModels: BehaviorRelay<[PaymentMethodCellViewModelProtocol]>

    // MARK: - PaymentMethodViewModelProtocol protocol conformance

    let title: Driver<String>
    var paymentMethods: Driver<[PaymentMethodCellViewModelProtocol]> {
        return viewModels.asDriver()
    }

    // MARK: - Initialization

    init(_ model: AnyDatabaseService<PaymentMethod>) {
        self.title = Driver.just(R.string.localizable.paymentSelectionTitle())
        self.viewModels = BehaviorRelay(value: [PaymentMethodCellViewModelProtocol]())
        self.model = model
        try? model.fetch(predicate: PaymentMethodViewModel.filterPredicate, sorted: nil) { [weak self] result in
            let viewModels = result.map(PaymentMethodCellViewModel.init)
            self?.viewModels.accept(viewModels)
        }
    }

    // MARK: - Private API

    private static var filterPredicate: NSPredicate = {
        let lhs = NSExpression(forKeyPath: \PaymentMethod.isEnabled)
        let rhs = NSExpression(forConstantValue: true)
        return NSComparisonPredicate(leftExpression: lhs,
                                     rightExpression: rhs,
                                     modifier: .direct,
                                     type: .equalTo)
    }()
}
