//
//  RouterImpl.swift
//  Podo
//
//  Created by m3g0byt3 on 05/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit
import Swinject

final class RouterImpl {

    // MARK: - Properties

    // strong reference to avoid immediate deallocation
    // swiftlint:disable:next weak_delegate
    private var transitioningDelegate: SideMenuTransitioningDelegate?

    private let themeProvider: ThemeProvider?

    private let assembler: Assembler

    private weak var rootViewController: UINavigationController?

    private var visibleViewController: UIViewController? { return rootViewController?.visibleViewController }

    // MARK: - Initialization

    init(_ rootViewController: UINavigationController, assembler: Assembler) {
        self.rootViewController = rootViewController
        self.assembler = assembler
        self.transitioningDelegate = assembler.resolver.resolve(SideMenuTransitioningDelegate.self)
        self.themeProvider = assembler.resolver.resolve(ThemeProvider.self)
        self.themeProvider?.appearanceSetup()
    }

    // MARK: - Private API

    private func setupInteractiveTransition(for viewController: UIViewController?) {
        guard let visibleViewController = visibleViewController as? InteractiveTransitioningCapable else { return }
        transitioningDelegate?.isTransitionInteractive = visibleViewController.isTransitionInteractive
        visibleViewController.onInteractiveTransition = { [weak self] gestureRecognizer in
            self?.transitioningDelegate?.updateTransition(using: gestureRecognizer)
        }
        viewController?.modalPresentationStyle = .custom
        viewController?.transitioningDelegate = transitioningDelegate?.delegate
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
        // SideMenu custom presentation
        if viewController is SideMenuViewController {
            setupInteractiveTransition(for: viewController)
        }
        rootViewController?.present(viewController, animated: animated, completion: completion)
    }

    func push(_ view: View, animated: Bool = true) {
        guard let viewController = view.presentableEntity else { return }
        rootViewController?.pushViewController(viewController, animated: animated)
    }

    // Dismissal
    func dismiss(animated: Bool = true, completion: Completion? = nil) {
        // SideMenu custom dismissal
        if rootViewController?.visibleViewController is SideMenuViewController {
            setupInteractiveTransition(for: rootViewController?.visibleViewController)
        }
        rootViewController?.dismiss(animated: animated, completion: completion)
    }

    func pop(animated: Bool = true) {
        rootViewController?.popViewController(animated: animated)
    }

    func popToRootView(animated: Bool) {
        rootViewController?.popToRootViewController(animated: animated)
    }
}
