//
//  SideMenuViewController.swift
//  Podo
//
//  Created by m3g0byt3 on 23/11/2017.
//  Copyright © 2017 m3g0byt3. All rights reserved.
//

import UIKit
import SnapKit

final class SideMenuViewController: UIViewController, SideMenuView {

    // MARK: - Properties

    // swiftlint:disable:next implicitly_unwrapped_optional
    private weak var navigationBar: UINavigationBar!
    // TODO: Replace with view model
    private lazy var tableViewDataSource = SideMenuTableViewProvider()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMiscellaneousUI()
        setupTableView()
    }

    // MARK: - Private API

    private func setupTableView() {
        // `-1` to hide bottom separator
        let tableViewHeight = CGFloat(tableViewDataSource.entriesCount) * Constant.SideMenu.rowHeight - 1
        let tableView = UITableView()

        tableView.dataSource = tableViewDataSource
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = R.clr.podoColors.white()
        tableView.rowHeight = Constant.SideMenu.rowHeight
        tableView.register(R.nib.sideMenuTableViewCell)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(navigationBar.snp.bottom)
            make.height.equalTo(tableViewHeight)
        }
    }

    private func setupMiscellaneousUI() {
        let navigationBar = UINavigationBar()

        navigationBar.delegate = self
        self.navigationBar = navigationBar
        view.addSubview(navigationBar)
        view.backgroundColor = R.clr.podoColors.green()
        navigationBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
        }
    }

    // MARK: - SideMenuView protocol conformance

    var onSideMenuEntrySelection: ((Any) -> Void)?
    var onSideMenuClose: Completion?
}

// MARK: - UINavigationBarDelegate protocol conformance

extension SideMenuViewController: UINavigationBarDelegate {

    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}

// MARK: - UITableViewDelegate protocol conformance

extension SideMenuViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        onSideMenuEntrySelection?(indexPath)
    }
}
