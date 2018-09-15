//
//  PaymentResultViewModelProtocol.swift
//  Podo
//
//  Created by m3g0byt3 on 23/08/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RxSwift

protocol PaymentResultViewModelProtocol {

    var input: PaymentResultViewModelInputProtocol { get }
    var output: PaymentResultViewModelOutputProtocol { get }
}

protocol PaymentResultViewModelInputProtocol {}
protocol PaymentResultViewModelOutputProtocol {

    var isError: Bool { get }
    var title: Single<String> { get }
    var message: Single<String> { get }
    var stations: Observable<[PaymentResultCellViewModelProtocol]> { get }
    var isLoading: Observable<Bool> { get }
}
