//
//  PaymentCardCell.swift
//  Podo
//
//  Created by m3g0byt3 on 21/06/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

final class PaymentCardCell: UITableViewCell {

    // MARK: - IBOutlets

    @IBOutlet private weak var cardNumberTextField: LabeledTextField!
    @IBOutlet private weak var expirationTextField: LabeledTextField!
    @IBOutlet private weak var cvcTextField: LabeledTextField!
    @IBOutlet private weak var cellTitle: UILabel!

    // MARK: - Properties

    private var disposeBag = DisposeBag()

    // MARK: - Public API

    override func prepareForReuse() {
        super.prepareForReuse()
        // Create new dispose bag on every re-use of the cell
        disposeBag = DisposeBag()
    }
}

// MARK: - Configurable protocol conformance

extension PaymentCardCell: Configurable {

    typealias ViewModel = PaymentCardCellViewModelProtocol

    @discardableResult
    func configure(with viewModel: ViewModel) -> Self {
        // swiftlint:disable:previous function_body_length
        cardNumberTextField.rx.textFieldText
            .orEmpty
            .distinctUntilChanged()
            .throttle(Constant.ThrottleDuration.textField, scheduler: MainScheduler.instance)
            .bind(to: viewModel.input.cardNumberInput)
            .disposed(by: disposeBag)

        expirationTextField.rx.textFieldText
            .orEmpty
            .distinctUntilChanged()
            .throttle(Constant.ThrottleDuration.textField, scheduler: MainScheduler.instance)
            .bind(to: viewModel.input.expiryDateInput)
            .disposed(by: disposeBag)

        cvcTextField.rx.textFieldText
            .orEmpty
            .distinctUntilChanged()
            .throttle(Constant.ThrottleDuration.textField, scheduler: MainScheduler.instance)
            .bind(to: viewModel.input.cvcNumberInput)
            .disposed(by: disposeBag)

        viewModel.output.cardTitle
            .asDriver(onErrorJustReturn: Constant.Placeholder.empty)
            .drive(cellTitle.rx.text)
            .disposed(by: disposeBag)

        viewModel.output.cardNumberLabel
            .asDriver(onErrorJustReturn: Constant.Placeholder.empty)
            .drive(cardNumberTextField.rx.labelText)
            .disposed(by: disposeBag)

        viewModel.output.expiryDateLabel
            .asDriver(onErrorJustReturn: Constant.Placeholder.empty)
            .drive(expirationTextField.rx.labelText)
            .disposed(by: disposeBag)

        viewModel.output.cvcNumberLabel
            .asDriver(onErrorJustReturn: Constant.Placeholder.empty)
            .drive(cvcTextField.rx.labelText)
            .disposed(by: disposeBag)

        viewModel.output.cardNumberPlaceholder
            .asDriver(onErrorJustReturn: Constant.Placeholder.empty)
            .drive(cardNumberTextField.rx.placeholder)
            .disposed(by: disposeBag)

        viewModel.output.expiryDatePlaceholder
            .asDriver(onErrorJustReturn: Constant.Placeholder.empty)
            .drive(expirationTextField.rx.placeholder)
            .disposed(by: disposeBag)

        viewModel.output.cvcNumberPlaceholder
            .asDriver(onErrorJustReturn: Constant.Placeholder.empty)
            .drive(cvcTextField.rx.placeholder)
            .disposed(by: disposeBag)

        viewModel.output.cardNumberOutput
            .asDriver(onErrorJustReturn: Constant.Placeholder.empty)
            .drive(cardNumberTextField.rx.textFieldText)
            .disposed(by: disposeBag)

        viewModel.output.expiryDateOutput
            .asDriver(onErrorJustReturn: Constant.Placeholder.empty)
            .drive(expirationTextField.rx.textFieldText)
            .disposed(by: disposeBag)

        viewModel.output.cvcNumberOutput
            .asDriver(onErrorJustReturn: Constant.Placeholder.empty)
            .drive(cvcTextField.rx.textFieldText)
            .disposed(by: disposeBag)

        return self
    }
}
