//
//  AddNewCardViewController.swift
//  Podo
//
//  Created by m3g0byt3 on 26/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit

final class AddNewCardViewController: UIViewController, AddNewCardView {

    // MARK: - IBOutlets

    @IBOutlet private weak var cardNumberTextField: UITextField!

    // MARK: - Lifecycle

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        cardNumberTextField.becomeFirstResponder()
    }
}
