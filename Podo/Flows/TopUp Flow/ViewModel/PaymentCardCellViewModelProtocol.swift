//
//  PaymentCardCellViewModelProtocol.swift
//  Podo
//
//  Created by m3g0byt3 on 06/07/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import struct RxCocoa.Driver
import class RxSwift.PublishSubject

protocol PaymentCardCellViewModelProtocol {

    // MARK: - Inputs

    var cardNumberInput: PublishSubject<String> { get }
    var cvcNumberInput: PublishSubject<String> { get }
    var expiryDateInput: PublishSubject<String> { get }
    var scanRequested: PublishSubject<Void> { get }

    // MARK: - Outputs

    var cardNumberOutput: Driver<String> { get }
    var cvcNumberOutput: Driver<String> { get }
    var expiryDateOutput: Driver<String> { get }
}
