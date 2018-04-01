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

    let cardNumberInput: PublishSubject<String>
    let saveState: PublishSubject<Void>
    let cardNumberOutput: Driver<String>
    let isCardValid: Driver<Bool>

    // MARK: - Initialization

    init(_ database: AnyDatabaseService<TransportCard>) {
        self.database = database

        cardNumberInput = PublishSubject()

        saveState = PublishSubject()

        cardNumberOutput = cardNumberInput
            .asDriver(onErrorJustReturn: "")
            .map { return $0.replacingOccurrences(of: AddNewCardViewModelImpl.notNumericSet, with: "") }

        model = cardNumberOutput
            .asObservable()
            .distinctUntilChanged()
            .map { TransportCard(cardNumber: $0) }

        isCardValid = model
            .asDriver(onErrorJustReturn: nil)
            .map { $0 != nil }
            .distinctUntilChanged()

        _ = saveState
            .asObservable()
            .withLatestFrom(model)
            .filter { $0 != nil }
            .do(onNext: { [weak self] card in
                try? self?.database.save(item: card!)
            })
            .subscribe()
            .disposed(by: disposeBag)
    }
}
