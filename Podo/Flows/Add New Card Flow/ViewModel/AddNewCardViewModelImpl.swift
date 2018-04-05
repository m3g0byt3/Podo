//
//  AddNewCardViewModelImpl.swift
//  Podo
//
//  Created by m3g0byt3 on 27/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class AddNewCardViewModelImpl: AddNewCardViewModel {

    // MARK: - Properties

    static private let notNumericSet = CharacterSet.decimalDigits.inverted
    private let database: AnyDatabaseService<TransportCard>
    private let model: Observable<TransportCard?>
    private let disposeBag = DisposeBag()

    // MARK: - AddNewCardViewModel protocol conformance

    // Inputs
    let cardNumberInput = PublishSubject<String>()
    let themeChanged = PublishSubject<Int>()
    let saveState = PublishSubject<Void>()

    // Outputs
    let cardNumberOutput: Driver<String>
    let cardTheme: Driver<TransportCardTheme>
    let isCardValid: Driver<Bool>

    // MARK: - Initialization

    init(_ database: AnyDatabaseService<TransportCard>) {
        self.database = database

        cardNumberOutput = cardNumberInput
            .map { $0.replacingOccurrences(of: AddNewCardViewModelImpl.notNumericSet, with: "") }
            .asDriver(onErrorJustReturn: "")

        model = Observable
            .combineLatest(cardNumberOutput.asObservable(), themeChanged.startWith(0)) { (number, identifier) in
                let card = TransportCard(cardNumber: number)
                card?.themeIdentifier = identifier
                return card
            }
            .distinctUntilChanged()
            .share()

        isCardValid = model
            .asObservable()
            .map { $0 != nil }
            .asDriver(onErrorJustReturn: false)
            .distinctUntilChanged()

        cardTheme = themeChanged
            .asObservable()
            .map { TransportCardTheme(rawValue: $0) ?? .white }
            .asDriver(onErrorJustReturn: .white)
            .distinctUntilChanged()

        _ = saveState
            .asObservable()
            .withLatestFrom(model)
            .filter { $0 != nil }
            .subscribe(onNext: { [weak self] card in
                try? self?.database.save(item: card!)
            })
            .disposed(by: disposeBag)
    }
}
