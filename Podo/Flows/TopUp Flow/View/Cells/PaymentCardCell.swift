//
//  PaymentCardCell.swift
//  Podo
//
//  Created by m3g0byt3 on 21/06/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class PaymentCardCell: UITableViewCell {

    // MARK: - IBOutlets

    @IBOutlet private weak var cardNumberTextField: PaymentCardTextFieldView! {
        // FIXME: test only logging
        didSet {
            cardNumberTextField.buttonHandler = { print("pressed button at view: \($0)") }
        }
    }
    @IBOutlet private weak var expirationTextField: PaymentCardTextFieldView!
    @IBOutlet private weak var cvcTextField: PaymentCardTextFieldView!

    // MARK: - Properties

    private var disposeBag = DisposeBag()

    // MARK: - Public API

    override func prepareForReuse() {
        super.prepareForReuse()
        // Create new dispose bag on every re-use of the cell
        disposeBag = DisposeBag()
    }
}
