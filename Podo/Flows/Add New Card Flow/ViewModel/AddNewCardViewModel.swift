//
//  AddNewCardViewModel.swift
//  Podo
//
//  Created by m3g0byt3 on 27/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RxSwift

final class AddNewCardViewModel: AddNewCardViewModelProtocol {

    // MARK: - Properties

    private let model: AnyDatabaseService<TransportCard>
    private let card: Observable<TransportCard?>
    private let disposeBag = DisposeBag()

    // MARK: - AddNewCardViewModelProtocol protocol conformance

    // Inputs
    let cardNumberInput = PublishSubject<String>()
    let themeChanged = PublishSubject<Int>()
    let saveState = PublishSubject<Void>()

    // Outputs
    let cardNumberOutput: Observable<String>
    let cardTheme: Observable<TransportCardTheme>
    let isCardValid: Observable<Bool>

    // MARK: - Initialization

    init(_ model: AnyDatabaseService<TransportCard>) {
        self.model = model

        cardNumberOutput = cardNumberInput
            .filterNonNumeric()

        cardTheme = themeChanged
            .asObservable()
            .startWith(0)
            .map { TransportCardTheme(rawValue: $0) ?? .green }
            .distinctUntilChanged()

        card = Observable
            .combineLatest(cardNumberOutput.asObservable(), cardTheme.asObservable()) { (number, theme) in
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
