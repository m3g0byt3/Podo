//
//  Router.swift
//  Podo
//
//  Created by m3g0byt3 on 05/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit
import Swinject

final class Router {

    // MARK: - Properties

    private var transitioningDelegates = [UIViewController: InteractiveTransitioningDelegate]()
    private let themeProvider: ThemeProviderProtocol?
    private let assembler: Assembler
    private weak var rootViewController: UINavigationController?
    private var visibleViewController: UIViewController? { return rootViewController?.visibleViewController }

    // MARK: - Initialization

    init(rootViewController: UINavigationController, assembler: Assembler) {
        self.rootViewController = rootViewController
        self.assembler = assembler
        self.themeProvider = assembler.resolver.resolve(ThemeProviderProtocol.self)
        self.themeProvider?.appearanceSetup()
    }

    // MARK: - Private API

    private func setupInteractiveTransition(for viewController: UIViewController) {
        guard let visibleViewController = visibleViewController as? InteractiveTransitioningCapable else { return }
        let transitioningDelegate = transitioningDelegates[viewController] ??
            assembler.resolver.resolve(InteractiveTransitioningDelegate.self)

        transitioningDelegates[viewController] = transitioningDelegate
        transitioningDelegate?.isTransitionInteractive = visibleViewController.isTransitionInteractive
        viewController.modalPresentationStyle = .custom
        viewController.transitioningDelegate = transitioningDelegate?.delegate
        visibleViewController.onInteractiveTransition = { gestureRecognizer in
            transitioningDelegate?.updateTransition(using: gestureRecognizer)
        }
    }
}

// MARK: - RouterProtocol protocol conformance

extension Router: RouterProtocol {

    // Presentation
    func setRootView(_ view: View, animated: Bool, fullscreen: Bool) {
        guard let viewController = view.presentableEntity else { return }
        rootViewController?.isNavigationBarHidden = fullscreen
        rootViewController?.setViewControllers([viewController], animated: animated)
    }

    func present(_ view: View, animated: Bool = true, completion: Completion? = nil) {
        guard let viewController = view.presentableEntity else { return }
        // Custom presentation if needed
        switch viewController {
        case let viewController as SideMenuViewController: setupInteractiveTransition(for: viewController)
        default: break
        }
        rootViewController?.present(viewController, animated: animated, completion: completion)
    }

    func push(_ view: View, animated: Bool = true) {
        guard let viewController = view.presentableEntity else { return }
        rootViewController?.pushViewController(viewController, animated: animated)
    }

    // Dismissal
    func dismiss(animated: Bool = true, completion: Completion? = nil) {
        let viewController = visibleViewController
        //  Custom dismissal if needed
        switch viewController {
        case let viewController as SideMenuViewController: setupInteractiveTransition(for: viewController)
        default: break
        }
        rootViewController?.dismiss(animated: animated) { [weak self] in
            // Clear strong reference to transitioning delegate after dismissal
            viewController.flatMap { self?.transitioningDelegates[$0] = nil }
            completion?()
        }
    }

    func pop(animated: Bool = true) {
        rootViewController?.popViewController(animated: animated)
    }

    func popToRootView(animated: Bool) {
        rootViewController?.popToRootViewController(animated: animated)
    }
}
