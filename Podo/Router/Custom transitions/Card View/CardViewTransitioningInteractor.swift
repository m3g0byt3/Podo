//
//  CardViewTransitioningInteractor.swift
//  Podo
//
//  Created by m3g0byt3 on 24/08/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit

final class CardViewTransitioningInteractor: UIPercentDrivenInteractiveTransition {

    // MARK: - Constants

    private static let boundaryPercent: CGFloat = 0.25
    private static let defaultPercentComplete: CGFloat = 0.0

    // MARK: - Private properties

    private weak var recognizer: UIPanGestureRecognizer?
    private weak var dismissedView: UIView?
    private var initialFrame: CGRect?

    // MARK: - Initialization

    convenience init(recognizer: UIPanGestureRecognizer) {
        self.init()
        self.recognizer = recognizer
        recognizer.addTarget(self, action: #selector(panGestureHandler(_:)))
    }

    deinit {
        recognizer?.removeTarget(self, action: nil)
    }

    override private init() {}

    // MARK: - Public API

    override func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        dismissedView = transitionContext.view(forKey: .from)
        initialFrame = dismissedView?.frame
        super.startInteractiveTransition(transitionContext)
    }

    // MARK: - Private API

    private func percentComplete(for recognizer: UIPanGestureRecognizer) -> CGFloat {
        guard
            let dismissedView = dismissedView,
            let initialFrame = initialFrame
        else { return CardViewTransitioningInteractor.defaultPercentComplete }
        let yTranslation = recognizer.translation(in: dismissedView).y
        return fabs(yTranslation / initialFrame.height)
    }

    // MARK: - Control handlers

    @objc private func panGestureHandler(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began: break
        case .changed: update(percentComplete(for: sender))
        case .ended:
            if percentComplete(for: sender) >= CardViewTransitioningInteractor.boundaryPercent {
                finish()
            } else {
                cancel()
            }
        default: cancel()
        }
    }
}
