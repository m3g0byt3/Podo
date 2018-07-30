//
//  TransportCardViewModel.swift
//  Podo
//
//  Created by m3g0byt3 on 17/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct TransportCardViewModel: TransportCardViewModelProtocol {

    // MARK: - Constants

    private static let titleLength = 4
    private static let onErrorPlaceholder = ""

    // MARK: - TransportCardViewModelProtocol protocol conformance

    let cardTheme: Driver<TransportCardTheme>
    let cardTitle: Driver<String>
    let isCardValid: Observable<Bool>

    // MARK: - Initialization

    init(_ model: TransportCard) {
        self.cardTheme = Observable
            .just(model.themeIdentifier)
            .map { TransportCardTheme(rawValue: $0) }
            .filterNil()
            .asDriver(onErrorJustReturn: .green)

        self.cardTitle = Observable
            .just(model.cardNumber)
            .map { "●●●●" + $0.suffix(TransportCardViewModel.titleLength) }
            .asDriver(onErrorJustReturn: TransportCardViewModel.onErrorPlaceholder)

        self.isCardValid = Observable
            .just(true)
    }
}
