//
//  TopUpView.swift
//  Podo
//
//  Created by m3g0byt3 on 16/04/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

protocol TopUpView: View {

    var onPaymentMethodSelection: ((PaymentMethodCellViewModel) -> Void)? { get set }
    var onPaymentCancel: Completion? { get set }
}
