//
//  PaymentCardCell.swift
//  Podo
//
//  Created by m3g0byt3 on 21/06/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit

class PaymentCardCell: UITableViewCell {

    // MARK: - IBOutlets

    @IBOutlet private weak var cardNumberTextField: PaymentCardTextFieldView! {
        didSet {
            cardNumberTextField.buttonHandler = { print("pressed button at view: \($0)") }
        }
    }
}
