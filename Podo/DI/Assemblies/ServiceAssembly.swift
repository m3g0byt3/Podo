//
//  ServiceAssembly.swift
//  Podo
//
//  Created by m3g0byt3 on 28/02/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import Swinject

final class ServiceAssembly: Assembly {

    func assemble(container: Container) {
        container.register(NetworkService.self) { _ in
            // TODO: Add actual implementation
            fatalError("Not implemented yet!")
        }
        container.register(DatabaseService.self) { _ in
            // TODO: Add actual implementation
            fatalError("Not implemented yet!")
        }
    }
}
