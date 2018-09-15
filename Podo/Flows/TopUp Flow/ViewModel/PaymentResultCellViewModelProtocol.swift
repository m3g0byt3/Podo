//
//  PaymentResultCellViewModelProtocol.swift
//  Podo
//
//  Created by m3g0byt3 on 15/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

protocol PaymentResultCellViewModelProtocol {

    var input: PaymentResultCellViewModelInputProtocol { get }
    var output: PaymentResultCellViewModelOutputProtocol { get }
}

protocol PaymentResultCellViewModelInputProtocol {}
protocol PaymentResultCellViewModelOutputProtocol {

    var title: String { get }
}
