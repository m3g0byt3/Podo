//
//  ErrorAdapterProtocol.swift
//  Podo
//
//  Created by m3g0byt3 on 20/08/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

protocol ErrorAdapterProtocol {

    func presentError(title: String?, message: String?, completion: Completion?)
    func presentProgress(title: String?, completion: Completion?)
    func dismiss()
}
