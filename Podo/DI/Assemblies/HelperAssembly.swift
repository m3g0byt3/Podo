//
//  HelperAssembly.swift
//  Podo
//
//  Created by m3g0byt3 on 08/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit
import Swinject
import Moya

final class HelperAssembly: Assembly {

    func assemble(container: Container) {

        container.register(ThemeAdapterProtocol.self) { _ in
            return ThemeAdapter()
        }
    }
}
