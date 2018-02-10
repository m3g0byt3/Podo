//
//  UIViewController+UINavigationController.swift
//  Podo
//
//  Created by m3g0byt3 on 28/11/2017.
//  Copyright © 2017 m3g0byt3. All rights reserved.
//

import UIKit

extension UIViewController {

    class func navigationControllerInstance() -> UINavigationController {
        let rootViewController = self.init()
        return UINavigationController(rootViewController: rootViewController)
    }
}
