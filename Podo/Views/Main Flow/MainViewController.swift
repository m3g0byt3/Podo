//
//  MainViewController.swift
//  Podo
//
//  Created by m3g0byt3 on 23/11/2017.
//  Copyright © 2017 m3g0byt3. All rights reserved.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController, MainView {

    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Properties
    // swiftlint:disable weak_delegate implicitly_unwrapped_optional
    // sideMenuTransitioningDelegate isn't weak because VC doesn't store reference to its transitioningDelegate
    var sideMenuTransitioningDelegate: SideMenuTransitioningDelegate!
    // TODO: - Custom transitions must be handled by Router!
    var viewModel: MainMenuViewModel!
    private weak var transportCardsView: UIView?
    private var tableViewVerticalInset: CGFloat { return view.bounds.height * Constant.MainMenu.verticalInsetRatio }
    // swiftlint:enable weak_delegate implicitly_unwrapped_optional

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupCardsViewController()
        setupMiscellaneousUI()
    }

    // MARK: - Control handlers
    @IBAction private func sideMenuButtonHandler(_ sender: UIBarButtonItem) {
        // TODO: - Must be handled by Coordinator!
        sideMenuTransitioningDelegate.interactivePresentation = false
        showSideMenu()
    }

    @objc private func edgePanHandler(_ sender: UIScreenEdgePanGestureRecognizer) {
        // TODO: - Must be handled by Coordinator!
        switch sender.state {
        case .began:
            sideMenuTransitioningDelegate.interactivePresentation = true
            showSideMenu()
        default:
            sideMenuTransitioningDelegate.interactorClosure?(sender)
        }
    }

    // MARK: - Private API
    private func showSideMenu() {
        // TODO: - Must be handled by Router!
        let sideMenuVC = SideMenuViewController.navigationControllerInstance()
        sideMenuVC.modalPresentationStyle = .custom
        sideMenuVC.transitioningDelegate = sideMenuTransitioningDelegate
        present(sideMenuVC, animated: true)
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
}

// MARK: - UITableViewDataSource protocol conformance

extension MainViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.childViewModelsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: Add actual implementation with cell viewModel assignation
        return tableView.dequeueReusableCell(withIdentifier: R.nib.cardsTableViewCell.identifier, for: indexPath)
    }
}

// MARK: - UITableViewDelegate protocol conformance
extension MainViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let transportCardsView = transportCardsView,
            let transportCardsViewIndex = tableView.subviews.index(of: transportCardsView) {
            tableView.exchangeSubview(at: 0, withSubviewAt: transportCardsViewIndex)
        }
    }
}
