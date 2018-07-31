//
//  TransportCardViewModel.swift
//  Podo
//
//  Created by m3g0byt3 on 17/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RxSwift

struct TransportCardViewModel: TransportCardViewModelProtocol,
                               TransportCardViewModelInputProtocol,
                               TransportCardViewModelOutputProtocol {

    // MARK: - Constants

    private static let titleLength = 4

    // MARK: - TransportCardViewModelProtocol protocol conformance

    var input: TransportCardViewModelInputProtocol { return self }
    var output: TransportCardViewModelOutputProtocol { return self }

    // MARK: - TransportCardViewModelOutputProtocol protocol conformance

    let cardTheme: Observable<TransportCardTheme>
    let cardTitle: Observable<String>
    let isCardValid: Observable<Bool>

    // MARK: - Initialization

    init(_ model: TransportCard) {
        self.cardTheme = Observable
            .just(model.themeIdentifier)
            .map { TransportCardTheme(rawValue: $0) }
            .filterNil()

        self.cardTitle = Observable
            .just(model.cardNumber)
            .map { "●●●●" + $0.suffix(TransportCardViewModel.titleLength) }

        self.isCardValid = Observable
            .just(true)
    }
}
