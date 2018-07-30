//
//  PaymentMethodCellViewModelProtocol.swift
//  Podo
//
//  Created by m3g0byt3 on 16/04/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit.UIImage
import RxSwift

protocol PaymentMethodCellViewModelProtocol {

    var title: Observable<String> { get }
    var icon: Observable<UIImage> { get }
    var type: PaymentMethodType { get }
}
