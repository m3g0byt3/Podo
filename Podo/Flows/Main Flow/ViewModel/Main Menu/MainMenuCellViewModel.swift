//
//  MainMenuCellViewModel.swift
//  Podo
//
//  Created by m3g0byt3 on 28/02/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

struct MainMenuCellViewModel: MainMenuCellViewModelProtocol,
                              MainMenuCellViewModelInputProtocol,
                              MainMenuCellViewModelOutputProtocol {

    // MARK: - MainMenuCellViewModelProtocol protocol conformance

    var input: MainMenuCellViewModelInputProtocol { return self }
    var output: MainMenuCellViewModelOutputProtocol { return self }

    // MARK: - Initialization

    init(_ model: PaymentItem) {}
}
