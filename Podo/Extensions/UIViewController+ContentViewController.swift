//
//  UIViewController+ContentViewController.swift
//  Podo
//
//  Created by m3g0byt3 on 26/11/2017.
//  Copyright © 2017 m3g0byt3. All rights reserved.
//

import UIKit

extension UIViewController {
    
    open var contentViewController: UIViewController? {
        switch self {
        case let navigationController as UINavigationController:
            return navigationController.viewControllers.first?.contentViewController
        case let tabBarController as UITabBarController:
            return tabBarController.viewControllers?.first?.contentViewController
        default:
            return self
        }
    }
}
