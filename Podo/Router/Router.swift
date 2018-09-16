//
//  Router.swift
//  Podo
//
//  Created by m3g0byt3 on 05/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//
// swiftlint:disable weak_delegate

import Foundation
import UIKit
import Swinject

final class Router {

    // MARK: - Properties

    private let assembler: Assembler
    private weak var rootViewController: UINavigationController?
    private var visibleViewController: UIViewController? { return rootViewController?.visibleViewController }
    private lazy var cardViewTransitioningDelegate = assembler.resolver.resolve(UIViewControllerTransitioningDelegate.self)
    private lazy var sideMenuTransitioningDelegate = assembler.resolver.resolve(InteractiveTransitioningDelegate.self)

    // MARK: - Initialization

    init(rootViewController: UINavigationController,
         themeAdapter: ThemeAdapterProtocol,
         assembler: Assembler) {

        self.rootViewController = rootViewController
        self.assembler = assembler
        themeAdapter.appearanceSetup()
    }

    // MARK: - Private API

    private func setupSideMenuTransition(for viewController: UIViewController) {
        guard let visibleViewController = visibleViewController as? InteractiveTransitioningCapable else { return }
        sideMenuTransitioningDelegate?.isTransitionInteractive = visibleViewController.isTransitionInteractive
        viewController.modalPresentationStyle = .custom
        viewController.transitioningDelegate = sideMenuTransitioningDelegate?.delegate
        visibleViewController.onInteractiveTransition = { [weak self] gestureRecognizer in
            self?.sideMenuTransitioningDelegate?.updateTransition(using: gestureRecognizer)
        }
    }

    private func setupCardViewTransition(for viewController: UIViewController) {
        viewController.modalPresentationStyle = .custom
        viewController.transitioningDelegate = cardViewTransitioningDelegate
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
        case let viewController as SideMenuViewController: setupSideMenuTransition(for: viewController)
        case let viewController as PaymentResultViewController: setupCardViewTransition(for: viewController)
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
        // Custom dismissal if needed
        switch viewController {
        case let viewController as SideMenuViewController: setupSideMenuTransition(for: viewController)
        default: break
        }
        rootViewController?.dismiss(animated: animated) { completion?() }
    }

    func pop(animated: Bool = true) {
        rootViewController?.popViewController(animated: animated)
    }

    func popToRootView(animated: Bool) {
        rootViewController?.popToRootViewController(animated: animated)
    }

    // URL Schemes and Universal Links handling
    func open(url: URL) {
        if #available(iOS 10, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}
