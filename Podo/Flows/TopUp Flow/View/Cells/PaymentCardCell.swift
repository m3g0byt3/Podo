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

    // MARK: - Constants

    private static let onErrorPlaceholder = ""

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
            .bind(to: viewModel.input.cardNumber)
            .disposed(by: disposeBag)

        expirationTextField.rx.textFieldText
            .orEmpty
            .distinctUntilChanged()
            .throttle(Constant.ThrottleDuration.textField, scheduler: MainScheduler.instance)
            .bind(to: viewModel.input.expiryDate)
            .disposed(by: disposeBag)

        cvcTextField.rx.textFieldText
            .orEmpty
            .distinctUntilChanged()
            .throttle(Constant.ThrottleDuration.textField, scheduler: MainScheduler.instance)
            .bind(to: viewModel.input.cvcNumber)
            .disposed(by: disposeBag)

        viewModel.output.cardTitle
            .asDriver(onErrorJustReturn: PaymentCardCell.onErrorPlaceholder)
            .drive(cellTitle.rx.text)
            .disposed(by: disposeBag)

        viewModel.output.cardNumberLabel
            .asDriver(onErrorJustReturn: PaymentCardCell.onErrorPlaceholder)
            .drive(cardNumberTextField.rx.labelText)
            .disposed(by: disposeBag)

        viewModel.output.expiryDateLabel
            .asDriver(onErrorJustReturn: PaymentCardCell.onErrorPlaceholder)
            .drive(expirationTextField.rx.labelText)
            .disposed(by: disposeBag)

        viewModel.output.cvcNumberLabel
            .asDriver(onErrorJustReturn: PaymentCardCell.onErrorPlaceholder)
            .drive(cvcTextField.rx.labelText)
            .disposed(by: disposeBag)

        viewModel.output.cardNumberPlaceholder
            .asDriver(onErrorJustReturn: PaymentCardCell.onErrorPlaceholder)
            .drive(cardNumberTextField.rx.placeholder)
            .disposed(by: disposeBag)

        viewModel.output.expiryDatePlaceholder
            .asDriver(onErrorJustReturn: PaymentCardCell.onErrorPlaceholder)
            .drive(expirationTextField.rx.placeholder)
            .disposed(by: disposeBag)

        viewModel.output.cvcNumberPlaceholder
            .asDriver(onErrorJustReturn: PaymentCardCell.onErrorPlaceholder)
            .drive(cvcTextField.rx.placeholder)
            .disposed(by: disposeBag)

        viewModel.output.cardNumberText
            .asDriver(onErrorJustReturn: PaymentCardCell.onErrorPlaceholder)
            .drive(cardNumberTextField.rx.textFieldText)
            .disposed(by: disposeBag)

        viewModel.output.expiryDateText
            .asDriver(onErrorJustReturn: PaymentCardCell.onErrorPlaceholder)
            .drive(expirationTextField.rx.textFieldText)
            .disposed(by: disposeBag)

        viewModel.output.cvcNumberText
            .asDriver(onErrorJustReturn: PaymentCardCell.onErrorPlaceholder)
            .drive(cvcTextField.rx.textFieldText)
            .disposed(by: disposeBag)

        return self
    }
}
