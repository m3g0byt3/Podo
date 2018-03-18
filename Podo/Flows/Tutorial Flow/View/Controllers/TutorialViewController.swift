//
//  TutorialViewController.swift
//  Podo
//
//  Created by m3g0byt3 on 09/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit

final class TutorialViewController: UIViewController, TutorialView {

    // MARK: - Properties

    var onNext: Completion?
    var onSkip: Completion?

    // MARK: - IBActions

    @IBAction private func nextButtonHandler(_ sender: UIButton) {
        onNext?()
    }

    @IBAction private func skipButtonHandler(_ sender: UIButton) {
        onSkip?()
    }
}
