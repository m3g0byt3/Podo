//
//  PaymentCompositionViewController.swift
//  Podo
//
//  Created by m3g0byt3 on 27/04/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit
import BSK
import Result
import RxSwift
import RxCocoa
import RxDataSources

class PaymentCompositionViewController: UIViewController,
                                        PaymentCompositionView,
                                        TrainIconTitleView,
                                        KeyboardHandling {

    // MARK: IBOutlets

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var paymentButton: UIBarButtonItem!

    // MARK: - Properties

    // swiftlint:disable:next implicitly_unwrapped_optional
    var viewModel: PaymentCompositionViewModelProtocol!
    private let disposeBag = DisposeBag()

    // MARK: - KeyboardHandling protocol conformance

    var manageableViews: [UIView] { return [tableView] }

    // MARK: - PaymentCompositionView protocol conformance

    var onPaymentConfirmation: ((Result<URLRequest, BSKError>) -> Void)?
    var onPaymentCancel: Completion?
    var onScanButtonTap: Completion?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupBindings()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        beginKeyboardHandling()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        endKeyboardHandling()
    }

    // MARK: - Private API

    private func setupTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = Constant.CardPaymentMenu.estimatedRowHeight
        tableView.register(R.nib.paymentCardCell)
        tableView.register(R.nib.transportCardCell)
        tableView.register(PaymentAmountCell.self)
    }

    private func setupBindings() {
        let dataSource = PaymentCompositionViewController.dataSource()

        paymentButton.rx.tap
            .throttle(Constant.ThrottleDuration.button, scheduler: MainScheduler.instance)
            .bind(to: viewModel.input.startPayment)
            .disposed(by: disposeBag)

        viewModel.output.sections
            .asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        viewModel.output.isPaymentValid
            .asDriver(onErrorJustReturn: false)
            .drive(paymentButton.rx.isEnabled)
            .disposed(by: disposeBag)

        tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)

        viewModel.output.confirmationRequest
            .subscribe(onNext: { [weak self] result in
                self?.onPaymentConfirmation?(result)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - RxTableViewSectionedReloadDataSource factory

private extension PaymentCompositionViewController {

    static func dataSource() -> RxTableViewSectionedReloadDataSource<PaymentCompositionSectionViewModelWrapper> {
        return RxTableViewSectionedReloadDataSource<PaymentCompositionSectionViewModelWrapper>(
            configureCell: { _, tableView, indexPath, viewModel in
                switch viewModel {

                case .paymentCardSectionItem(let viewModel):
                    let cell: PaymentCardCell = tableView.dequeueReusableCell(for: indexPath)
                    return cell.configure(with: viewModel)

                case .transportCardSectionItem(let viewModel):
                    let cell: TransportCardCell = tableView.dequeueReusableCell(for: indexPath)
                    return cell.configure(with: viewModel)

                case .amountFieldSectionItem(let viewModel):
                    let cell: PaymentAmountCell = tableView.dequeueReusableCell(for: indexPath)
                    return cell.configure(with: viewModel)
                }
            },
            titleForHeaderInSection: { dataSource, index in
                let section = dataSource[index]
                return section.headerTitle
            }
        )
    }
}

// MARK: - UITableViewDelegate protocol conformance

extension PaymentCompositionViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constant.CardPaymentMenu.headerHeight
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return Constant.CardPaymentMenu.footerHeight
    }
}
