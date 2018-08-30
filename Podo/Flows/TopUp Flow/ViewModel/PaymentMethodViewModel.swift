//
//  PaymentMethodViewModel.swift
//  Podo
//
//  Created by m3g0byt3 on 16/04/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RxSwift

final class PaymentMethodViewModel: PaymentMethodViewModelProtocol,
                                    PaymentMethodViewModelInputProtocol,
                                    PaymentMethodViewModelOutputProtocol {

    // MARK: - Constants

    private static var filterPredicate: NSPredicate = {
        let lhs = NSExpression(forKeyPath: \PaymentMethod.isVisible)
        let rhs = NSExpression(forConstantValue: true)
        return NSComparisonPredicate(leftExpression: lhs,
                                     rightExpression: rhs,
                                     modifier: .direct,
                                     type: .equalTo)
    }()

    // MARK: - Properties

    private let model: AnyDatabaseService<PaymentMethod>

    // MARK: - PaymentMethodViewModelProtocol protocol conformance

    var input: PaymentMethodViewModelInputProtocol { return self }
    var output: PaymentMethodViewModelOutputProtocol { return self }

    // MARK: - PaymentMethodViewModelOutputProtocol protocol conformance

    let title: Observable<String>

    lazy var paymentMethods: Observable<[PaymentMethodCellViewModelProtocol]> = {
        let predicate = PaymentMethodViewModel.filterPredicate
        return model.itemsObservable(isCompleted: true, predicate: predicate)
            .map { $0.map(PaymentMethodCellViewModel.init) }
            .share()
    }()

    // MARK: - Initialization

    init(_ model: AnyDatabaseService<PaymentMethod>) {
        self.title = Observable.just(R.string.localizable.paymentSelectionTitle())
        self.model = model
    }
}
