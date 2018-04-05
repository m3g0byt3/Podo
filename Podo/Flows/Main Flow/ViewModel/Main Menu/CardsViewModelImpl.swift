//
//  CardsViewModelImpl.swift
//  Podo
//
//  Created by m3g0byt3 on 17/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

final class CardsViewModelImpl: CardsViewModel {

    // MARK: - CardsViewModel protocol conformance

    func numberOfChildViewModels(in section: Int) -> Int {
        // TODO: Add actual implementation
        return 0
    }

    func childViewModel(for indexPath: IndexPath) -> CardsCellViewModel? {
        // TODO: Add actual implementation
        let isChildViewModelAvailable = indexPath.row < numberOfChildViewModels(in: indexPath.section)
        return isChildViewModelAvailable ? CardsCellViewModelImpl() : nil
    }
}
