//
//  ErrorViewModelProtocol.swift
//  Podo
//
//  Created by m3g0byt3 on 23/08/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

protocol ErrorViewModelProtocol {

    var input: ErrorViewModelInputProtocol { get }
    var output: ErrorViewModelOutputProtocol { get }
}

protocol ErrorViewModelInputProtocol {}
protocol ErrorViewModelOutputProtocol {

    var title: String { get }
    var message: String { get }
}
