//
//  TransportCardViewModelProtocol.swift
//  Podo
//
//  Created by m3g0byt3 on 17/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol TransportCardViewModelProtocol {

    var cardTheme: Driver<TransportCardTheme> { get }
    var cardTitle: Driver<String> { get }
}
