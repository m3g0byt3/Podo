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

    let cardNumberInput = PublishSubject<String>()
    let themeChanged = PublishSubject<Int>()
    let saveState = PublishSubject<Void>()

    // MARK: - AddNewCardViewModelOutputProtocol protocol conformance

    let cardNumberOutput: Observable<String>
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

        self.cardNumberOutput = self.cardNumberInput
            .asObservable()
            .filterNonNumeric()

        self.cardTheme = self.themeChanged
            .asObservable()
            .startWith(0)
            .map { TransportCardTheme(rawValue: $0) ?? .green }
            .distinctUntilChanged()

        self.card = Observable
            .combineLatest(self.cardNumberOutput, self.cardTheme)
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
