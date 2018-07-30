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
    /**
     Default assembler with bundled assemblies
     */
    static var defaultAssembler = {
        return Assembler([
            CoordinatorAssembly(),
            RouterAssembly(),
            ViewModelAssembly(),
            ViewAssembly(),
            ServiceAssembly(),
            ThemeAssembly()
        ])
    }()

    var assembler: Assembler

    // MARK: - Initialization
    /**
     Create custom assembler with given assemblies
     - parameter assemblies: Array of assemblies
     */
    init(assemblies: [Assembly]) {
        self.assembler = Assembler(assemblies)
    }
}
