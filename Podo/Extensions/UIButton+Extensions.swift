//
//  UIButton+Extensions.swift
//  Podo
//
//  Created by m3g0byt3 on 03/07/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import class UIKit.UIButton
import class UIKit.NSMutableAttributedString
import struct UIKit.UIControlState

extension UIButton {

    /**
     Convenience method to change `attributedTitle` for given state without losing existing attributes.
     - parameters:
        - title: The styled text string so use for the title.
        - state: The state that uses the specified title. The possible values are described in `UIControl.State`.
        - preserveAttributes: Preserve or not attributes of current `attributedTitle`.
     */
    func setTitle(_ title: String, for state: UIControlState, preserveAttributes: Bool) {
        if preserveAttributes, let oldTitle = attributedTitle(for: state) {
            let newTitle = NSMutableAttributedString(attributedString: oldTitle)

            newTitle.mutableString.setString(title)
            setAttributedTitle(newTitle, for: state)
        } else {
            setTitle(title, for: state)
        }
    }
}
