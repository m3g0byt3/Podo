//
//  PaymentResultViewModelProtocol.swift
//  Podo
//
//  Created by m3g0byt3 on 23/08/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

protocol PaymentResultViewModelProtocol {

    var input: PaymentResultViewModelInputProtocol { get }
    var output: PaymentResultViewModelOutputProtocol { get }
}

protocol PaymentResultViewModelInputProtocol {}
protocol PaymentResultViewModelOutputProtocol {

    var title: String { get }
    var message: String { get }
    var imageBlob: Data? { get }
    var isError: Bool { get }
}
