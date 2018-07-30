//
//  ThemeAssembly.swift
//  Podo
//
//  Created by m3g0byt3 on 08/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import Swinject

final class ThemeAssembly: Assembly {

    func assemble(container: Container) {

        container.register(ThemeProviderProtocol.self) { _ in
            ThemeProvider()
        }
    }
}
