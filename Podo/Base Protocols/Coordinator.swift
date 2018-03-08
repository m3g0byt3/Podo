//
//  Coordinator.swift
//  Podo
//
//  Created by m3g0byt3 on 02/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

protocol Coordinator {

    func start()
    func start(with option: StartOption?)
}

extension Coordinator {

    func start() {
        start(with: nil)
    }
}
