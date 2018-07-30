//
//  AppDelegateAssembler.swift
//  Podo
//
//  Created by m3g0byt3 on 19/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import Swinject

enum AssembleError: Error {

    case routerError
    case coordinatorError
}

struct AppDelegateAssembler {

    // MARK: - Properties

    private let assembler: Assembler

    // MARK: - Initialization

    /**
     Using `ApplicationAssembler.defaultAssembler` as an assembler
     */
    init() {
        assembler = ApplicationAssembler.defaultAssembler
    }

    /**
     Using custom assembler with given assemblies as an assembler
     - parameter assemblies: Array of assemblies
     */
    init(assemblies: [Assembly]) {
        assembler = Assembler(assemblies)
    }

    // MARK: - Public API

    /**
     Perform dependency injection for AppDelegate instance.
     - parameter appDelegate: AppDelegate instance
     */
    func assemble(appDelegate: AppDelegate) throws {

        guard let router = assembler.resolver.resolve(RouterProtocol.self, argument: appDelegate.rootViewController) else {
            throw AssembleError.routerError
        }

        guard let coordinator = assembler.resolver.resolve(Coordinator.self, argument: router) else {
            throw AssembleError.coordinatorError
        }

        appDelegate.coordinator = coordinator
    }
}
