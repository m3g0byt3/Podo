//
//  SideMenuViewController.swift
//  Podo
//
//  Created by m3g0byt3 on 23/11/2017.
//  Copyright © 2017 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SideMenuViewController: UIViewController,
                                    SideMenuView,
                                    InteractiveTransitioningCapable {

    // MARK: - SideMenuView protocol conformance

    var onSideMenuEntrySelection: ((SideMenuCellViewModelProtocol) -> Void)?
    var onSideMenuClose: Completion?

    // MARK: - InteractiveTransitioningCapable protocol conformance

    var isTransitionInteractive = false
    var onInteractiveTransition: ((UIPanGestureRecognizer) -> Void)?

    // MARK: - Public Properties

    // swiftlint:disable:next implicitly_unwrapped_optional
    var viewModel: SideMenuViewModelProtocol!

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - Private Properties

    private let disposeBag = DisposeBag()

    private var tableViewHeight: CGFloat {
        let rowCount = tableView.numberOfRows(inSection: 0)
        // Subtract 1 pt to hide bottom separator
        return CGFloat(rowCount) * Constant.SideMenu.rowHeight - 1
    }

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(R.nib.sideMenuTableViewCell)
        tableView.isScrollEnabled = false
        tableView.separatorColor = R.clr.podoColors.white()
        tableView.rowHeight = Constant.SideMenu.rowHeight
        return tableView
    }()

    private lazy var navigationBar = UINavigationBar()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }

    // MARK: - Public API

    override func updateViewConstraints() {
        tableView.snp.updateConstraints { maker in
            maker.top.equalTo(navigationBar.snp.bottom)
            maker.leading.trailing.equalToSuperview()
            maker.height.equalTo(tableViewHeight)
        }

        navigationBar.snp.updateConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.top.equalTo(safeAreaLayoutGuide.snp.top)
        }

        super.updateViewConstraints()
    }

    // MARK: - Private API

    private func setupBindings() {
        let identifier = R.nib.sideMenuTableViewCell.identifier
        let type = SideMenuTableViewCell.self

        viewModel.output.sideMenuItems
            .asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(cellIdentifier: identifier, cellType: type)) { _, viewModel, cell in
                cell.configure(with: viewModel)
            }
            .disposed(by: disposeBag)

        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.tableView.deselectRow(at: indexPath, animated: true)
            })
            .disposed(by: disposeBag)

        tableView.rx.modelSelected(SideMenuCellViewModelProtocol.self)
            .subscribe(onNext: { [weak self] sideMenuEntry in
                self?.onSideMenuEntrySelection?(sideMenuEntry)
            })
            .disposed(by: disposeBag)
    }

    private func setupUI() {
        view.backgroundColor = R.clr.podoColors.green()
        view.setNeedsUpdateConstraints()
        view.addSubview(navigationBar)
        view.addSubview(tableView)
    }
}
