//
//  PaymentConfirmationView.swift
//  Podo
//
//  Created by m3g0byt3 on 01/08/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import BSK
import Result

protocol PaymentConfirmationView: View {

    var onPaymentCancel: Completion? { get set }
    var onPaymentComplete: Completion? { get set }
}
