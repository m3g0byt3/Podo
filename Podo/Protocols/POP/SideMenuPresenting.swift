//
//  SideMenuPresenting.swift
//  Podo
//
//  Created by m3g0byt3 on 14/04/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit
import ObjectiveC

/**
 Constants for associated objects
 */
private enum AssociatedKeys {

    static var buttonHandler: Void?
    static var recognizerHandler: Void?
}

/**
 Object that can present side menu.
 */
protocol SideMenuPresenting: class, Customizable {

    var onSideMenuSelection: Completion? { get set }
    var sideMenuButtonHandler: AnyMethodWrapper<UIBarButtonItem> { get }
    var panGestureRecognizerHandler: AnyMethodWrapper<UIPanGestureRecognizer> { get }
}

extension SideMenuPresenting where Self: InteractiveTransitioningCapable {

    var sideMenuButtonHandler: AnyMethodWrapper<UIBarButtonItem> {

        func createWrapper() -> AnyMethodWrapper<UIBarButtonItem> {
            let wrapper = AnyMethodWrapper<UIBarButtonItem> { [weak self] _ in
                self?.isTransitionInteractive = false
                self?.onSideMenuSelection?()
            }
            objc_setAssociatedObject(self, &AssociatedKeys.buttonHandler, wrapper, .OBJC_ASSOCIATION_RETAIN)

            return wrapper
        }

        return objc_getAssociatedObject(self, &AssociatedKeys.buttonHandler) as? AnyMethodWrapper<UIBarButtonItem> ?? createWrapper()
    }

    var panGestureRecognizerHandler: AnyMethodWrapper<UIPanGestureRecognizer> {

        func createWrapper() -> AnyMethodWrapper<UIPanGestureRecognizer> {
            let wrapper = AnyMethodWrapper<UIPanGestureRecognizer> { [weak self] sender in
                guard let sender = sender else { return }
                switch sender.state {
                case .began:
                    self?.isTransitionInteractive = true
                    self?.onSideMenuSelection?()
                default:
                    self?.onInteractiveTransition?(sender)
                }
            }
            objc_setAssociatedObject(self, &AssociatedKeys.recognizerHandler, wrapper, .OBJC_ASSOCIATION_RETAIN)

            return wrapper
        }

        return objc_getAssociatedObject(self, &AssociatedKeys.recognizerHandler) as? AnyMethodWrapper<UIPanGestureRecognizer> ?? createWrapper()
    }
}
