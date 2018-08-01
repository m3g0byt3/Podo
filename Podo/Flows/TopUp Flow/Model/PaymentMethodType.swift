//
//  PaymentMethodType.swift
//  Podo
//
//  Created by m3g0byt3 on 22/04/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

/**
 Strongly-typed representation of model type
 - Remark: Raw value is `String` - for serialization/deserialization
 */
enum PaymentMethodType: String {

    case applePay
    case bankCard
    case cellphoneBalance
    case yandexMoney
    case qiwiWallet
    case unknown
}
