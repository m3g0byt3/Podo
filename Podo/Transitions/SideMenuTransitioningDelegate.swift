//
//  SideMenuTransitioningDelegate.swift
//  Podo
//
//  Created by m3g0byt3 on 24/11/2017.
//  Copyright © 2017 m3g0byt3. All rights reserved.
//

import UIKit

class SideMenuTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    typealias InteractorClosure = (UIPanGestureRecognizer) -> Void
    
    private weak var interactor: SideMenuTransitioningInteractor?
    var interactorClosure: InteractorClosure? { return interactor?.updateAnimationBasedOn }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SideMenuTransitioningAnimator(for: .presentation)
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SideMenuTransitioningAnimator(for: .dismissal)
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return SideMenuPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        let presentationInteractor = SideMenuTransitioningInteractor(for: .presentation)
        interactor = presentationInteractor
        return presentationInteractor
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        //TODO: return correct interaction Controller for dismissal
        return nil
    }
}
