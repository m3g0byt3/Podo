//
//  CardViewTransitioningDelegate.swift
//  Podo
//
//  Created by m3g0byt3 on 23/08/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit

final class CardViewTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {

    func presentationController(
        forPresented presented: UIViewController,
        presenting: UIViewController?,
        source: UIViewController
    ) -> UIPresentationController? {
        return CardViewPresentationController(presentedViewController: presented,
                                              presenting: presenting)
    }

    deinit {
        print("🔴 deinit \(self) 🔴")
    }
}
