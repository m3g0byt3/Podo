//
//  PaymentResultView.swift
//  Podo
//
//  Created by m3g0byt3 on 27/08/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

protocol PaymentResultView: View {

    var onPaymentResultClose: Completion? { get set }
}
