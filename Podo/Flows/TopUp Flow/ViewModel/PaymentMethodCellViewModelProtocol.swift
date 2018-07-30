//
//  PaymentMethodCellViewModelProtocol.swift
//  Podo
//
//  Created by m3g0byt3 on 16/04/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RxSwift

protocol PaymentMethodCellViewModelProtocol {

    var title: Observable<String> { get }
    var iconBlob: Observable<Data> { get }
    var type: PaymentMethodType { get }
}
