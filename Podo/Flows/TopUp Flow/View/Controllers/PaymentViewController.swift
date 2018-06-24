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

class PaymentViewController: UIViewController, PaymentView, TrainIconTitleView {

    // MARK: IBOutlets

    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Properties

    // swiftlint:disable:next implicitly_unwrapped_optional
    var viewModel: PaymentConfirmationViewModel!
    private let disposeBag = DisposeBag()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupBindings()
    }

    // MARK: - Private API

    private func setupTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(R.nib.paymentCardCell)
        tableView.register(R.nib.transportCardCell)
        tableView.register(R.nib.amountFieldCell)
    }

    private func setupBindings() {
        let dataSource = PaymentViewController.dataSource()

        viewModel.sections
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}

private extension PaymentViewController {

    static func dataSource() -> RxTableViewSectionedReloadDataSource<PaymentConfirmationSectionViewModelImpl> {
        return RxTableViewSectionedReloadDataSource<PaymentConfirmationSectionViewModelImpl>(
            configureCell: { (dataSource, tableView, indexPath, viewModel) in
                switch dataSource[indexPath] {
                case .paymentCardSectionItem(let title):
                    let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.paymentCardCell,
                                                             for: indexPath)!
                    print(title)
                    return cell
                case .transportCardSectionItem(let title):
                    let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.transportCardCell,
                                                             for: indexPath)!
                    print(title)
                    return cell
                case .amountFieldSectionItem(let title):
                    let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.amountFieldCell,
                                                             for: indexPath)!
                    print(title)
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
