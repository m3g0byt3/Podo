//
//  CardsViewModel.swift
//  Podo
//
//  Created by m3g0byt3 on 17/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

// Still imports RxCocoa because BehaviorRelay not available without RxCocoa until RxSwift 5.0
// See https://github.com/ReactiveX/RxSwift/issues/1501 and https://github.com/ReactiveX/RxSwift/issues/1502
import Foundation
import RxSwift
import class RxCocoa.BehaviorRelay

final class CardsViewModel: CardsViewModelProtocol {

    // MARK: - Properties

    private let model: AnyDatabaseService<TransportCard>
    private let viewModels: BehaviorRelay<[TransportCardViewModelProtocol]>

    // MARK: - CardsViewModelProtocol protocol conformance

    var childViewModels: Observable<[TransportCardViewModelProtocol]> {
        return viewModels.asObservable()
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
