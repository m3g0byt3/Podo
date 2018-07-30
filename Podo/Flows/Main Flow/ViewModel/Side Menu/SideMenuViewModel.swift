//
//  SideMenuViewModel.swift
//  Podo
//
//  Created by m3g0byt3 on 18/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

final class SideMenuViewModel {

    // MARK: - Properties

    private let model: AnyDatabaseService<SideMenuItem>
    private var items = [SideMenuItem]()

    // MARK: - Initialization

    init(_ model: AnyDatabaseService<SideMenuItem>) {
        self.model = model
        let sortKeyPath = #keyPath(SideMenuItem.identifier)
        let sortOption = SortOption.ascending(keyPath: sortKeyPath)
        try? model.fetch(predicate: nil, sorted: sortOption) { [weak self] items in
            self?.items = items
        }
    }
}

// MARK: - SideMenuViewModelProtocol protocol conformance

extension SideMenuViewModel: SideMenuViewModelProtocol {

    func numberOfChildViewModels(in section: Int) -> Int {
        return items.count
    }

    func childViewModel(for indexPath: IndexPath) -> SideMenuCellViewModelProtocol {
        return SideMenuCellViewModel(items[indexPath.row])
    }
}
