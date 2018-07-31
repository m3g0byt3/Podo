//
//  CardsViewModelProtocol.swift
//  Podo
//
//  Created by m3g0byt3 on 17/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RxSwift

protocol CardsViewModelProtocol {

    var input: CardsViewModelInputProtocol { get }
    var output: CardsViewModelOutputProtocol { get }
}

protocol CardsViewModelInputProtocol {}

protocol CardsViewModelOutputProtocol {

    var childViewModels: Observable<[TransportCardViewModelProtocol]> { get }
}
