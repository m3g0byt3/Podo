//
//  CardsViewModelImpl.swift
//  Podo
//
//  Created by m3g0byt3 on 17/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class CardsViewModelImpl: CardsViewModel {

    // MARK: - Properties

    private let model: AnyDatabaseService<TransportCard>
    private let viewModels: BehaviorRelay<[CardsCellViewModel]>

    // MARK: - CardsViewModel protocol conformance

    var childViewModels: Driver<[CardsCellViewModel]> {
        return viewModels.asDriver()
    }

    // MARK: - Initialization

    init(_ model: AnyDatabaseService<TransportCard>) {
        self.viewModels = BehaviorRelay(value: [CardsCellViewModel]())
        self.model = model
        try? model.fetch(predicate: nil, sorted: nil) { [weak self] result in
            let viewModels = result.map(CardsCellViewModelImpl.init)
            self?.viewModels.accept(viewModels)
        }
    }
}
