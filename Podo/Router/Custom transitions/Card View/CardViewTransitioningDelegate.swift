//
//  CardViewTransitioningDelegate.swift
//  Podo
//
//  Created by m3g0byt3 on 23/08/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit

final class CardViewTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {

    // MARK: - Private properties

    private weak var presentedViewController: UIViewController?

    // MARK: - UIViewControllerTransitioningDelegate protocol conformance

    func presentationController(
        forPresented presented: UIViewController,
        presenting: UIViewController?,
        source: UIViewController
    ) -> UIPresentationController? {
        self.presentedViewController = presented
        return CardViewPresentationController(presentedViewController: presented,
                                              presenting: presenting)
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CardViewTransitioningAnimator()
    }

    func interactionControllerForDismissal(
        using animator: UIViewControllerAnimatedTransitioning
    ) -> UIViewControllerInteractiveTransitioning? {
        guard
            let cardViewPresentable = presentedViewController as? CardViewPresentable,
            let recognizer = cardViewPresentable.panGesture
        else { return nil }
        return CardViewTransitioningInteractor(recognizer: recognizer)
    }
}
