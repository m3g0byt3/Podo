//
//  AddNewCardViewModel.swift
//  Podo
//
//  Created by m3g0byt3 on 27/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RxSwift

final class AddNewCardViewModel: AddNewCardViewModelProtocol,
                                 AddNewCardViewModelInputProtocol,
                                 AddNewCardViewModelOutputProtocol {

    // MARK: - Constants

    // Without static prefix (8 chars) and with spaces (4 chars)
    private static let cardNumberMaxLength = TransportCardType.podorozhnikLong.rawValue - 8 + 4
    private static let chunkSize = 4

    // MARK: - AddNewCardViewModelProtocol protocol conformance

    var input: AddNewCardViewModelInputProtocol { return self }
    var output: AddNewCardViewModelOutputProtocol { return self }

    // MARK: - AddNewCardViewModelInputProtocol protocol conformance

    let cardNumberInput = PublishSubject<String>()
    let themeChanged = PublishSubject<Int>()
    let saveState = PublishSubject<Void>()

    // MARK: - AddNewCardViewModelOutputProtocol protocol conformance

    let cardNumberOutput: Observable<String>
    let cardNumberPrefix: Single<String>
    let cardNumberPlaceholder: Single<String>
    let cardTheme: Observable<TransportCardTheme>
    let isCardValid: Observable<Bool>

    // MARK: - Properties

    private let model: AnyDatabaseService<TransportCard>
    private let card: Observable<TransportCard?>
    private let reportingService: ReportingServiceProtocol
    private let disposeBag = DisposeBag()

    // MARK: - Initialization

    init(model: AnyDatabaseService<TransportCard>, reportingService: ReportingServiceProtocol) {
        self.model = model

        self.reportingService = reportingService

        self.cardNumberPrefix = Single
            .just("9643 3078 ")

        self.cardNumberPlaceholder = Single
            .just("0000 0000 000(0 0000 00)")

        self.cardNumberOutput = self.cardNumberInput
            .asObservable()
            .filterNonNumeric()
            .map { $0.split(size: AddNewCardViewModel.chunkSize, separator: Constant.Placeholder.space) }
            .map { $0.prefix(AddNewCardViewModel.cardNumberMaxLength) }
            .map(String.init)
            .share()

        let fullCardNumber = Observable
            .combineLatest(self.cardNumberPrefix.asObservable(), self.cardNumberOutput)
            .map(+)
            .map { $0.replacingOccurrences(of: Constant.Placeholder.space, with: Constant.Placeholder.empty) }

        self.cardTheme = self.themeChanged
            .asObservable()
            .startWith(0)
            .map { TransportCardTheme(rawValue: $0) ?? .green }
            .distinctUntilChanged()

        self.card = Observable
            .combineLatest(fullCardNumber, self.cardTheme)
            .flatMap(AddNewCardViewModel.mapTransportCard)
            .distinctUntilChanged()
            .share()

        self.isCardValid = self.card
            .asObservable()
            .mapNil()
            .distinctUntilChanged()

        _ = self.saveState
            .asObservable()
            .withLatestFrom(self.card)
            .filterNil()
            .subscribe(onNext: { [weak self] card in
                let identifier = String(describing: card)
                self?.reportingService.report(event: .transportCardAdded(identifier: identifier))
                try? self?.model.save(item: card)
            })
            .disposed(by: disposeBag)
    }

    // MARK: - Private API

    private static func mapTransportCard(number: String, theme: TransportCardTheme) -> Observable<TransportCard?> {
        let card = TransportCard(cardNumber: number)

        card?.themeIdentifier = theme.rawValue

        return .just(card)
    }
}
