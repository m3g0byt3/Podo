//
//  TopUpViewController.swift
//  Podo
//
//  Created by m3g0byt3 on 16/04/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

final class TopUpViewController: UIViewController,
                                 TopUpView,
                                 TrainIconTitleView {

    // MARK: - IBOutlets

    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Properties

    // swiftlint:disable:next implicitly_unwrapped_optional
    var viewModel: PaymentMethodViewModelProtocol!
    private let disposeBag = DisposeBag()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupBindings()
    }

    deinit {
        onPaymentCancel?()
    }

    // MARK: - TopUpView protocol conformance

    var onPaymentMethodSelection: ((PaymentMethodCellViewModelProtocol) -> Void)?
    var onPaymentCancel: Completion?

    // MARK: - Private API

    private func setupTableView() {
        tableView.isScrollEnabled = false
        tableView.register(R.nib.paymentMethodCell)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = Constant.TopUpMenu.estimatedRowHeight
    }

    private func setupBindings() {

        let identifier = R.nib.paymentMethodCell.identifier
        let type = PaymentMethodCell.self

        viewModel.paymentMethods
            .asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(cellIdentifier: identifier, cellType: type)) { (_, viewModel, cell) in
                cell.configure(with: viewModel)
            }
            .disposed(by: disposeBag)

        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.tableView.deselectRow(at: indexPath, animated: true)
            })
            .disposed(by: disposeBag)

        tableView.rx.modelSelected(PaymentMethodCellViewModelProtocol.self)
            .subscribe(onNext: { [weak self] paymentMethod in
                self?.onPaymentMethodSelection?(paymentMethod)
            })
            .disposed(by: disposeBag)
    }
}
