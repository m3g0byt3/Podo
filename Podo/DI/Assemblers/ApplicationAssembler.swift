//
//  ApplicationAssembler.swift
//  Podo
//
//  Created by m3g0byt3 on 26/02/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import Swinject

final class ApplicationAssembler {

    // MARK: - Properties

    static var defaultAssembler = {
        return Assembler([
            ViewModelAssembly(),
            ViewAssembly(),
            ServiceAssembly()
        ])
    }()

    private var assembler: Assembler

    // MARK: - Initialization

    init(assemblies: [Assembly]) {
        assembler = Assembler(assemblies)
    }
}
