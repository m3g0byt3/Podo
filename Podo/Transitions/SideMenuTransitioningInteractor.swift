//
//  SideMenuTransitioningInteractor.swift
//  Podo
//
//  Created by m3g0byt3 on 28/11/2017.
//  Copyright © 2017 m3g0byt3. All rights reserved.
//

import UIKit

class SideMenuTransitioningInteractor: UIPercentDrivenInteractiveTransition {
    
    //MARK: - Properties
    private let presentationType: PresentationType
    private weak var containerView: UIView?
    
    //MARK: - Inits
    init(for type: PresentationType) {
        self.presentationType = type
    }
    
    //MARK: - Public API
    func updateAnimationBasedOn(recognizer: UIPanGestureRecognizer) {
        guard let container = containerView else { return }
        
        switch recognizer.state {
        case .began:
            recognizer.setTranslation(CGPoint.zero, in: container)
        case .changed:
            let translation = recognizer.translation(in: container)
            let transitionPercentage = fabs(translation.x / container.frame.width)
            update(transitionPercentage)
        default:
            let translation = recognizer.translation(in: container)
            let transitionPercentage = fabs(translation.x / container.frame.width)
            if (transitionPercentage > SideMenu.boundaryTransitionPercentage) {
                finish()
            } else {
                cancel()
            }
        }
    }
    
    //MARK: - UIPercentDrivenInteractiveTransition protocol conformance
    override func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        super.startInteractiveTransition(transitionContext)
        containerView = transitionContext.containerView
    }
}
