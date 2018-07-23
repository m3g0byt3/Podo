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
            configureCell: { (dataSource, tableView, indexPath, viewModel) in
                switch dataSource[indexPath] {
                case .paymentCardSectionItem(let title):
                    let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.paymentCardCell,
                                                             for: indexPath)!
                    // FIXME: test only logging
                    print(title)
                    return cell
                case .transportCardSectionItem(let title):
                    let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.transportCardCell,
                                                             for: indexPath)!
                    // FIXME: test only logging
                    print(title)
                    return cell
                case .amountFieldSectionItem(let title):
                    let cell: AmountFieldCell = tableView.dequeueReusableCell(for: indexPath)
                    // FIXME: test only logging
                    print(title)
                    cell.configure(with: NSObject())
                    return cell
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
