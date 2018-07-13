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
    static var textInput: Void?
    static var initialOffset: Void?
}

/// Notification names
private enum Names {

    static var willShow: Notification.Name { return .UIKeyboardWillShow }
    static var willHide: Notification.Name { return .UIKeyboardWillHide }
    static var beginEdit: Notification.Name { return .UITextFieldTextDidBeginEditing }
}

/// Moving views behind keyboard automatically.
protocol KeyboardHandling {

    /// (Required) Array of views that should be managed.
    var manageableViews: [UIView] { get }

    /// (Optional) Ratio by which the keyboard height is multiplied. By default equals `1.10`.
    var keyboardOffsetRatio: CGFloat { get }
}

extension KeyboardHandling {

    var keyboardOffsetRatio: CGFloat { return 1.10 }
}

// MARK: - Control methods

extension KeyboardHandling where Self: UIViewController {

    func beginKeyboardHandling() {
        beginObserving()
    }

    func endKeyboardHandling() {
        endObserving()
    }
}

// MARK: - Keyboard handling

private extension KeyboardHandling where Self: UIViewController {

    typealias ParsedNotification = (offset: CGFloat, curve: UIView.AnimationCurve, duration: TimeInterval)

    var scrollableViews: [UIScrollView] {
        return manageableViews.compactMap { $0 as? UIScrollView }
    }

    var nonScrollableViews: [UIView] {
        return manageableViews.filter { !($0 is UIScrollView) }
    }

    func keyboardShown(_ notification: Notification) {
        // Handle scrollable views
        guard let parsed = parseNotification(notification) else { return }

        for view in scrollableViews where view.contentInset.bottom < parsed.offset {
            view.contentInset.bottom += parsed.offset
        }

        // Handle not-scrollable views
        guard let textInput = objc_getAssociatedObject(self, &AssociatedKeys.textInput) as? UIView else { return }

        for view in nonScrollableViews {
            let textInputFrame = view.convert(textInput.frame, from: textInput)
            let visibleHeight = view.frame.height - parsed.offset
            let offset = textInputFrame.maxY - visibleHeight / 2

            if textInputFrame.maxY > visibleHeight {
                let option = UIView.AnimationOptions(curve: parsed.curve)
                objc_setAssociatedObject(self, &AssociatedKeys.initialOffset, view.frame.origin.y, .OBJC_ASSOCIATION_ASSIGN)
                UIView.animate(withDuration: parsed.duration, delay: 0, options: [option], animations: {
                    view.frame.origin.y -= min(offset, parsed.offset)
                })
            }
        }
    }

    func keyboardDismissed(_ notification: Notification) {
        // Handle scrollable views
        guard let parsed = parseNotification(notification) else { return }

        for view in scrollableViews where view.contentInset.bottom >= parsed.offset {
            view.contentInset.bottom -= parsed.offset
        }

        // Handle not-scrollable views
        let initialOffset = objc_getAssociatedObject(self, &AssociatedKeys.initialOffset) as? CGFloat ?? 0

        for view in nonScrollableViews where view.frame.origin.y != initialOffset {
            let option = UIView.AnimationOptions(curve: parsed.curve)
            UIView.animate(withDuration: parsed.duration, delay: 0, options: [option], animations: {
                view.frame.origin.y = initialOffset
            })
        }
    }

    func textInputBeginEditing(_ textInputView: UIView) {
        objc_setAssociatedObject(self, &AssociatedKeys.textInput, textInputView, .OBJC_ASSOCIATION_ASSIGN)
    }

    func parseNotification(_ notification: Notification) -> ParsedNotification? {
        guard
            let info = notification.userInfo,
            let frame = info[UIKeyboardFrameEndUserInfoKey] as? CGRect,
            let duration = info[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval,
            let curveRaw = info[UIKeyboardAnimationCurveUserInfoKey] as? Int,
            let curve = UIView.AnimationCurve(rawValue: curveRaw)
            else { return nil }

        return (frame.height * keyboardOffsetRatio, curve, duration)
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
        // TODO: observe notifications in separate `KeyboardHandler` class
        let beginEditingToken = defaultNC.addObserver(forName: Names.beginEdit, object: nil, queue: nil) { [weak self] note in
            note.object
                .flatMap { $0 as? UIView }
                .map { self?.textInputBeginEditing($0) }
        }
        let tokens = [willShowToken, willHideToken, beginEditingToken]

        objc_setAssociatedObject(self, &AssociatedKeys.tokensKey, tokens, .OBJC_ASSOCIATION_RETAIN)
    }

    func endObserving() {
        if let tokens = objc_getAssociatedObject(self, &AssociatedKeys.tokensKey) as? [NSObjectProtocol] {
            tokens.forEach(NotificationCenter.default.removeObserver(_:))
        }
        objc_removeAssociatedObjects(self)
    }
}
