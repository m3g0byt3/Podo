//
//  Stylable.swift
//  Podo
//
//  Created by m3g0byt3 on 14/04/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit

/**
 Use POP for aggregation.
 Customization details should be provided by the inheritors of this protocol.
 Customization details should be applied in the `customize()` func, see example below:
 ```
 protocol ColoredView: Customizable {
    var color: UIColor { get }
 }

 protocol BlackView: ColoredView {}

 extension BlackView {
    var color: UIColor { return .black }
 }

 extension UIView: Customizable {
    func customize() {
        if let custom = self as? ColoredView {
            self.backgroundColor = custom.color
        }
    }

    override open func awakeFromNib() {
        super.awakeFromNib()
        customize()
    }
 }

 final class CustomView: UIView, BlackView {}
 ```
 */
protocol Customizable {

    /// Called from `awakeFromNib()` in the protocol extensions, don't call directly.
    func customize()
}

extension UIViewController: Customizable {

    // MARK: - Constants

    private static let delay: TimeInterval = 0.3

    // MARK: - Customizable protocol conformance

    func customize() {
        if let custom = self as? SideMenuPresenting & InteractiveTransitioningCapable {
            // Setup UIBarButtonItem
            let sideMenuButton = UIBarButtonItem(image: R.image.sideMenuIcon(),
                                                 style: .plain,
                                                 target: custom.sideMenuButtonHandler,
                                                 action: custom.sideMenuButtonHandler.selector)
            navigationItem.leftBarButtonItem = sideMenuButton
            // Setup UIScreenEdgePanGestureRecognizer
            let recognizer = UIScreenEdgePanGestureRecognizer(target: custom.panGestureRecognizerHandler,
                                                              action: custom.panGestureRecognizerHandler.selector)
            recognizer.edges = .left
            // ¯\_(ツ)_/¯
            // Yeah, ugly async hack, but this prevents various race conditions
            // when we're accessing `self.view` property too early.
            DispatchQueue.main.asyncAfter(deadline: .now() + type(of: self).delay) { [weak self] in
                self?.view.addGestureRecognizer(recognizer)
            }
        }

        if let custom = self as? NavigationBarTitleViewCustomizable {
            // Setup `titleView` in `navigationItem`
            navigationItem.titleView = custom.titleView
        }
    }

    // MARK: - Necessary Overriding

    override open func awakeFromNib() {
        super.awakeFromNib()
        customize()
    }
}

extension UIView: Customizable {

    // MARK: - Customizable protocol conformance

    func customize() {
        if let custom = self as? CustomMargin {
            let defaultMargin = max(layoutMargins.left,
                                    layoutMargins.right,
                                    layoutMargins.top,
                                    layoutMargins.bottom)
            let customMargin = defaultMargin * custom.marginMultiplier

            layoutMargins = UIEdgeInsets(top: customMargin,
                                         left: customMargin,
                                         bottom: customMargin,
                                         right: customMargin)
        }
    }

    // MARK: - Necessary Overriding

    override open func awakeFromNib() {
        super.awakeFromNib()
        customize()
    }
}
