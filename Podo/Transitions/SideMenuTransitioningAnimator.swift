//
//  SideMenuTransitioningAnimator.swift
//  Podo
//
//  Created by m3g0byt3 on 24/11/2017.
//  Copyright © 2017 m3g0byt3. All rights reserved.
//

import UIKit

class SideMenuTransitioningAnimator: NSObject {
    
    //MARK: - Properties
    private let presentationType: PresentationType
    
    //MARK: - Inits
    init(for type: PresentationType) {
        self.presentationType = type
    }
}

extension SideMenuTransitioningAnimator: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return AnimationDuration.normal
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewController(forKey: .to) else { return }
        let animatedView: UIView
        let finalViewFrame: CGRect
        
        switch presentationType {
        case .presentation:
            guard let toView = transitionContext.view(forKey: .to) else { return }
            finalViewFrame = transitionContext.finalFrame(for: toVC)
            toView.frame = CGRect(origin: CGPoint(x: -finalViewFrame.width, y: toView.frame.origin.y),
                                  size: finalViewFrame.size)
            transitionContext.containerView.addSubview(toView)
            animatedView = toView
        case .dismissal:
            guard let fromView = transitionContext.view(forKey: .from) else { return }
            finalViewFrame = CGRect(origin: CGPoint(x: -fromView.frame.width, y: fromView.frame.origin.y),
                                    size: fromView.frame.size)
            animatedView = fromView
        }
        
        UIView.animate(withDuration: AnimationDuration.normal, animations: {
            animatedView.frame = finalViewFrame
        }) { _ in
            let status = !transitionContext.transitionWasCancelled
            // After a failed presentation or successful dismissal, remove the view.
            if (self.presentationType == .dismissal && status) || (self.presentationType == .presentation && !status) {
                animatedView.removeFromSuperview()
            }
            
            transitionContext.completeTransition(status)
        }
    }
}
