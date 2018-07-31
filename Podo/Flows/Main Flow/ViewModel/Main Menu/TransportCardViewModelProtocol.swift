//
//  TransportCardViewModelProtocol.swift
//  Podo
//
//  Created by m3g0byt3 on 17/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RxSwift

protocol TransportCardViewModelProtocol {

    var input: TransportCardViewModelInputProtocol { get }
    var output: TransportCardViewModelOutputProtocol { get }
}

protocol TransportCardViewModelInputProtocol {}

protocol TransportCardViewModelOutputProtocol {

    var cardTheme: Observable<TransportCardTheme> { get }
    var cardTitle: Observable<String> { get }
    var isCardValid: Observable<Bool> { get }
}
