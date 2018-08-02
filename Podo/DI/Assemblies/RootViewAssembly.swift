//
//  RootViewAssembly.swift
//  Podo
//
//  Created by m3g0byt3 on 03/08/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit
import Swinject

final class RootViewAssembly: Assembly {

    // MARK: - Properties

    private let rootView: UINavigationController

    // MARK: - Initialization

    init(rootView: UINavigationController) {
        self.rootView = rootView
    }

    // MARK: - Assembly protocol conformance

    func assemble(container: Container) {
        // `unowned` is safe here because container tries to register Service only once
        container.register(UINavigationController.self) { [unowned self] _ in
            return self.rootView
        }
    }
}
