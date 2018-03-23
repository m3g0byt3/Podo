//
//  SideMenuViewController.swift
//  Podo
//
//  Created by m3g0byt3 on 23/11/2017.
//  Copyright © 2017 m3g0byt3. All rights reserved.
//

import UIKit
import SnapKit

final class SideMenuViewController: UIViewController, SideMenuView, InteractiveTransitioningCapable {

    // MARK: - Properties

    // swiftlint:disable:next implicitly_unwrapped_optional
    private weak var navigationBar: UINavigationBar!
    // swiftlint:disable:next implicitly_unwrapped_optional
    var viewModel: AnyViewModel<SideMenuCellViewModel>!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMiscellaneousUI()
        setupTableView()
    }

    // MARK: - Private API

    private func setupTableView() {
        let rowCount = viewModel.numberOfChildViewModels(in: 0)
        // `-1` for hidden bottom separator
        let tableViewHeight = CGFloat(rowCount) * Constant.SideMenu.rowHeight - 1
        let tableView = UITableView()

        tableView.dataSource = self
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

    var onSideMenuEntrySelection: ((SideMenuCellViewModel) -> Void)?
    var onSideMenuClose: Completion?

    // MARK: - InteractiveTransitioningCapable protocol conformance

    var isTransitionInteractive = false
    var onInteractiveTransition: ((UIPanGestureRecognizer) -> Void)?
}

// MARK: - UINavigationBarDelegate protocol conformance

extension SideMenuViewController: UINavigationBarDelegate {

    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}

// MARK: - UITableViewDataSource protocol conformance

extension SideMenuViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfChildViewModels(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.sideMenuTableViewCell, for: indexPath)!
        cell.viewModel = viewModel.childViewModel(for: indexPath)
        return cell
    }
}

// MARK: - UITableViewDelegate protocol conformance

extension SideMenuViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.childViewModel(for: indexPath).flatMap { onSideMenuEntrySelection?($0) }
    }
}
