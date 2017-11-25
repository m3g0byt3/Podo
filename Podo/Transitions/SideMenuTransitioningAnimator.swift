//
//  SideMenuTransitioningAnimator.swift
//  Podo
//
//  Created by m3g0byt3 on 24/11/2017.
//  Copyright © 2017 m3g0byt3. All rights reserved.
//

import UIKit

class SideMenuTransitioningAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let action: Action
    
    enum Action {
        case presentation, dismissal
    }
    
    init(for action: Action) {
        self.action = action
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return AnimationDuration.normal
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewController(forKey: .to) else { return }
        let animatedView: UIView
        let finalFrame: CGRect
        
        switch action {
        case .presentation:
            guard let toView = transitionContext.view(forKey: .to) else { return }
            finalFrame = transitionContext.finalFrame(for: toVC)
            toView.frame = CGRect(origin: CGPoint(x: -finalFrame.width, y: toView.frame.origin.y),
                                  size: finalFrame.size)
            transitionContext.containerView.addSubview(toView)
            animatedView = toView
        case .dismissal:
            guard let fromView = transitionContext.view(forKey: .from) else { return }
            finalFrame = CGRect(origin: CGPoint(x: -fromView.frame.width, y: fromView.frame.origin.y),
                                size: fromView.frame.size)
            animatedView = fromView
        }
        
        UIView.animate(withDuration: AnimationDuration.normal, animations: {
            animatedView.frame = finalFrame
        }) { _ in
            let status = !transitionContext.transitionWasCancelled
            // After a failed presentation or successful dismissal, remove the view.
            if (self.action == .dismissal && status) || (self.action == .presentation && !status) {
                animatedView.removeFromSuperview()
            }
            
            transitionContext.completeTransition(status)
        }
    }
}
