//
//  CardsViewModelImpl.swift
//  Podo
//
//  Created by m3g0byt3 on 17/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

struct CardsViewModelImpl: CardsViewModel {

    // MARK: - CardsViewModel protocol conformance

    func numberOfChildViewModels(in section: Int) -> Int {
        return 5
    }

    func childViewModel(for indexPath: IndexPath) -> CardsCellViewModel? {
        // TODO: Add actual implementation
        return CardsCellViewModelImpl()
    }
}
