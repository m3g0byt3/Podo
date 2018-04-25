//
//  SettingsViewController.swift
//  Podo
//
//  Created by m3g0byt3 on 18/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit

final class SettingsViewController: UIViewController, SettingsView, TrainIconTitleView {

    // MARK: - SettingsView protocol conformance

    var onClose: Completion?

    // MARK: - InteractiveTransitioningCapable protocol conformance

    var isTransitionInteractive = false
    var onInteractiveTransition: ((UIPanGestureRecognizer) -> Void)?

    // MARK: - SideMenuPresenting protocol conformance

    var onSideMenuSelection: Completion?

    // MARK: - Lifecycle

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        onClose?()
    }
}
