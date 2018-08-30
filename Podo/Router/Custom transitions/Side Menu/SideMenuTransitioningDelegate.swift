//
//  SideMenuTransitioningDelegate.swift
//  Podo
//
//  Created by m3g0byt3 on 24/11/2017.
//  Copyright © 2017 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit

final class SideMenuTransitioningDelegate: NSObject,
                                           InteractiveTransitioningDelegate {

    // MARK: - Properties

    private weak var interactor: SideMenuTransitioningInteractor?
    var isTransitionInteractive: Bool

    // MARK: - Initialization

    init(interactiveTransition: Bool = true) {
        self.isTransitionInteractive = interactiveTransition
    }

    // MARK: - Public API

    func updateTransition(using gestureRecognizer: UIPanGestureRecognizer) {
        interactor?.updateAnimation(using: gestureRecognizer)
    }

    // MARK: - Private API

    private func interactorForPresentationOfType(_ type: PresentationType) -> SideMenuTransitioningInteractor {
        // Create new SideMenuTransitioningInteractor instance of given type
        let presentationInteractor = SideMenuTransitioningInteractor(for: type)
        // Update our private weak property `interactor` because we need reference to the SideMenuTransitioningInteractor instance
        interactor = presentationInteractor
        return presentationInteractor
    }
}

// MARK: - UIViewControllerTransitioningDelegate protocol conformance

extension SideMenuTransitioningDelegate: UIViewControllerTransitioningDelegate {

    typealias AnimatorProtocol = UIViewControllerAnimatedTransitioning

    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> AnimatorProtocol? {
        return SideMenuTransitioningAnimator(for: .presentation)
    }

    func animationController(forDismissed dismissed: UIViewController) -> AnimatorProtocol? {
        return SideMenuTransitioningAnimator(for: .dismissal)
    }

    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        return SideMenuPresentationController(presentedViewController: presented, presenting: presenting)
    }

    func interactionControllerForPresentation(using animator: AnimatorProtocol) -> UIViewControllerInteractiveTransitioning? {
        return isTransitionInteractive ? interactorForPresentationOfType(.presentation) : nil
    }

    func interactionControllerForDismissal(using animator: AnimatorProtocol) -> UIViewControllerInteractiveTransitioning? {
        return isTransitionInteractive ? interactorForPresentationOfType(.dismissal) : nil
    }
}
