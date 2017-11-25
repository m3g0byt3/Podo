//
//  SideMenuTransitioningDelegate.swift
//  Podo
//
//  Created by m3g0byt3 on 24/11/2017.
//  Copyright © 2017 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit

class SideMenuTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SideMenuTransitioningAnimator(for: .presentation)
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SideMenuTransitioningAnimator(for: .dismissal)
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return SideMenuPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
