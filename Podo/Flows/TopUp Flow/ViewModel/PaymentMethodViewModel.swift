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

    // MARK: - Properties

    private let model: AnyDatabaseService<PaymentMethod>

    // MARK: - PaymentMethodViewModelProtocol protocol conformance

    var input: PaymentMethodViewModelInputProtocol { return self }
    var output: PaymentMethodViewModelOutputProtocol { return self }

    // MARK: - PaymentMethodViewModelOutputProtocol protocol conformance

    let title: Observable<String>

    lazy var paymentMethods: Observable<[PaymentMethodCellViewModelProtocol]> = {
        return Observable.create { [weak self] observer in
            do {
                let predicate = PaymentMethodViewModel.filterPredicate
                try self?.model.fetch(predicate: predicate, sorted: nil) { methods in
                    let viewModels = methods.map(PaymentMethodCellViewModel.init)
                    observer.onNext(viewModels)
                    observer.onCompleted()
                }
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }()

    // MARK: - Initialization

    init(_ model: AnyDatabaseService<PaymentMethod>) {
        self.title = Observable.just(R.string.localizable.paymentSelectionTitle())
        self.model = model
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
