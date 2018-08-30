//
//  MainMenuViewModel.swift
//  Podo
//
//  Created by m3g0byt3 on 25/02/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RxSwift

protocol MainMenuViewModelProtocol {

    var input: MainMenuViewModelInputProtocol { get }
    var output: MainMenuViewModelOutputProtocol { get }
}

protocol MainMenuViewModelInputProtocol {}

protocol MainMenuViewModelOutputProtocol {

    var emptyTitle: Single<String> { get }
    var emptyMessage: Single<String> { get }
    var emptyImageBlob: Single<Data?> { get }
    var paymentResults: Observable<[MainMenuCellViewModelProtocol]> { get }
}
