//
//  PaymentFailedResultViewModel.swift
//  Podo
//
//  Created by m3g0byt3 on 10/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RxSwift

struct PaymentFailedResultViewModel: PaymentResultViewModelProtocol,
                                     PaymentResultViewModelInputProtocol,
                                     PaymentResultViewModelOutputProtocol {

    // MARK: - PaymentResultViewModelProtocol protocol conformance

    var input: PaymentResultViewModelInputProtocol { return self }
    var output: PaymentResultViewModelOutputProtocol { return self }

    // MARK: - PaymentResultViewModelOutputProtocol protocol conformance

    let isError: Bool
    let title: Single<String>
    let message: Single<String>
    let stations: Observable<[String]>
    let isLoading: Observable<Bool>

    // MARK: - Initialization

    init(error: Error) {
        self.isError = true

        self.title = Single
            .just(R.string.localizable.errorTitle())

        self.message = Single
            .just(error.localizedDescription)

        self.stations = Observable
            .empty()

        self.isLoading = Observable
            .just(false)
    }
}
