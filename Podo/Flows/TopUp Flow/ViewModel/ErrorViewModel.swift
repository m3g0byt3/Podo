//
//  ErrorViewModel.swift
//  Podo
//
//  Created by m3g0byt3 on 23/08/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

struct ErrorViewModel: ErrorViewModelProtocol,
                       ErrorViewModelInputProtocol,
                       ErrorViewModelOutputProtocol {

    // MARK: - ErrorViewModelProtocol protocol conformance

    var input: ErrorViewModelInputProtocol { return self }
    var output: ErrorViewModelOutputProtocol { return self }

    // MARK: - ErrorViewModelOutputProtocol protocol conformance

    let title: String
    let message: String

    // MARK: - Initialization

    init(error: Error) {
        title = R.string.localizable.errorTitle()
        message = error.localizedDescription
    }
}
