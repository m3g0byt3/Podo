//
//  CardViewTransitioningAnimator.swift
//  Podo
//
//  Created by m3g0byt3 on 24/08/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit

final class CardViewTransitioningAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    // MARK: - UIViewControllerAnimatedTransitioning protocol conformance

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Constant.CardView.presentationDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromView = transitionContext.view(forKey: .from),
            let fromVC = transitionContext.viewController(forKey: .from)
        else { return }

        let finalFrame = transitionContext.finalFrame(for: fromVC)
        var calculatedEndFrame = finalFrame

        calculatedEndFrame.origin.y += finalFrame.height * 2

        UIView.animate(withDuration: transitionDuration(using: nil),
                       animations: {
                            fromView.frame = calculatedEndFrame
                       },
                       completion: { _ in
                            let isSuccessful = !transitionContext.transitionWasCancelled
                            if isSuccessful {
                                fromView.removeFromSuperview()
                            }
                            transitionContext.completeTransition(isSuccessful)
                       }
        )
    }
}
