//
//  MainMenuViewController.swift
//  Podo
//
//  Created by m3g0byt3 on 23/11/2017.
//  Copyright © 2017 m3g0byt3. All rights reserved.
//

import UIKit
import SnapKit

final class MainMenuViewController: UIViewController, MainMenuView {

    // MARK: - IBOutlets

    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Properties
    // swiftlint:disable:next implicitly_unwrapped_optional
    var viewModel: MainMenuViewModel!
    private weak var transportCardsView: UIView?
    private var tableViewVerticalInset: CGFloat { return view.bounds.height * Constant.MainMenu.verticalInsetRatio }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupCardsViewController()
        setupMiscellaneousUI()
    }

    // MARK: - Control handlers

    @IBAction private func sideMenuButtonHandler(_ sender: UIBarButtonItem) {
        onSideMenuSelection?()
    }

    @objc private func edgePanHandler(_ sender: UIScreenEdgePanGestureRecognizer) {
        onSideMenuSelection?()
    }

    private func setupCardsViewController() {
        guard let cardsViewController = CardsViewController.storyboardInstance() else { return }
        // UIKit calls .willMove implicitly before .addChildViewController
        addChildViewController(cardsViewController)
        tableView.addSubview(cardsViewController.view)
        cardsViewController.didMove(toParentViewController: self)
        transportCardsView = cardsViewController.view
        cardsViewController.view.snp.makeConstraints { make in
            make.centerX.width.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(tableView.snp.top)
                .offset(tableView.bounds.height * Constant.MainMenu.tableViewToCardViewOffsetRatio)
                .priority(.high)
        }
    }

    private func setupTableView() {
        tableView.register(R.nib.cardsTableViewCell)
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets(top: tableViewVerticalInset, left: 0, bottom: 0, right: 0)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = Constant.MainMenu.estimatedRowHeight
    }

    private func setupMiscellaneousUI() {
        let edgePanGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(edgePanHandler(_:)))
        edgePanGesture.edges = .left
        view.addGestureRecognizer(edgePanGesture)
        navigationItem.titleView = NavigationBarTitleView()
    }

    // MARK: - MainMenuView protocol conformance

    var onSideMenuSelection: Completion?
    var onAddNewCardSelection: Completion?
    var onCardSelection: ((Any) -> Void)?
}

// MARK: - UITableViewDataSource protocol conformance

extension MainMenuViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.childViewModelsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: Add actual implementation with cell viewModel assignation
        return tableView.dequeueReusableCell(withIdentifier: R.nib.cardsTableViewCell.identifier, for: indexPath)
    }
}

// MARK: - UITableViewDelegate protocol conformance

extension MainMenuViewController: UITableViewDelegate {

    // Place `transportCardsView` on the top of `tableView`
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let transportCardsView = transportCardsView,
            let transportCardsViewIndex = tableView.subviews.index(of: transportCardsView) {
            tableView.exchangeSubview(at: 0, withSubviewAt: transportCardsViewIndex)
        }
    }
}
