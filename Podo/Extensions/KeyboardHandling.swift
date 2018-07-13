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

    func keyboardShown(_ notification: Notification) {
        guard let parsed = parseNotification(notification) else { return }
        for view in scrollableViews where view.contentInset.bottom < parsed.offset {
            view.contentInset.bottom += parsed.offset
        }
    }

    func keyboardDismissed(_ notification: Notification) {
        guard let parsed = parseNotification(notification) else { return }
        for view in scrollableViews where view.contentInset.bottom >= parsed.offset {
            view.contentInset.bottom -= parsed.offset
        }
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
        let tokens = [willShowToken, willHideToken]

        objc_setAssociatedObject(self, &AssociatedKeys.tokensKey, tokens, .OBJC_ASSOCIATION_RETAIN)
    }

    func endObserving() {
        if let tokens = objc_getAssociatedObject(self, &AssociatedKeys.tokensKey) as? [NSObjectProtocol] {
            tokens.forEach(NotificationCenter.default.removeObserver(_:))
        }
    }
}
