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
        tableView.dataSource = tableViewDataSource
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
        tableView.register(R.nib.sideMenuTableViewCell)
    }

    private func setupMiscellaneousUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = R.clr.podoColors.green()
    }
}

// MARK: - UITableViewDelegate protocol conformance
extension SideMenuViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
