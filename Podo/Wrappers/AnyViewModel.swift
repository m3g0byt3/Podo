//
//  AnyViewModel.swift
//  Podo
//
//  Created by m3g0byt3 on 17/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

/**
 Type-erasure wrapper for ViewModel protocol
 `P` - Parent view model type, `C` - child view model type
 */
final class AnyViewModel<C>: ViewModel {

    // MARK: - Properties

    private let _numberOfChildViewModelsIn: (_ section: Int) -> Int
    private let _childViewModelFor: (_ indexPath: IndexPath) -> C?

    // MARK: - Initialization

    init<P: ViewModel>(_ parentViewModel: P) where P.ChildViewModel == C {
        _numberOfChildViewModelsIn = parentViewModel.numberOfChildViewModels
        _childViewModelFor = parentViewModel.childViewModel
    }

    // MARK: - ViewModel protocol conformance

    func numberOfChildViewModels(in section: Int) -> Int {
        return _numberOfChildViewModelsIn(section)
    }

    func childViewModel(for indexPath: IndexPath) -> C? {
        return _childViewModelFor(indexPath)
    }
}
