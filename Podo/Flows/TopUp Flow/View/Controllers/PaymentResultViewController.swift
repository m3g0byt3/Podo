//
//  SuccessViewController.swift
//  Podo
//
//  Created by m3g0byt3 on 23/08/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

final class PaymentResultViewController: UIViewController,
                                         PaymentResultView,
                                         CardViewPresentable {

    // MARK: - Constants

    private static let alphaValue: CGFloat = 0.25
    private static let cornerRadiusRatio: CGFloat = 0.5
    private static let smallMargin: CGFloat = 8.0
    private static let normalMargin: CGFloat = 16.0
    private static let dragViewWidthRatio: CGFloat = 1.0 / 8.0
    private static let dragViewAspectRatio: CGFloat = 1.0 / 6.0
    private static let markViewWidthRatio: CGFloat = 1.0 / 6.0
    private static let markViewDuration: TimeInterval = 0.5

    // MARK: - Private properties

    private var allowAutoDismissal = true

    private var deadline: DispatchTime {
        return DispatchTime.now() + Constant.CardView.displayDuration
    }

    private var image: UIImage? {
        return viewModel.output.imageBlob.flatMap(UIImage.init)
    }

    private lazy var dragView: RoundShadowView = { this in
        let alphaValue = type(of: self).alphaValue
        this.backgroundColor = R.clr.podoColors.grayText().withAlphaComponent(alphaValue)
        this.heightToCornerRadiusRatio = type(of: self).cornerRadiusRatio
        this.shadowOffset = .zero
        return this
    }(RoundShadowView())

    private lazy var markView: MarkView = { this in
        this.isFailed = viewModel.output.isError
        this.color = viewModel.output.isError ? R.clr.podoColors.red() : R.clr.podoColors.green()
        this.duration = type(of: self).markViewDuration
        return this
    }(MarkView())

    private lazy var titleLabel: UILabel = { this in
        this.textColor = R.clr.podoColors.grayText()
        this.lineBreakMode = .byClipping
        this.font = UIFont.preferredFont(forTextStyle: .title2, withSymbolicTraits: .traitBold)
        return this
    }(UILabel())

    private lazy var messageLabel: UILabel = { this in
        this.textColor = R.clr.podoColors.grayText()
        this.numberOfLines = 0
        this.textAlignment = .center
        this.lineBreakMode = .byClipping
        this.font = UIFont.preferredFont(forTextStyle: .title3)
        return this
    }(UILabel())

    private lazy var stackView: UIStackView = { this in
        this.axis = .horizontal
        this.distribution = .fillProportionally
        this.spacing = type(of: self).normalMargin
        view.addSubview(this)
        return this
    }(UIStackView(arrangedSubviews: [markView, titleLabel]))

    private lazy var imageView: UIImageView = { this in
        this.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        this.contentMode = .scaleAspectFit
        return this
    }(UIImageView(image: image))

    // MARK: - Public properties

    // swiftlint:disable:next implicitly_unwrapped_optional
    var viewModel: PaymentResultViewModelProtocol!

    // MARK: - PaymentResultView protocol conformance

    var onPaymentResultClose: Completion?

    // MARK: - CardViewPresentable protocol conformance

    var screenHeightRatio: CGFloat {
        let isError = viewModel.output.isError
        return isError ? Constant.CardView.errorHeightRatio : Constant.CardView.successHeightRatio
    }

    lazy var panGesture: UIPanGestureRecognizer = {
        let panSelector = #selector(panGestureHandler(_:))
        let panGesture = UIPanGestureRecognizer(target: self, action: panSelector)
        return panGesture
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        setupAutoDismissal()
    }

    // MARK: - Public API

    override func updateViewConstraints() {
        dragView.snp.updateConstraints { maker in
            maker.top.equalToSuperview().inset(type(of: self).smallMargin)
            maker.width.equalToSuperview().multipliedBy(type(of: self).dragViewWidthRatio)
            maker.height.equalTo(dragView.snp.width).multipliedBy(type(of: self).dragViewAspectRatio)
            maker.centerX.equalToSuperview()
        }

        stackView.snp.updateConstraints { maker in
            maker.top.equalTo(dragView.snp.bottom).offset(type(of: self).normalMargin)
            maker.width.lessThanOrEqualToSuperview()
            maker.centerX.equalToSuperview()
        }

        markView.snp.updateConstraints { maker in
            let markSize = view.frame.width * type(of: self).markViewWidthRatio
            maker.height.width.equalTo(markSize)
        }

        messageLabel.snp.updateConstraints { maker in
            maker.top.equalTo(stackView.snp.bottom).offset(type(of: self).smallMargin)
            maker.leadingMargin.trailingMargin.equalToSuperview()
        }

        imageView.snp.updateConstraints { maker in
            let priority: ConstraintPriority = viewModel.output.isError ? .medium : .required
            maker.top.equalTo(messageLabel.snp.bottom).offset(type(of: self).normalMargin)
            maker.bottom.equalToSuperview().inset(type(of: self).smallMargin).priority(priority)
            maker.leading.trailing.equalTo(stackView)
        }

        super.updateViewConstraints()
    }

    // MARK: - Private API

    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(dragView)
        view.addSubview(messageLabel)
        view.addSubview(imageView)
        view.addGestureRecognizer(panGesture)
        view.setNeedsUpdateConstraints()
    }

    private func setupBindings() {
        titleLabel.text = viewModel.output.title
        messageLabel.text = viewModel.output.message
        imageView.image = viewModel.output.imageBlob.flatMap(UIImage.init)
    }

    private func setupAutoDismissal() {
        DispatchQueue.main.asyncAfter(deadline: deadline) { [weak self] in
            guard let allow = self?.allowAutoDismissal, allow else { return }
            self?.onPaymentResultClose?()
        }
    }

    // MARK: - Control handlers

    @objc private func panGestureHandler(_ sender: UIPanGestureRecognizer) {
        if sender.state == .began {
            allowAutoDismissal = false
            self.onPaymentResultClose?()
        }
    }
}
