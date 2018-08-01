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
    private let disposeBag = DisposeBag()

    // MARK: - Initialization

    init(_ model: AnyDatabaseService<TransportCard>) {
        self.model = model

        cardNumberText = cardNumber
            .filterNonNumeric()

        cardTheme = themeChanged
            .asObservable()
            .startWith(0)
            .map { TransportCardTheme(rawValue: $0) ?? .green }
            .distinctUntilChanged()

        card = Observable
            .combineLatest(cardNumberText.asObservable(), cardTheme.asObservable()) { number, theme in
                let card = TransportCard(cardNumber: number)
                card?.themeIdentifier = theme.rawValue
                return card
            }
            .distinctUntilChanged()
            .share()

        isCardValid = card
            .asObservable()
            .map { $0 != nil }
            .distinctUntilChanged()

        _ = saveState
            .asObservable()
            .withLatestFrom(card)
            .filterNil()
            .subscribe(onNext: { [weak self] card in
                try? self?.model.save(item: card)
            })
            .disposed(by: disposeBag)
    }
}
