//
//  CardViewPresentationController.swift
//  Podo
//
//  Created by m3g0byt3 on 23/08/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit

final class CardViewPresentationController: UIPresentationController {

    // MARK: - Public properties

    override var frameOfPresentedViewInContainerView: CGRect {
        guard let cardViewController = presentedViewController as? CardViewPresentable else {
            return presentingViewController.view.frame
        }
        return cardViewController.frameInPresentingView(presentingViewController.view)
    }

    override var presentedView: UIView? {
        return wrapperView
    }

    // MARK: - Private properties

    private var dimmingView: UIView?
    private var wrapperView: UIView?

    private var boundsOfPresentedViewInContainerView: CGRect {
        return CGRect(origin: .zero, size: frameOfPresentedViewInContainerView.size)
    }

    private var cornerRadius: CGFloat {
        guard let container = containerView else { return 0 }
        return container.frame.width / Constant.CardView.cornerRadiusToWidthRatio
    }

    // MARK: - Public API

    override func presentationTransitionWillBegin() {
        guard
            let presentedView = super.presentedView,
            let bottomWrapperView = bottomWrapperViewFactory(),
            let cornerWrapperView = cornerWrapperViewFactory(),
            let topWrapperView = topWrapperViewFactory()
        else { return }

        topWrapperView.addSubview(presentedView)
        cornerWrapperView.addSubview(topWrapperView)
        bottomWrapperView.addSubview(cornerWrapperView)

        wrapperView = bottomWrapperView
        dimmingView = dimmingViewFactory()

        presentingViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.dimmingView?.alpha = Constant.DimmingViewAlpha.final
        })
    }

    override func presentationTransitionDidEnd(_ completed: Bool) {
        if !completed {
            wrapperView = nil
            dimmingView = nil
        }
    }

    override func dismissalTransitionWillBegin() {
        presentingViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.dimmingView?.alpha = Constant.DimmingViewAlpha.initial
        })
    }

    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            wrapperView = nil
            dimmingView = nil
        }
    }

    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        presentedViewController.view.frame = boundsOfPresentedViewInContainerView
    }

    // MARK: - Private API

    private func dimmingViewFactory() -> UIView? {
        guard let container = containerView else { return nil }
        let view = UIView(frame: container.frame)
        let tapSelector = #selector(type(of: self).tapGestureHandler(_:))
        let tapGesture = UITapGestureRecognizer(target: self, action: tapSelector)
        view.addGestureRecognizer(tapGesture)
        view.backgroundColor = .black
        view.isOpaque = false
        view.alpha = Constant.DimmingViewAlpha.initial
        container.addSubview(view)
        return view
    }

    private func bottomWrapperViewFactory() -> UIView? {
        let view = UIView(frame: frameOfPresentedViewInContainerView)
        view.layer.shadowOpacity = Constant.CardView.shadowOpacity
        view.layer.shadowRadius = Constant.CardView.shadowRadius
        view.layer.shadowOffset = Constant.CardView.shadowOffset
        return view
    }

    private func cornerWrapperViewFactory() -> UIView? {
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: -cornerRadius, right: 0)
        let frame = boundsOfPresentedViewInContainerView.inset(by: insets)
        let view = UIView(frame: frame)
        view.layer.cornerRadius = cornerRadius
        view.layer.masksToBounds = true
        return view
    }

    private func topWrapperViewFactory() -> UIView? {
        return UIView(frame: boundsOfPresentedViewInContainerView)
    }

    // MARK: - Control handlers

    @objc private func tapGestureHandler(_ sender: UITapGestureRecognizer) {
        presentingViewController.dismiss(animated: true)
    }
}
