//
//  PaymentMethodCellViewModelProtocol.swift
//  Podo
//
//  Created by m3g0byt3 on 16/04/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit.UIImage
import RxSwift
import RxCocoa

protocol PaymentMethodCellViewModelProtocol {

    var title: Driver<String> { get }
    var icon: Driver<UIImage> { get }
    var type: PaymentMethodType { get }
}
