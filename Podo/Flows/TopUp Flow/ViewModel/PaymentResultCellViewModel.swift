//
//  PaymentResultCellViewModel.swift
//  Podo
//
//  Created by m3g0byt3 on 15/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

struct PaymentResultCellViewModel: PaymentResultCellViewModelProtocol,
                                   PaymentResultCellViewModelInputProtocol,
                                   PaymentResultCellViewModelOutputProtocol {

    // MARK: - PaymentResultCellViewModelProtocol protocol conformance

    var input: PaymentResultCellViewModelInputProtocol { return self }
    var output: PaymentResultCellViewModelOutputProtocol { return self }

    // MARK: - PaymentResultCellViewModelInputProtocol protocol conformance

    // MARK: - PaymentResultCellViewModelOutputProtocol protocol conformance

    let title: String
}
