//
//  KeyboardNotification.swift
//  Podo
//
//  Created by m3g0byt3 on 13/07/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit

/// Simple wrapper for `UIKeyboardWillShow` and `UIKeyboardWillHide` notifications.
struct KeyboardNotification {

    /// `UIKeyboardFrameBeginUserInfoKey` key. Equals `CGRect.zero` if key not found in the `userInfo` dictionary.
    let beginFrame: CGRect
    /// `UIKeyboardFrameEndUserInfoKey` key. Equals `CGRect.zero` if key not found in the `userInfo` dictionary.
    let endFrame: CGRect
    /// `UIKeyboardAnimationDurationUserInfoKey` key. Equals `0` if key not found in the `userInfo` dictionary.
    let duration: TimeInterval
    /// `UIKeyboardAnimationCurveUserInfoKey` key.  Equals `.easeInOut` if key not found in the `userInfo` dictionary.
    let curve: UIView.AnimationCurve
    /// Based on `curve` property. Equals `.curveEaseInOut` if key not found in the `userInfo` dictionary.
    var options: UIView.AnimationOptions {
        return UIView.AnimationOptions(curve: curve)
    }
    /// Based on `frame` property. Equals `0` if key not found in the `userInfo` dictionary.
    var offset: CGFloat {
        return endFrame.size.height
    }

    /**
     Failable init from `UIKeyboardWillShow` and `UIKeyboardWillHide` notifications.
     - parameter notification: `Notification` object.
     - Important: Returns `nil` if passed notification does not contain `userInfo` dictionary.
     */
    init?(_ notification: Notification) {
        guard let info = notification.userInfo else { return nil }
        let beginFrame = info[UIKeyboardFrameBeginUserInfoKey] as? CGRect
        let endFrame = info[UIKeyboardFrameEndUserInfoKey] as? CGRect
        let duration = info[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval
        let curveRaw = info[UIKeyboardAnimationCurveUserInfoKey] as? Int

        self.beginFrame = beginFrame ?? CGRect.zero
        self.endFrame = endFrame ?? CGRect.zero
        self.duration = duration ?? 0
        self.curve = curveRaw.flatMap(UIView.AnimationCurve.init) ?? .easeInOut
    }
}
