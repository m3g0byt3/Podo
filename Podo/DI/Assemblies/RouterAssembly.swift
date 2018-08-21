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

        container.register(RouterProtocol.self) { resolver in
            let rootViewDependencyType = UINavigationController.self
            let errorAdapterDependencyType = ErrorAdapterProtocol.self
            let themeAdapterDependencyType = ThemeAdapterProtocol.self

            guard let errorAdapter = resolver.resolve(errorAdapterDependencyType) else {
                unableToResolve(errorAdapterDependencyType)
            }
            guard let themeAdapter = resolver.resolve(themeAdapterDependencyType) else {
                unableToResolve(themeAdapterDependencyType)
            }
            guard let rootView = resolver.resolve(rootViewDependencyType) else {
                unableToResolve(rootViewDependencyType)
            }

            return Router(rootViewController: rootView,
                          errorAdapter: errorAdapter,
                          themeAdapter: themeAdapter,
                          assembler: ApplicationAssembler.defaultAssembler)

        }.inObjectScope(.weak)
        // swiftlint:disable:previous multiline_function_chains

        container.register(InteractiveTransitioningDelegate.self) { _ in
            return SideMenuTransitioningDelegate()
        }
    }
}
