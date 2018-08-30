//
//  TransportCardViewModel.swift
//  Podo
//
//  Created by m3g0byt3 on 17/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RxSwift
import BSK

struct TransportCardViewModel: TransportCardViewModelProtocol,
                               TransportCardViewModelLinkProtocol,
                               TransportCardViewModelInputProtocol,
                               TransportCardViewModelOutputProtocol {

    // MARK: - Constants

    private static let shortNumberLength = 4

    // MARK: - TransportCardViewModelProtocol protocol conformance

    var input: TransportCardViewModelInputProtocol { return self }
    var output: TransportCardViewModelOutputProtocol { return self }
    var link: TransportCardViewModelLinkProtocol { return self }

    // MARK: - TransportCardViewModelLinkProtocol protocol conformance

    let model: Observable<BSKTransportCard>

    // MARK: - TransportCardViewModelOutputProtocol protocol conformance

    let cardTheme: Observable<TransportCardTheme>
    let cardNumber: Observable<String>
    let isCardValid: Observable<Bool>

    // MARK: - Initialization

    init(_ model: TransportCard) {
        self.cardTheme = Observable
            .just(model.themeIdentifier)
            .map { TransportCardTheme(rawValue: $0) }
            .filterNil()

        let cardNumber = Observable
            .just(model.cardNumber)
            .share(replay: 1, scope: .whileConnected)

        self.cardNumber = cardNumber
            .map { "●●●●" + $0.suffix(TransportCardViewModel.shortNumberLength) }

        self.model = cardNumber
            .map(BSKTransportCard.init)
            .filterNil()

        self.isCardValid = Observable
            .just(true)
    }
}
