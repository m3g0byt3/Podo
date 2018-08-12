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

    // MARK: - AddNewCardViewModelProtocol protocol conformance

    var input: AddNewCardViewModelInputProtocol { return self }
    var output: AddNewCardViewModelOutputProtocol { return self }

    // MARK: - AddNewCardViewModelInputProtocol protocol conformance

    let cardNumber = PublishSubject<String>()
    let themeChanged = PublishSubject<Int>()
    let saveState = PublishSubject<Void>()

    // MARK: - AddNewCardViewModelOutputProtocol protocol conformance

    let cardNumberText: Observable<String>
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

        self.cardNumberText = cardNumber
            .filterNonNumeric()

        self.cardTheme = themeChanged
            .asObservable()
            .startWith(0)
            .map { TransportCardTheme(rawValue: $0) ?? .green }
            .distinctUntilChanged()

        self.card = Observable
            .combineLatest(cardNumberText.asObservable(), cardTheme.asObservable()) { number, theme in
                let card = TransportCard(cardNumber: number)
                card?.themeIdentifier = theme.rawValue
                return card
            }
            .distinctUntilChanged()
            .share()

        self.isCardValid = card
            .asObservable()
            .map { $0 != nil }
            .distinctUntilChanged()

        // TODO: remove subscription (use Action instead)
        _ = saveState
            .asObservable()
            .withLatestFrom(card)
            .filterNil()
            .subscribe(onNext: { [weak self] card in
                let identifier = String(describing: card)
                self?.reportingService.report(event: .transportCardAdded(identifier: identifier))
                try? self?.model.save(item: card)
            })
            .disposed(by: disposeBag)
    }
}
