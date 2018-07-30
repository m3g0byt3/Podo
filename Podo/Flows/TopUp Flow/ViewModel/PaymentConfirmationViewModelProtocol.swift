//
//  PaymentConfirmationViewModelProtocol.swift
//  Podo
//
//  Created by m3g0byt3 on 21/06/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RxSwift

protocol PaymentConfirmationViewModelProtocol {

    var isPaymentValid: Observable<Bool> { get }
    var sections: Observable<[PaymentConfirmationSectionViewModelWrapper]> { get }
}
