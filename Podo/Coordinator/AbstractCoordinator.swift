//
//  AbstractCoordinator.swift
//  Podo
//
//  Created by m3g0byt3 on 10/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import Swinject

class AbstractCoordinator: Coordinator {

    // MARK: - Properties

    let router: Router
    let assembler: Assembler
    var coordinators = [Coordinator]()
    var onFlowFinish: Completion?

    // MARK: - Initialization

    required init(router: Router, assembler: Assembler) {
        // Avoid initialization of abstract class
        guard type(of: self) != AbstractCoordinator.self else {
            fatalError("Create a subclass instance of abstract class \(AbstractCoordinator.self).")
        }
        self.router = router
        self.assembler = assembler
    }

    final func addChild(_ coordinator: Coordinator?) {
        guard let coordinator = coordinator else { return }
        coordinators.append(coordinator)
    }

    final func removeChild(_ coordinator: Coordinator?) {
        guard let coordinator = coordinator,
            let index = coordinators.index(where: { $0 === coordinator }) else { return }
        coordinators.remove(at: index)
    }

    // MARK: - Coordinator protocol conformance

    func start() {
        fatalError("Subclasses must override method \(#function)")
    }

    func start(with option: StartOption?) {
        fatalError("Subclasses must override method \(#function)")
    }
}
