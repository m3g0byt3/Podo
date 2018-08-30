//
//  SideMenuPresenting.swift
//  Podo
//
//  Created by m3g0byt3 on 14/04/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit
import ObjectiveC.runtime

/// Constants for associated objects
private enum AssociatedKeys {

    static var buttonHandler: Void?
    static var recognizerHandler: Void?
}

/// Object that can present side menu.
protocol SideMenuPresenting: class, Customizable {

    var onSideMenuSelection: Completion? { get set }
    var sideMenuButtonHandler: AnyMethodWrapper<UIBarButtonItem> { get }
    var panGestureRecognizerHandler: AnyMethodWrapper<UIPanGestureRecognizer> { get }
}

extension SideMenuPresenting where Self: InteractiveTransitioningCapable {

    private typealias WrapperClosure = (Any?) -> Void

    private func wrapper<T>(for closure: @escaping @autoclosure () -> WrapperClosure, key: inout Void?) -> AnyMethodWrapper<T> {
        func createWrapper() -> AnyMethodWrapper<T> {
            let wrapper = AnyMethodWrapper<T>(closure())
            objc_setAssociatedObject(self, &key, wrapper, .OBJC_ASSOCIATION_RETAIN)
            return wrapper
        }
        return objc_getAssociatedObject(self, &key) as? AnyMethodWrapper<T> ?? createWrapper()
    }

    var sideMenuButtonHandler: AnyMethodWrapper<UIBarButtonItem> {
        let closure: WrapperClosure = { [weak self] _ in
            self?.isTransitionInteractive = false
            self?.onSideMenuSelection?()
        }
        return wrapper(for: closure, key: &AssociatedKeys.buttonHandler)
    }

    var panGestureRecognizerHandler: AnyMethodWrapper<UIPanGestureRecognizer> {
        let closure: WrapperClosure = { [weak self] sender in
            guard let sender = sender as? UIPanGestureRecognizer else { return }
            switch sender.state {
            case .began:
                self?.isTransitionInteractive = true
                self?.onSideMenuSelection?()
            default:
                self?.onInteractiveTransition?(sender)
            }
        }
        return wrapper(for: closure, key: &AssociatedKeys.recognizerHandler)
    }
}
