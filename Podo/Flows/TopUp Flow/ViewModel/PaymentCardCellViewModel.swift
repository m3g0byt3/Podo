//
//  PaymentCardCellViewModel.swift
//  Podo
//
//  Created by m3g0byt3 on 24/07/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RxSwift

struct PaymentCardCellViewModel: PaymentCardCellViewModelProtocol,
                                 PaymentCardCellViewModelInputProtocol,
                                 PaymentCardCellViewModelOutputProtocol {

    // MARK: - Constants

    private static let cardNumberSeparator = " "
    private static let expiryDateSeparator = "/"
    private static let chunkSize = 4
    private static let cvcNumberLength = 3
    // All length constants below include separators
    private static let cardNumberLength = 19
    private static let expiryDateLength = 7

    // MARK: - PaymentCardCellViewModelProtocol protocol conformance

    var input: PaymentCardCellViewModelInputProtocol { return self }
    var output: PaymentCardCellViewModelOutputProtocol { return self }

    // MARK: - PaymentCardCellViewModelInputProtocol protocol conformance

    let cardNumber: PublishSubject<String>
    let cvcNumber: PublishSubject<String>
    let expiryDate: PublishSubject<String>

    // MARK: - PaymentCardCellViewModelOutputProtocol protocol conformance

    let isCardValid: Observable<Bool>

    let cardTitle: Single<String>

    let cardNumberText: Observable<String>
    let cardNumberLabel: Single<String>
    let cardNumberPlaceholder: Single<String>

    let cvcNumberText: Observable<String>
    let cvcNumberLabel: Single<String>
    let cvcNumberPlaceholder: Single<String>

    let expiryDateText: Observable<String>
    let expiryDateLabel: Single<String>
    let expiryDatePlaceholder: Single<String>

    // MARK: - Initialization

    init() {
        // swiftlint:disable:previous function_body_length
        self.cardNumber = PublishSubject<String>()

        self.cvcNumber = PublishSubject<String>()

        self.expiryDate = PublishSubject<String>()

        self.cardTitle = Single
            .just(R.string.localizable.cardCellTitle())

        self.cardNumberText = self.cardNumber
            .filterNonNumeric()
            .map { $0.split(size: PaymentCardCellViewModel.chunkSize, separator: PaymentCardCellViewModel.cardNumberSeparator) }
            .map { $0.prefix(PaymentCardCellViewModel.cardNumberLength) }
            .map { String($0) }

        self.cardNumberLabel = Single
            .just(R.string.localizable.cardCellNumberLabel())

        self.cardNumberPlaceholder = Single
            .just("0000 0000 0000 0000")

        self.cvcNumberText = self.cvcNumber
            .filterNonNumeric()
            .map { $0.prefix(PaymentCardCellViewModel.cvcNumberLength) }
            .map { String($0) }

        self.cvcNumberLabel = Single
            .just(R.string.localizable.cardCellCvvLabel())

        self.cvcNumberPlaceholder = Single
            .just("000")

        self.expiryDateText = self.expiryDate
            .filterNonNumeric()
            .map { "00" + $0 }
            .map { $0.split(size: PaymentCardCellViewModel.chunkSize, separator: PaymentCardCellViewModel.expiryDateSeparator) }
            .map { $0.dropFirst(2) }
            .map { $0.prefix(PaymentCardCellViewModel.expiryDateLength) }
            .map { String($0) }

        self.expiryDateLabel = Single
            .just(R.string.localizable.cardCellExpirationLabel())

        self.expiryDatePlaceholder = Single
            .just("00/0000")

        let isCardNumberValid = self.cardNumberText
            .map { $0.count == PaymentCardCellViewModel.cardNumberLength }
            .distinctUntilChanged()

        let isExpiryDateValid = self.expiryDateText
            .map { $0.count == PaymentCardCellViewModel.expiryDateLength }
            .distinctUntilChanged()

        let isCVCNumberValid = self.cvcNumberText
            .map { $0.count == PaymentCardCellViewModel.cvcNumberLength }
            .distinctUntilChanged()

        self.isCardValid = Observable
            .combineLatest(isCardNumberValid, isExpiryDateValid, isCVCNumberValid) { $0 && $1 && $2 }
            .distinctUntilChanged()
    }
}
