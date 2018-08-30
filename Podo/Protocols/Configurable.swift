//
//  Configurable.swift
//  Podo
//
//  Created by m3g0byt3 on 10/04/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

/// An object (UITableViewCell for example) that can be configured with view model
protocol Configurable {

    associatedtype ViewModel

    @discardableResult
    func configure(with viewModel: ViewModel) -> Self
}
