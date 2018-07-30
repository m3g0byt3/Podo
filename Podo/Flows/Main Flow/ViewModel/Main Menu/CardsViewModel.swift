//
//  CardsViewModel.swift
//  Podo
//
//  Created by m3g0byt3 on 17/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class CardsViewModel: CardsViewModelProtocol {

    // MARK: - Properties

    private let model: AnyDatabaseService<TransportCard>
    private let viewModels: BehaviorRelay<[TransportCardViewModelProtocol]>

    // MARK: - CardsViewModelProtocol protocol conformance

    var childViewModels: Driver<[TransportCardViewModelProtocol]> {
        return viewModels.asDriver()
    }

    // MARK: - Initialization

    init(_ model: AnyDatabaseService<TransportCard>) {
        self.viewModels = BehaviorRelay(value: [TransportCardViewModelProtocol]())
        self.model = model
        try? model.fetch(predicate: nil, sorted: nil) { [weak self] result in
            let viewModels = result.map(TransportCardViewModel.init)
            self?.viewModels.accept(viewModels)
        }
    }
}
