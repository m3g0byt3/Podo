//
//  SideMenuViewModel.swift
//  Podo
//
//  Created by m3g0byt3 on 18/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RxSwift

final class SideMenuViewModel: SideMenuViewModelProtocol,
                               SideMenuViewModelInputProtocol,
                               SideMenuViewModelOutputProtocol {

    // MARK: - Constants

    private static let keyPath = #keyPath(SideMenuItem.identifier)
    private static let sortOption = SortOption.ascending(keyPath: SideMenuViewModel.keyPath)

    // MARK: - Properties

    private let model: AnyDatabaseService<SideMenuItem>

    // MARK: - SideMenuViewModelProtocol protocol conformance

    var input: SideMenuViewModelInputProtocol { return self }
    var output: SideMenuViewModelOutputProtocol { return self }

    // MARK: - SideMenuViewModelOutputProtocol protocol conformance

    lazy var sideMenuItems: Observable<[SideMenuCellViewModelProtocol]> = {
        let sortOption = SideMenuViewModel.sortOption
        return model.itemsObservable(isCompleted: true, sorted: sortOption)
            .map { $0.map(SideMenuCellViewModel.init) }
            .share()
    }()

    // MARK: - Initialization

    init(_ model: AnyDatabaseService<SideMenuItem>) {
        self.model = model
    }
}
