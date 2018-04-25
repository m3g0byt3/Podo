//
//  InteractiveTransitioningDelegate.swift
//  Podo
//
//  Created by m3g0byt3 on 14/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit

protocol InteractiveTransitioningDelegate: class {

    var isTransitionInteractive: Bool { get set }

    var delegate: UIViewControllerTransitioningDelegate { get }

    func updateTransition(using gestureRecognizer: UIPanGestureRecognizer)
}

extension InteractiveTransitioningDelegate where Self: UIViewControllerTransitioningDelegate {

    var delegate: UIViewControllerTransitioningDelegate { return self }
}
