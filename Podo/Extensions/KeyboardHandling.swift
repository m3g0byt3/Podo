//
//  KeyboardHandling.swift
//  Podo
//
//  Created by m3g0byt3 on 11/07/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit
import ObjectiveC.runtime

/// Constants for associated objects
private enum AssociatedKeys {

    static var tokensKey: Void?
    static var initialOffset: Void?
    static var inputView: Void?
}

/// Notification names
private enum Names {

    static var willShow: Notification.Name { return .UIKeyboardWillShow }
    static var willHide: Notification.Name { return .UIKeyboardWillHide }
}

/// Moving views behind keyboard automatically.
protocol KeyboardHandling {

    /// (Required) Array of views that should be managed.
    var manageableViews: [UIView] { get }

    /// (Optional) Ratio by which the keyboard height is multiplied. By default equals `1.0`.
    var keyboardOffsetRatio: CGFloat { get }
}

extension KeyboardHandling {

    var keyboardOffsetRatio: CGFloat { return 1.0 }
}

// MARK: - Control methods

extension KeyboardHandling where Self: UIViewController {

    func beginKeyboardHandling() {
        manageableViews.forEach(setupInputAccessoryView(in:))
        beginObserving()
    }

    func endKeyboardHandling() {
        endObserving()
    }
}

// MARK: - Keyboard handling

private extension KeyboardHandling where Self: UIViewController {

    var scrollableViews: [UIScrollView] {
        return manageableViews.compactMap { $0 as? UIScrollView }
    }

    var nonScrollableViews: [UIView] {
        return manageableViews.filter { !($0 is UIScrollView) }
    }

    var customInputView: UIToolbar {
        get {
            if let inputView = objc_getAssociatedObject(self, &AssociatedKeys.inputView) as? UIToolbar {
                return inputView
            }
            let inputView = UIToolbar()
            let backButton = UIBarButtonItem(title: "◀ ", style: .done, target: nil, action: nil)
            let nextButton = UIBarButtonItem(title: " ▶", style: .done, target: nil, action: nil)
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
            let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

            inputView.items = [backButton, nextButton, flexibleSpace, doneButton]
            inputView.items?.forEach { $0.tintColor = .darkGray }
            inputView.sizeToFit()
            objc_setAssociatedObject(self, &AssociatedKeys.inputView, inputView, .OBJC_ASSOCIATION_RETAIN)

            return inputView
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.inputView, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }

    func keyboardShown(_ notification: Notification) {
        guard let parsed = KeyboardNotification(notification) else { return }
        let offset = parsed.offset * keyboardOffsetRatio

        // Handle scrollable views
        for view in scrollableViews where view.contentInset.bottom < offset {
            view.contentInset.bottom += offset
        }

        // Handle not-scrollable views
        guard let textInput = UIResponder.current as? UIView else { return }

        for view in nonScrollableViews {
            let textInputConvertedFrame = view.convert(textInput.frame, from: textInput)
            let textInputMaxY = textInputConvertedFrame.maxY
            let visibleHeight = view.frame.height - offset
            let nonScrollableOffset = textInputMaxY - visibleHeight / 2

            objc_setAssociatedObject(view, &AssociatedKeys.initialOffset, view.frame.origin.y, .OBJC_ASSOCIATION_ASSIGN)

            if textInputMaxY > visibleHeight {
                UIView.animate(withDuration: parsed.duration, delay: 0, options: parsed.options, animations: {
                    view.frame.origin.y -= min(offset, nonScrollableOffset)
                })
            }
        }
    }

    func keyboardDismissed(_ notification: Notification) {
        guard let parsed = KeyboardNotification(notification) else { return }
        let offset = parsed.offset * keyboardOffsetRatio

        // Handle scrollable views
        for view in scrollableViews where view.contentInset.bottom >= offset {
            view.contentInset.bottom -= offset
        }

        // Handle not-scrollable views
        let initialOffset = objc_getAssociatedObject(view, &AssociatedKeys.initialOffset) as? CGFloat ?? 0

        for view in nonScrollableViews {
            UIView.animate(withDuration: parsed.duration, delay: 0, options: parsed.options, animations: {
                view.frame.origin.y = initialOffset
            })
        }
    }

    func setupInputAccessoryView(in view: UIView) {
        if let castedView = view as? _InputAccessoryViewProtocol {
            castedView.inputAccessoryView = customInputView
        } else {
            view.subviews.forEach(setupInputAccessoryView)
        }
    }
    }
}

// MARK: - NotificationCenter stuff

private extension KeyboardHandling where Self: UIViewController {

    func beginObserving() {
        let defaultNC = NotificationCenter.default
        // TODO: observe notifications in separate `KeyboardHandler` class
        let willShowToken = defaultNC.addObserver(forName: Names.willShow, object: nil, queue: nil) { [weak self] note in
            self?.keyboardShown(note)
        }
        // TODO: observe notifications in separate `KeyboardHandler` class
        let willHideToken = defaultNC.addObserver(forName: Names.willHide, object: nil, queue: nil) { [weak self] note in
            self?.keyboardDismissed(note)
        }
        let tokens = [willShowToken, willHideToken]

        objc_setAssociatedObject(self, &AssociatedKeys.tokensKey, tokens, .OBJC_ASSOCIATION_RETAIN)
    }

    func endObserving() {
        if let tokens = objc_getAssociatedObject(self, &AssociatedKeys.tokensKey) as? [NSObjectProtocol] {
            tokens.forEach(NotificationCenter.default.removeObserver(_:))
        }
        objc_removeAssociatedObjects(self)
    }
}
