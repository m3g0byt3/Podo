//
//  CardsViewModel.swift
//  Podo
//
//  Created by m3g0byt3 on 17/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RxSwift

final class CardsViewModel: CardsViewModelProtocol,
                            CardsViewModelInputProtocol,
                            CardsViewModelOutputProtocol {

    // MARK: - Properties

    private let model: AnyDatabaseService<TransportCard>

    // MARK: - CardsViewModelProtocol protocol conformance

    var input: CardsViewModelInputProtocol { return self }
    var output: CardsViewModelOutputProtocol { return self }

    // MARK: - CardsViewModelOutputProtocol protocol conformance

    lazy var cardsViewModels: Observable<[TransportCardViewModelProtocol]> = {
        return model.itemsObservable()
            .map { $0.map(TransportCardViewModel.init) }
    }()

    // MARK: - Initialization

    init(_ model: AnyDatabaseService<TransportCard>) {
        self.model = model
    }
}
