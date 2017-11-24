//
//  SideMenuTransitioningAnimator.swift
//  Podo
//
//  Created by m3g0byt3 on 24/11/2017.
//  Copyright © 2017 m3g0byt3. All rights reserved.
//

import UIKit

class SideMenuTransitioningAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return AnimationDuration.normal
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //TODO: Add some code here
    }
}
