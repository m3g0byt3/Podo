//
//  PaymentCompositionViewModelProtocol.swift
//  Podo
//
//  Created by m3g0byt3 on 21/06/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RxSwift

protocol PaymentCompositionViewModelProtocol {

    var input: PaymentCompositionViewModelInputProtocol { get }
    var output: PaymentCompositionViewModelOutputProtocol { get }
}

protocol PaymentCompositionViewModelInputProtocol {}

protocol PaymentCompositionViewModelOutputProtocol {

    var isPaymentValid: Observable<Bool> { get }
    var sections: Observable<[PaymentCompositionSectionViewModelWrapper]> { get }
}
