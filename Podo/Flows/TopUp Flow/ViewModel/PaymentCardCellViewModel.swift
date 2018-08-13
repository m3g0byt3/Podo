//
//  PaymentCardCellViewModel.swift
//  Podo
//
//  Created by m3g0byt3 on 24/07/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RxSwift
import BSK

struct PaymentCardCellViewModel: PaymentCardCellViewModelProtocol,
                                 PaymentCardCellViewModelLinkProtocol,
                                 PaymentCardCellViewModelInputProtocol,
                                 PaymentCardCellViewModelOutputProtocol {

    // MARK: - Constants

    private static let cardNumberSeparator = " "
    private static let expiryDateSeparator = "/"
    private static let expiryCount = 2
    private static let chunkSize = 4
    private static let cvcNumberLength = 3
    private static let cardNumberLength = 16
    // `expiryDateLength` constant includes separator(s)
    private static let expiryDateLength = 7

    // MARK: - PaymentCardCellViewModelProtocol protocol conformance

    var input: PaymentCardCellViewModelInputProtocol { return self }
    var output: PaymentCardCellViewModelOutputProtocol { return self }
    var link: PaymentCardCellViewModelLinkProtocol { return self }

    // MARK: - PaymentCardCellViewModelLinkProtocol protocol conformance

    let model: Observable<BSKPaymentMethod.CreditCard>

    // MARK: - PaymentCardCellViewModelInputProtocol protocol conformance

    let cardNumberInput: PublishSubject<String>
    let cvcNumberInput: PublishSubject<String>
    let expiryDateInput: PublishSubject<String>

    // MARK: - PaymentCardCellViewModelOutputProtocol protocol conformance

    let isCardValid: Observable<Bool>

    let cardTitle: Single<String>

    let cardNumberOutput: Observable<String>
    let cardNumberLabel: Single<String>
    let cardNumberPlaceholder: Single<String>

    let cvcNumberOutput: Observable<String>
    let cvcNumberLabel: Single<String>
    let cvcNumberPlaceholder: Single<String>

    let expiryDateOutput: Observable<String>
    let expiryDateLabel: Single<String>
    let expiryDatePlaceholder: Single<String>

    // MARK: - Initialization

    init() {
        // swiftlint:disable:previous function_body_length

        // MARK: - Inputs

        self.cardNumberInput = PublishSubject<String>()
        self.expiryDateInput = PublishSubject<String>()
        self.cvcNumberInput = PublishSubject<String>()

        // MARK: - Labels

        self.cardTitle = Single
            .just(R.string.localizable.cardCellTitle())

        self.cardNumberLabel = Single
            .just(R.string.localizable.cardCellNumberLabel())

        self.expiryDateLabel = Single
            .just(R.string.localizable.cardCellExpirationLabel())

        self.cvcNumberLabel = Single
            .just(R.string.localizable.cardCellCvvLabel())

        // MARK: - Placeholders

        self.cardNumberPlaceholder = Single
            .just("0000 0000 0000 0000")

        self.expiryDatePlaceholder = Single
            .just("00/0000")

        self.cvcNumberPlaceholder = Single
            .just("000")

        // MARK: - Outputs

        let filteredCardNumber = self.cardNumberInput
            .filterNonNumeric()
            .map { $0.prefix(PaymentCardCellViewModel.cardNumberLength) }
            .map { String($0) }
            .share(replay: 1, scope: .whileConnected)

        self.cardNumberOutput = filteredCardNumber
            .map { $0.split(size: PaymentCardCellViewModel.chunkSize, separator: PaymentCardCellViewModel.cardNumberSeparator) }

        self.expiryDateOutput = self.expiryDateInput
            .filterNonNumeric()
            .map { "00" + $0 }
            .map { $0.split(size: PaymentCardCellViewModel.chunkSize, separator: PaymentCardCellViewModel.expiryDateSeparator) }
            .map { $0.dropFirst(2) }
            .map { $0.prefix(PaymentCardCellViewModel.expiryDateLength) }
            .map { String($0) }

        self.cvcNumberOutput = self.cvcNumberInput
            .filterNonNumeric()
            .map { $0.prefix(PaymentCardCellViewModel.cvcNumberLength) }
            .map { String($0) }

        let model = Observable
            .combineLatest(filteredCardNumber, self.expiryDateOutput, self.cvcNumberOutput)
            .flatMap(PaymentCardCellViewModel.createPaymentCardModel)

        self.model = model
            .filterNil()

        self.isCardValid = model
            .mapNil()
            .startWith(false)
    }

    // MARK: - Private API

    private static func createPaymentCardModel(_ number: String,
                                               _ expiration: String,
                                               _ cvv: String) -> Observable<BSKPaymentMethod.CreditCard?> {
        let expiry = expiration
            .components(separatedBy: PaymentCardCellViewModel.expiryDateSeparator)
            .compactMap(UInt.init)

        guard
            expiry.count == PaymentCardCellViewModel.expiryCount,
            let month = expiry.first,
            let year = expiry.last,
            let card = BSKPaymentMethod.CreditCard(cardNumber: number, expiryMonth: month, expiryYear: year, cvv: cvv)
        else { return .just(nil) }

        return .just(card)
    }
}
