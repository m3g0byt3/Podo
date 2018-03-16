//
//  Coordinator.swift
//  Podo
//
//  Created by m3g0byt3 on 02/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

// MARK: - Typealiases

typealias FlowFinishCallback = () -> Void

protocol Coordinator: class {

    var onFlowFinish: FlowFinishCallback? { get set }

    func start()
    func start(with option: StartOption?)
}
