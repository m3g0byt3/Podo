//
//  SideMenuViewController.swift
//  Podo
//
//  Created by m3g0byt3 on 23/11/2017.
//  Copyright © 2017 m3g0byt3. All rights reserved.
//

import UIKit
import SnapKit

final class SideMenuViewController: UIViewController {

    // MARK: - Properties
    private lazy var tableViewDataSource = SideMenuTableViewProvider()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMiscellaneousUI()
        setupTableView()
    }

    // MARK: - Private API
    private func setupTableView() {
        let tableView = UITableView()
        // `-1` to hide bottom separator
        let tableViewHeight = CGFloat(tableViewDataSource.entriesCount) * Constant.SideMenu.rowHeight - 1

        tableView.dataSource = tableViewDataSource
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = R.clr.podoColors.white()
        tableView.rowHeight = Constant.SideMenu.rowHeight
        tableView.register(R.nib.sideMenuTableViewCell)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(tableViewHeight)
        }
    }

    private func setupMiscellaneousUI() {
        view.backgroundColor = R.clr.podoColors.green()
        navigationController?.navigationBar.barTintColor = R.clr.podoColors.green()
    }
}

// MARK: - UITableViewDelegate protocol conformance
extension SideMenuViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
