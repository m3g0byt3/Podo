//
//  SideMenuTransitioningInteractor.swift
//  Podo
//
//  Created by m3g0byt3 on 28/11/2017.
//  Copyright © 2017 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit

final class SideMenuTransitioningInteractor: UIPercentDrivenInteractiveTransition {

    // MARK: - Properties

    private let presentationType: PresentationType
    private weak var containerView: UIView?
    private var boundaryTransitionPercentage: CGFloat {
        switch presentationType {
        case .presentation: return Constant.SideMenu.boundaryTransitionPercentage + Constant.SideMenu.boundaryTransitionPercentageOffset
        case .dismissal: return Constant.SideMenu.boundaryTransitionPercentage - Constant.SideMenu.boundaryTransitionPercentageOffset
        }
    }

    // MARK: - Initialization

    init(for type: PresentationType) {
        self.presentationType = type
    }

    // MARK: - Public API

    func updateAnimation(using gestureRecognizer: UIPanGestureRecognizer) {
        guard let container = containerView else { return }

        func transitionPercentageFor(_ gestureRecognizer: UIPanGestureRecognizer, in view: UIView) -> CGFloat {
            let translation = gestureRecognizer.translation(in: view)
            return fabs(translation.x / view.frame.width)
        }

        switch gestureRecognizer.state {
        case .began:
            gestureRecognizer.setTranslation(CGPoint.zero, in: container)
        case .changed:
            update(transitionPercentageFor(gestureRecognizer, in: container))
        default:
            if transitionPercentageFor(gestureRecognizer, in: container) > boundaryTransitionPercentage {
                finish()
            } else {
                cancel()
            }
        }
    }

    // MARK: - UIPercentDrivenInteractiveTransition protocol conformance

    override func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        super.startInteractiveTransition(transitionContext)
        containerView = transitionContext.containerView
    }
}
