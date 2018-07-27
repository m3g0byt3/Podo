//
//  PaymentAmountCell.swift
//  Podo
//
//  Created by m3g0byt3 on 21/06/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class PaymentAmountCell: UITableViewCell {

    // MARK: - Constants

    private static let buttonHeightToCornerRadiusRatio: CGFloat = 0.5
    private static let defaultButtonText = "%unassigned_label%"
    private static let onErrorPlaceholder = ""

    private static var textFieldFont: UIFont {
        return UIFont.monospacedDigitSystemFont(ofSize: 44.0, weight: .thin)
    }

    private static var buttonFont: UIFont {
        return UIFont.monospacedDigitSystemFont(ofSize: 24.0, weight: .thin)
    }

    private static var separatorWidth: CGFloat {
        return 1 / UIScreen.main.scale
    }

    private static var buttonBorderWidth: CGFloat {
        return 1 / UIScreen.main.scale
    }

    private static var buttonContentInset: UIEdgeInsets {
        return UIEdgeInsets(top: Constant.CardPaymentMenu.sumButtonVerticalInset,
                            left: Constant.CardPaymentMenu.sumButtonHorizontalInset,
                            bottom: Constant.CardPaymentMenu.sumButtonVerticalInset,
                            right: Constant.CardPaymentMenu.sumButtonHorizontalInset)
    }

    private enum PositionParameters {
        static let direction = UITextLayoutDirection.left
        static let offset = 1
    }

    // MARK: - Private properties

    private let containerView = UIView()
    private let sumTextField = UITextField()
    private let sumButtons = (0..<3).map { _ in RoundShadowButton(type: .system) }
    private let buttonStackView = UIStackView()
    private let disposeBag = DisposeBag()

    // MARK: - Public properties

    override class var requiresConstraintBasedLayout: Bool {
        return true
    }

    // MARK: - Initialization

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    @available(*, unavailable, message: "This class cannot be instantiated from StoryBoard/XIB")
    required init?(coder aDecoder: NSCoder) {
        notImplemented()
    }

    // MARK: - Public API

    // Fix for buggy AL in self-sizing cells on iOS 10 and below
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard #available(iOS 11, *) else {
            layoutIfNeeded()
            return
        }
    }

    override func updateConstraints() {
        containerView.snp.updateConstraints { maker in
            maker.edges.equalToSuperview()
        }
        sumTextField.snp.updateConstraints { maker in
            maker.trailingMargin.leadingMargin.topMargin.equalToSuperview()
        }
        buttonStackView.snp.updateConstraints { maker in
            maker.trailingMargin.leadingMargin.bottomMargin.equalToSuperview()
            maker.top.equalTo(sumTextField.snp.bottom).offset(Constant.CardPaymentMenu.cellMarginValue)
        }
        super.updateConstraints()
    }

    override func draw(_ rect: CGRect) {
        drawSeparator(in: rect)
    }

    // MARK: - Private API

    private func setupUI() {
        // ContainerView setup
        containerView.layoutMargins = UIEdgeInsets(top: Constant.CardPaymentMenu.cellMarginValue,
                                                   left: Constant.CardPaymentMenu.cellMarginValue,
                                                   bottom: Constant.CardPaymentMenu.cellMarginValue,
                                                   right: Constant.CardPaymentMenu.cellMarginValue)
        // TextField Setup
        sumTextField.textAlignment = .center
        sumTextField.autocorrectionType = .no
        sumTextField.autocapitalizationType = .none
        sumTextField.spellCheckingType = .no
        sumTextField.keyboardType = .numberPad
        sumTextField.clearButtonMode = .never
        sumTextField.textColor = R.clr.podoColors.empty()
        sumTextField.font = PaymentAmountCell.textFieldFont

        // Buttons setup
        let buttonTextAttributes: [NSAttributedString.Key: Any] = [
            .font: PaymentAmountCell.buttonFont,
            .foregroundColor: R.clr.podoColors.empty()
        ]
        let emptyButtonLabel = NSAttributedString(string: PaymentAmountCell.defaultButtonText,
                                                  attributes: buttonTextAttributes)
        sumButtons.forEach { button in
            button.contentEdgeInsets = PaymentAmountCell.buttonContentInset
            button.layer.borderWidth = PaymentAmountCell.buttonBorderWidth
            button.heightToCornerRadiusRatio = PaymentAmountCell.buttonHeightToCornerRadiusRatio
            button.layer.borderColor = R.clr.podoColors.empty().cgColor
            button.shadowColor = .clear
            button.setAttributedTitle(emptyButtonLabel, for: .normal)
            buttonStackView.addArrangedSubview(button)
        }

        // StackView setup
        buttonStackView.alignment = .center
        buttonStackView.distribution = .equalCentering

        // Adding subviews
        [sumTextField, buttonStackView].forEach(containerView.addSubview(_:))
        contentView.addSubview(containerView)
    }

    private func drawSeparator(in rect: CGRect) {
        let startPorint = CGPoint(x: rect.minX + Constant.CardPaymentMenu.cellMarginValue, y: rect.midY)
        let endPoint = CGPoint(x: rect.maxX - Constant.CardPaymentMenu.cellMarginValue, y: rect.midY)

        if let context = UIGraphicsGetCurrentContext() {
            context.setLineWidth(PaymentAmountCell.separatorWidth)
            context.setStrokeColor(R.clr.podoColors.empty().cgColor)
            context.move(to: startPorint)
            context.addLine(to: endPoint)
            context.strokePath()
        }
    }

    private func setPositionForTextField(_ sender: UITextField?) {
        guard
            let textField = sender,
            let newPosition = textField.position(from: textField.endOfDocument,
                                                 in: PositionParameters.direction,
                                                 offset: PositionParameters.offset)
        else { return }
        textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
    }
}

// MARK: - Configurable protocol conformance

extension PaymentAmountCell: Configurable {

    typealias ViewModel = PaymentAmountCellViewModelProtocol

    @discardableResult
    func configure(with viewModel: ViewModel) -> Self {

        sumTextField.rx.text
            .orEmpty
            .distinctUntilChanged()
            .bind(to: viewModel.input.amountInput)
            .disposed(by: disposeBag)

        sumTextField.rx.text
            .orEmpty
            .subscribe(onNext: { [weak self] _ in
                self?.setPositionForTextField(self?.sumTextField)
            })
            .disposed(by: disposeBag)

        viewModel.output.amountOutput
            .asDriver(onErrorJustReturn: PaymentAmountCell.onErrorPlaceholder)
            .drive(sumTextField.rx.text)
            .disposed(by: disposeBag)

        viewModel.output.placeholder
            .asDriver(onErrorJustReturn: PaymentAmountCell.onErrorPlaceholder)
            .drive(sumTextField.rx.placeholder)
            .disposed(by: disposeBag)

        viewModel.output.isAmountValid
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: { [weak self] isValid in
                self?.sumTextField.textColor = isValid ? R.clr.podoColors.empty() : R.clr.appleHIG.red()
            })
            .disposed(by: disposeBag)

        viewModel.output.buttonViewModels
            .toArray()
            .asDriver(onErrorJustReturn: [])
            .drive(onNext: { [weak self] viewModels in
                guard
                    let buttons = self?.sumButtons,
                    let bag = self?.disposeBag
                else { return }

                for (viewModel, button) in zip(viewModels, buttons) {
                    button.setTitle(viewModel.output.title, for: .normal, preserveAttributes: true)
                    button.rx.tap
                        .bind(to: viewModel.input.selected)
                        .disposed(by: bag)
                }
            })
            .disposed(by: disposeBag)

        return self
    }
}
