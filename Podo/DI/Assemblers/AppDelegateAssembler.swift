//
//  AppDelegateAssembler.swift
//  Podo
//
//  Created by m3g0byt3 on 19/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import Swinject

struct AppDelegateAssembler {

    // MARK: - Properties

    private let assembler: Assembler

    // MARK: - Initialization

    /// Using `ApplicationAssembler.defaultAssembler` as an assembler
    init() {
        self.assembler = ApplicationAssembler.defaultAssembler
    }

    /// Using custom assembler with given assemblies as an assembler
    /// - parameter assemblies: Array of assemblies
    init(assemblies: [Assembly]) {
        self.assembler = Assembler(assemblies)
    }

    // MARK: - Public API

    /// Perform dependency injection for AppDelegate instance.
    /// - parameter appDelegate: AppDelegate instance
    func assemble(appDelegate: AppDelegate) {
        let rootViewAssembly = RootViewAssembly(rootView: appDelegate.rootViewController)

        assembler.apply(assembly: rootViewAssembly)

        guard let coordinator = assembler.resolver.resolve(Coordinator.self) else {
            unableToResolve(Coordinator.self)
        }

        appDelegate.coordinator = coordinator
    }
}
