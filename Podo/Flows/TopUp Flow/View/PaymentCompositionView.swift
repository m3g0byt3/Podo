//
//  PaymentCompositionView.swift
//  Podo
//
//  Created by m3g0byt3 on 27/04/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import BSK
import Result

protocol PaymentCompositionView: View {

    var onPaymentConfirmation: ((Result<URLRequest, BSKError>) -> Void)? { get set }
    var onPaymentComplete: Completion? { get set }
    var onPaymentCancel: Completion? { get set }
    var onScanButtonTap: Completion? { get set }
}
