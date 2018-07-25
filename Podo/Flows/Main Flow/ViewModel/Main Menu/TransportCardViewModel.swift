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

    // MARK: - TransportCardViewModelProtocol protocol conformance

    let cardTheme: Driver<TransportCardTheme>
    let cardTitle: Driver<String>

    // MARK: - Initialization

    init(_ model: TransportCard) {

        cardTheme = Observable.just(model.themeIdentifier)
            .map { TransportCardTheme(rawValue: $0) }
            .filterNil()
            .asDriver(onErrorJustReturn: .green)

        cardTitle = Observable.just(model.cardNumber)
            .map { "●●●●" + $0.suffix(4) }
            .asDriver(onErrorJustReturn: "")
    }
}
