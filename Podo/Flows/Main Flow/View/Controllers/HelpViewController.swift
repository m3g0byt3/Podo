//
//  HelpViewController.swift
//  Podo
//
//  Created by m3g0byt3 on 24/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit

final class HelpViewController: UIViewController, HelpView, TrainIconTitleView {

    // MARK: - InteractiveTransitioningCapable protocol conformance

    var isTransitionInteractive = false
    var onInteractiveTransition: ((UIPanGestureRecognizer) -> Void)?

    // MARK: - SideMenuPresenting protocol conformance

    var onSideMenuSelection: Completion?
}
