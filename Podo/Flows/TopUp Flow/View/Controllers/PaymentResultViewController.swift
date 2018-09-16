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
import RxSwift
import RxCocoa

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

    private let disposeBag = DisposeBag()

    private var allowAutoDismissal = true

    private var deadline: DispatchTime {
        return DispatchTime.now() + Constant.CardView.displayDuration
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

    private lazy var errorLabel: UILabel = { this in
        this.numberOfLines = 0
        this.textAlignment = .center
        this.textColor = R.clr.podoColors.grayText()
        this.font = UIFont.preferredFont(forTextStyle: .footnote)
        return this
    }(UILabel())

    private lazy var stackView: UIStackView = { this in
        this.axis = .horizontal
        this.distribution = .fillProportionally
        this.spacing = type(of: self).normalMargin
        view.addSubview(this)
        return this
    }(UIStackView(arrangedSubviews: [markView, titleLabel]))

    private lazy var tableView: UITableView = { this in
        this.isScrollEnabled = false
        this.separatorColor = .clear
        this.register(PaymentResultCell.self)
        return this
    }(UITableView())

    private lazy var indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)

    // MARK: - Public properties

    // swiftlint:disable:next implicitly_unwrapped_optional
    var viewModel: PaymentResultViewModelProtocol!

    // MARK: - PaymentResultView protocol conformance

    var onStationSelection: ((PaymentResultCellViewModelProtocol) -> Void)?
    var onPaymentResultClose: Completion?

    // MARK: - CardViewPresentable protocol conformance

    var screenHeightRatio: CGFloat {
        let isError = viewModel.output.isError
        return isError ? Constant.CardView.errorHeightRatio : Constant.CardView.successHeightRatio
    }

    lazy var panGesture = UIPanGestureRecognizer()

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

        tableView.snp.updateConstraints { maker in
            maker.top.equalTo(messageLabel.snp.bottom)
            maker.leading.trailing.bottom.equalToSuperview()
        }

        indicator.snp.updateConstraints { maker in
            maker.center.equalToSuperview()
        }

        errorLabel.snp.updateConstraints { maker in
            maker.center.leadingMargin.trailingMargin.equalToSuperview()
        }

        super.updateViewConstraints()
    }

    // MARK: - Private API

    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(dragView)
        view.addSubview(messageLabel)
        view.addGestureRecognizer(panGesture)
        view.setNeedsUpdateConstraints()
        view.addSubview(tableView)
        tableView.addSubview(indicator)
        tableView.addSubview(errorLabel)
    }

    private func setupBindings() {
        let identifier = PaymentResultCell.reuseIdentifier
        let type = PaymentResultCell.self

        viewModel.output.stations
            .asDriver(onErrorJustReturn: [])
            .do(onNext: { [unowned tableView = self.tableView] viewModels in
                let divider = max(CGFloat(viewModels.count), CGFloat.leastNonzeroMagnitude)
                tableView.rowHeight = tableView.frame.height / divider
            })
            .drive(tableView.rx.items(cellIdentifier: identifier, cellType: type)) { _, viewModel, cell in
                cell.configure(with: viewModel)
            }
            .disposed(by: disposeBag)

        tableView.rx.modelSelected(PaymentResultCellViewModelProtocol.self)
            .subscribe(onNext: { [weak self] viewModel in
                self?.onStationSelection?(viewModel)
            })
            .disposed(by: disposeBag)

        viewModel.output.title
            .asDriver(onErrorJustReturn: Constant.Placeholder.empty)
            .drive(titleLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.output.message
            .asDriver(onErrorJustReturn: Constant.Placeholder.empty)
            .drive(messageLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.output.errorMessage
            .asDriver(onErrorJustReturn: Constant.Placeholder.empty)
            .drive(errorLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.output.isLoading
            .asDriver(onErrorJustReturn: false)
            .drive(indicator.rx.isAnimating)
            .disposed(by: disposeBag)

        panGesture.rx.state
            .distinctUntilChanged()
            .filter { $0 == .began }
            .subscribe(onNext: { [unowned self] _ in
                self.allowAutoDismissal = false
                self.onPaymentResultClose?()
            })
            .disposed(by: disposeBag)
    }

    private func setupAutoDismissal() {
        DispatchQueue.main.asyncAfter(deadline: deadline) { [weak self] in
            guard let allow = self?.allowAutoDismissal, allow else { return }
            self?.onPaymentResultClose?()
        }
    }
}
