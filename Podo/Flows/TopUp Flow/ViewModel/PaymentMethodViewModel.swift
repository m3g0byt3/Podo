//
//  PaymentMethodViewModel.swift
//  Podo
//
//  Created by m3g0byt3 on 16/04/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

// Still imports RxCocoa because BehaviorRelay not available without RxCocoa until RxSwift 5.0
// See https://github.com/ReactiveX/RxSwift/issues/1501 and https://github.com/ReactiveX/RxSwift/issues/1502
import Foundation
import RxSwift
import class RxCocoa.BehaviorRelay

final class PaymentMethodViewModel: PaymentMethodViewModelProtocol,
                                    PaymentMethodViewModelInputProtocol,
                                    PaymentMethodViewModelOutputProtocol {

    // MARK: - Properties

    private let model: AnyDatabaseService<PaymentMethod>
    private let viewModels: BehaviorRelay<[PaymentMethodCellViewModelProtocol]>

    // MARK: - PaymentMethodViewModelProtocol protocol conformance

    var input: PaymentMethodViewModelInputProtocol { return self }
    var output: PaymentMethodViewModelOutputProtocol { return self }

    // MARK: - PaymentMethodViewModelOutputProtocol protocol conformance

    let title: Observable<String>
    var paymentMethods: Observable<[PaymentMethodCellViewModelProtocol]> {
        return viewModels.asObservable()
    }

    // MARK: - Initialization

    init(_ model: AnyDatabaseService<PaymentMethod>) {
        self.title = Observable.just(R.string.localizable.paymentSelectionTitle())
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
