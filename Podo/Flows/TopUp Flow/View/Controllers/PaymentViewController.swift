//
//  PaymentViewController.swift
//  Podo
//
//  Created by m3g0byt3 on 27/04/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class PaymentViewController: UIViewController, PaymentView, TrainIconTitleView, KeyboardHandling {

    // MARK: IBOutlets

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var paymentButton: UIBarButtonItem!

    // MARK: - Properties

    // swiftlint:disable:next implicitly_unwrapped_optional
    var viewModel: PaymentConfirmationViewModel!
    private let disposeBag = DisposeBag()

    // MARK: - KeyboardHandling protocol conformance

    var manageableViews: [UIView] {
        return [tableView]
    }

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
        tableView.register(AmountFieldCell.self)
    }

    private func setupBindings() {
        let dataSource = PaymentViewController.dataSource()

        viewModel.sections
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }
}

// MARK: - RxTableViewSectionedReloadDataSource factory

private extension PaymentViewController {

    static func dataSource() -> RxTableViewSectionedReloadDataSource<PaymentConfirmationSectionViewModelImpl> {
        return RxTableViewSectionedReloadDataSource<PaymentConfirmationSectionViewModelImpl>(
            configureCell: { (_, tableView, indexPath, viewModel) in
                switch viewModel {
                case .paymentCardSectionItem:
                    let cell: PaymentCardCell = tableView.dequeueReusableCell(for: indexPath)
                    // FIXME: Configure with real VM
                    return cell.configure(with: NSObject())
                case .transportCardSectionItem(let innerViewModel):
                    let cell: TransportCardCell = tableView.dequeueReusableCell(for: indexPath)
                    return cell.configure(with: innerViewModel)
                case .amountFieldSectionItem:
                    let cell: AmountFieldCell = tableView.dequeueReusableCell(for: indexPath)
                    // FIXME: Configure with real VM
                    return cell.configure(with: NSObject())
                }
            },
            titleForHeaderInSection: { (dataSource, index) in
                let section = dataSource[index]
                return section.headerTitle
            }
        )
    }
}

// MARK: - UITableViewDelegate protocol conformance

extension PaymentViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constant.CardPaymentMenu.headerHeight
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return Constant.CardPaymentMenu.footerHeight
    }
}
