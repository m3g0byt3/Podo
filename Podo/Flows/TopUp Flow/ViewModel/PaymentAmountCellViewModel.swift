//
//  PaymentAmountCellViewModel.swift
//  Podo
//
//  Created by m3g0byt3 on 25/07/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RxSwift

struct PaymentAmountCellViewModel: PaymentAmountCellViewModelProtocol,
                                    PaymentAmountCellViewModelInputProtocol,
                                    PaymentAmountCellViewModelOutputProtocol {

    // MARK: - Constants

    private static let minTopUpAmount = 1
    private static let maxTopUpAmount = 14_500
    private static let currencySign = "₽"
    private static let placeholder = "0".appending(PaymentAmountCellViewModel.currencySign)
    private static let notNumericSet = CharacterSet.decimalDigits.inverted
    private static let notNumericReplacement = ""
    private static let buttonViewModelRange = [1.0, 2.5, 5.0]
    private static let buttonViewModelMultiplier = 100.0

    // MARK: - PaymentAmountCellViewModelProtocol protocol conformance

    var input: PaymentAmountCellViewModelInputProtocol { return self }
    var output: PaymentAmountCellViewModelOutputProtocol { return self }
    let buttonViewModels: Observable<PaymentAmountCellButtonViewModelProtocol>
    let amountInput: PublishSubject<String>
    let amountOutput: Observable<String>
    let isAmountValid: Observable<Bool>
    let placeholder: Single<String>

    // MARK: - Initialization

    init() {
        self.placeholder = Single
            .just(PaymentAmountCellViewModel.placeholder)

        self.amountInput = PublishSubject<String>()

        let buttonViewModels = PaymentAmountCellViewModel.buttonViewModelRange
            .map { $0 * PaymentAmountCellViewModel.buttonViewModelMultiplier }
            .map { Int($0) }
            .map { PaymentAmountCellButtonViewModel(value: $0) }

        self.buttonViewModels = Observable.from(buttonViewModels)

        self.amountOutput = self.amountInput
            .asObservable()
            .map { $0.replacingOccurrences(of: PaymentAmountCellViewModel.notNumericSet,
                                           with: PaymentAmountCellViewModel.notNumericReplacement)
            }
            .map { $0.isEmpty ? $0 : String($0).appending(PaymentAmountCellViewModel.currencySign) }

        self.isAmountValid = self.amountOutput
            .map { $0.dropLast() }
            .map { Int($0) }
            .filterNil()
            .map { $0 >= PaymentAmountCellViewModel.minTopUpAmount && $0 <= PaymentAmountCellViewModel.maxTopUpAmount }
            .startWith(false)
    }
}
