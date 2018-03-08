//
//  MainMenuViewModelImpl.swift
//  Podo
//
//  Created by m3g0byt3 on 03/12/2017.
//  Copyright © 2017 m3g0byt3. All rights reserved.
//

import UIKit

final class MainMenuViewModelImpl {

    // TODO: Add actual implementation
}

// MARK: - MainMenuViewModel protocol conformance

extension MainMenuViewModelImpl: MainMenuViewModel {

    var childViewModelsCount: Int { return 10 }

    func childViewModelForIndexPath(_ indexPath: IndexPath) -> MainMenuCellViewModel {
        // TODO: Add actual implementation
        fatalError("Not implemented yet!")
    }
}
