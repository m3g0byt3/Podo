//
//  AmountFieldCell.swift
//  Podo
//
//  Created by m3g0byt3 on 21/06/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit
import SnapKit

final class AmountFieldCell: UITableViewCell {

    // MARK: - Constants

    private static let buttonHeightToCornerRadiusRatio: CGFloat = 0.5
    private static let defaultButtonText = "%unassigned_label%"

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

    // MARK: - Private properties

    private let containerView = UIView()
    private let sumTextField = UITextField()
    private let firstSumButton = RoundShadowButton(type: .system)
    private let secondSumButton = RoundShadowButton(type: .system)
    private let thirdSumButton = RoundShadowButton(type: .system)
    private let buttonStackView = UIStackView()

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
        sumTextField.font = AmountFieldCell.textFieldFont

        // Buttons setup
        let buttonTextAttributes: [NSAttributedString.Key: Any] = [
            .font: AmountFieldCell.buttonFont,
            .foregroundColor: R.clr.podoColors.empty()
        ]
        let emptyButtonLabel = NSAttributedString(string: AmountFieldCell.defaultButtonText,
                                                  attributes: buttonTextAttributes)
        [firstSumButton, secondSumButton, thirdSumButton].forEach { button in
            button.layer.borderWidth = AmountFieldCell.buttonBorderWidth
            button.layer.borderColor = R.clr.podoColors.empty().cgColor
            button.heightToCornerRadiusRatio = AmountFieldCell.buttonHeightToCornerRadiusRatio
            button.shadowColor = .clear
            button.setAttributedTitle(emptyButtonLabel, for: .normal)
            buttonStackView.addArrangedSubview(button)
        }

        // StackView setup
        buttonStackView.spacing = Constant.CardPaymentMenu.cellMarginValue
        buttonStackView.alignment = .center
        buttonStackView.distribution = .fillEqually

        // Adding subviews
        [sumTextField, buttonStackView].forEach(containerView.addSubview(_:))
        contentView.addSubview(containerView)
    }

    private func drawSeparator(in rect: CGRect) {
        let startPorint = CGPoint(x: rect.minX + Constant.CardPaymentMenu.cellMarginValue, y: rect.midY)
        let endPoint = CGPoint(x: rect.maxX - Constant.CardPaymentMenu.cellMarginValue, y: rect.midY)

        if let context = UIGraphicsGetCurrentContext() {
            context.setLineWidth(AmountFieldCell.separatorWidth)
            context.setStrokeColor(R.clr.podoColors.empty().cgColor)
            context.move(to: startPorint)
            context.addLine(to: endPoint)
            context.strokePath()
        }
    }
}

// MARK: - Configurable protocol conformance

extension AmountFieldCell: Configurable {

    typealias ViewModel = Any

    @discardableResult
    func configure(with viewModel: Any) -> Self {
        // TODO: Add actual implementation
        sumTextField.placeholder = "0₽"
        [firstSumButton, secondSumButton, thirdSumButton]
            .enumerated()
            .forEach { $1?.setTitle("+\($0 + 1)00₽", for: .normal, preserveAttributes: true) }
        return self
    }
}
