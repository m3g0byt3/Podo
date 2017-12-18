//
//  SideMenuPresentationController.swift
//  Podo
//
//  Created by m3g0byt3 on 24/11/2017.
//  Copyright © 2017 m3g0byt3. All rights reserved.
//

import UIKit

class SideMenuPresentationController: UIPresentationController {
    
    //MARK: - Properties
    private lazy var dimmingView: UIView? = { this in
        guard let container = self.containerView else { return nil }
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(gestureHandler(_:)))
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gestureHandler(_:)))
        this.addGestureRecognizer(panGestureRecognizer)
        this.addGestureRecognizer(tapGestureRecognizer)
        this.frame = container.frame
        this.backgroundColor = .black
        this.alpha = DimmingViewAlpha.initial
        this.clipsToBounds = true
        return this
    }(UIView())
    
    //MARK: - Control handlers
    @objc private func gestureHandler(_ sender: UIGestureRecognizer) {
        let transitionDelegate = presentedViewController.transitioningDelegate as? SideMenuTransitioningDelegate
        
        switch sender {
        case is UITapGestureRecognizer:
            transitionDelegate?.interactivePresentation = false
            presentedViewController.dismiss(animated: true)
        case let sender as UIPanGestureRecognizer where sender.state == .began:
            transitionDelegate?.interactivePresentation = true
            presentedViewController.dismiss(animated: true)
        case let sender as UIPanGestureRecognizer:
            transitionDelegate?.interactorClosure?(sender)
        default: break
        }
    }
    
    //MARK: - Public API
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let container = containerView else { return UIScreen.main.bounds }
        return CGRect(x: 0, y: 0, width: container.frame.width * SideMenu.widthRatio,
                      height: container.frame.height)
    }
    
    override func presentationTransitionWillBegin() {
        dimmingView.map { containerView?.addSubview($0) }
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [unowned self] _ in
            self.dimmingView?.alpha = DimmingViewAlpha.final
        })
        presentingViewController.transitionCoordinator?.animateAlongsideTransition(in: presentingViewController.view, animation: { [unowned self] _ in
            self.presentingViewController.horizontalContentLayoutOffset += self.frameOfPresentedViewInContainerView.width
        })
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        if !completed {
            dimmingView?.removeFromSuperview()
        }
    }
    
    override func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [unowned self] _ in
            self.dimmingView?.alpha = DimmingViewAlpha.initial
        })
        presentingViewController.transitionCoordinator?.animateAlongsideTransition(in: presentingViewController.view, animation: { [unowned self] _ in
            self.presentingViewController.horizontalContentLayoutOffset -= self.frameOfPresentedViewInContainerView.width * 2
        })
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            dimmingView?.removeFromSuperview()
        }
    }
}
