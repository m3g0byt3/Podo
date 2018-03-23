//
//  SettingsViewController.swift
//  Podo
//
//  Created by m3g0byt3 on 18/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, SettingsView {

    // MARK: - SettingsView protocol conformance

    var onClose: Completion?

    // MARK: - Lifecycle

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        onClose?()
    }
}
