//
//  RouterAssembly.swift
//  Podo
//
//  Created by m3g0byt3 on 06/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import Swinject

final class RouterAssembly: Assembly {

    func assemble(container: Container) {

        container.register(RouterProtocol.self) { _, rootViewController in
            return Router(rootViewController, assembler: ApplicationAssembler.defaultAssembler)
        }

        container.register(InteractiveTransitioningDelegate.self) { _ in
            return SideMenuTransitioningDelegate()
        }
    }
}
