//
//  RouterImpl.swift
//  Podo
//
//  Created by m3g0byt3 on 05/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit

final class RouterImpl {

    // MARK: - Properties

    private weak var rootViewController: UINavigationController?
    private var themeProvider: ThemeProvider?

    // MARK: - Initialization

    init(_ rootViewController: UINavigationController, themeProvider: ThemeProvider? = nil) {
        self.rootViewController = rootViewController
        self.themeProvider = themeProvider
        self.themeProvider?.appearanceSetup()
    }
}

// MARK: - Router protocol conformance

extension RouterImpl: Router {

    // Presentation
    func setRootView(_ view: View, animated: Bool, fullscreen: Bool) {
        guard let viewController = view.presentableEntity else { return }
        rootViewController?.isNavigationBarHidden = fullscreen
        rootViewController?.setViewControllers([viewController], animated: animated)
    }

    func present(_ view: View, animated: Bool = true, completion: Completion? = nil) {
        guard let viewController = view.presentableEntity else { return }
        rootViewController?.present(viewController, animated: animated, completion: completion)
    }

    func push(_ view: View, animated: Bool = true) {
        guard let viewController = view.presentableEntity else { return }
        rootViewController?.pushViewController(viewController, animated: animated)
    }

    // Dismissal
    func dismiss(animated: Bool = true, completion: Completion? = nil) {
        rootViewController?.dismiss(animated: animated, completion: completion)
    }

    func pop(animated: Bool = true) {
        rootViewController?.popViewController(animated: animated)
    }

    func popToRootView(animated: Bool) {
        rootViewController?.popToRootViewController(animated: animated)
    }
}
