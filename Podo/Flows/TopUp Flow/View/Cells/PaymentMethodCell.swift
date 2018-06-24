//
//  PaymentMethodCell.swift
//  Podo
//
//  Created by m3g0byt3 on 17/04/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class PaymentMethodCell: UITableViewCell {

    // MARK: - IBOutlets

    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var icon: UIImageView!

    // MARK: - Properties

    private var disposeBag = DisposeBag()

    // MARK: - Public API

    override func prepareForReuse() {
        super.prepareForReuse()
        // Create new dispose bag on every re-use of the cell
        disposeBag = DisposeBag()
    }
}

extension PaymentMethodCell: Configurable {

    typealias ViewModel = PaymentMethodCellViewModel

    @discardableResult
    func configure(with viewModel: PaymentMethodCellViewModel) -> Self {

        viewModel.title
            .drive(title.rx.text)
            .disposed(by: disposeBag)

        viewModel.icon
            .drive(icon.rx.image)
            .disposed(by: disposeBag)

        return self
    }
}
