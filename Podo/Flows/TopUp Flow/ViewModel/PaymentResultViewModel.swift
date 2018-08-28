//
//  PaymentResultViewModel.swift
//  Podo
//
//  Created by m3g0byt3 on 23/08/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

struct PaymentResultViewModel: PaymentResultViewModelProtocol,
                               PaymentResultViewModelInputProtocol,
                               PaymentResultViewModelOutputProtocol {

    // MARK: - PaymentResultViewModelProtocol protocol conformance

    var input: PaymentResultViewModelInputProtocol { return self }
    var output: PaymentResultViewModelOutputProtocol { return self }

    // MARK: - PaymentResultViewModelOutputProtocol protocol conformance

    let title: String
    let message: String
    let imageBlob: Data?
    let isError: Bool

    // MARK: - Types

    enum PaymentResultType {
        case success
        case error(Error)
    }

    // MARK: - Initialization

    init(type: PaymentResultType) {
        switch type {
        case .success:
            self.title = R.string.localizable.successTitle()
            self.message = R.string.localizable.successMessage()
            self.imageBlob = R.image.contactlessCardSymbol().flatMap { $0.pngData() }
            self.isError = false
        case .error(let error):
            self.title = R.string.localizable.errorTitle()
            self.message = error.localizedDescription
            self.imageBlob = nil
            self.isError = true
        }
    }
}
