//
//  ViewModel.swift
//  Podo
//
//  Created by m3g0byt3 on 17/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

/**
 Represents data source for classes like UITableView and UICollectionView
 */
protocol ViewModel {

    /**
     Associated type for child view model
     */
    associatedtype ChildViewModel

    /**
     * Returns number of child view models in given section
     * - parameter section: Section number
     * - returns: Number of child view models
     */
    func numberOfChildViewModels(in section: Int) -> Int

    /**
     * Returns child view model for given index path
     * - parameter indexPath: IndexPath for child view model
     * - returns: Child view model
     */
    func childViewModel(for indexPath: IndexPath) -> ChildViewModel
}
