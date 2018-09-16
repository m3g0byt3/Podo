//
//  UIViewController+Extensions.swift
//  Podo
//
//  Created by m3g0byt3 on 28/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

    /// Private func used by `storyboardInstance()` public wrapper.
    private static func _storyboardInstance<T: UIViewController>() -> T? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateInitialViewController() as? T
    }

    /// Returns new UIViewController instance from storyboard with the same name (if exist).
    /// - returns: New UIViewController instance.
    static func storyboardInstance() -> Self? {
        return _storyboardInstance()
    }

    /// Horizontal offset for UIViewController view.
    var horizontalContentLayoutOffset: CGFloat {
        get {
            return view.frame.origin.x
        }
        set {
            view.frame.origin.x += newValue
            navigationController?.navigationBar.frame.origin.x += newValue
            // Change toolBar origin only if it isn't hidden, or it will be misplaced
            if let isToolbarHidden = navigationController?.isToolbarHidden, !isToolbarHidden {
                navigationController?.toolbar?.frame.origin.x += newValue
            }
        }
    }

    /// Inner visible (first) controller for `UINavigationController` and `UITabBarController`
    /// or controller itself for `UIViewController`.
    var contentViewController: UIViewController? {
        switch self {
        case let navigationController as UINavigationController:
            return navigationController.viewControllers.first?.contentViewController
        case let tabBarController as UITabBarController:
            return tabBarController.viewControllers?.first?.contentViewController
        default:
            return self
        }
    }

    /// Custom layoutGuide identifier.
    @available(iOS 9, *)
    private static var identifier: String {
        return "com.m3g0byt3.podo.safeAreaLayoutGuide"
    }

    /// `safeAreaLayoutGuide` for `UIViewController` on iOS 9.x and above.
    @available(iOS 9, *)
    var safeAreaLayoutGuide: UILayoutGuide {
        // Early exit if we're on iOS 11.x
        if #available(iOS 11, *) {
            return view.safeAreaLayoutGuide
        }
        // Early exit if we already have custom layoutGuide with given identifier
        if let layoutGuide = view.layoutGuides.first(where: { $0.identifier == type(of: self).identifier }) {
            return layoutGuide
        }
        // Create new layoutGuide
        let layoutGuide = UILayoutGuide()
        layoutGuide.identifier = type(of: self).identifier
        view.addLayoutGuide(layoutGuide)
        NSLayoutConstraint.activate([layoutGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     layoutGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     layoutGuide.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
                                     layoutGuide.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor)])
        return layoutGuide
    }
}
