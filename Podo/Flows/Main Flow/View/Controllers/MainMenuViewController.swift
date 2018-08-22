//
//  MainMenuViewController.swift
//  Podo
//
//  Created by m3g0byt3 on 23/11/2017.
//  Copyright © 2017 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Swinject
import EmptyDataSet_Swift

final class MainMenuViewController: UIViewController,
                                    MainMenuView,
                                    TrainIconTitleView {

    // MARK: - IBOutlets

    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Properties

    // swiftlint:disable:next implicitly_unwrapped_optional
    var viewModel: AnyViewModel<MainMenuCellViewModelProtocol>!
    var assembler: Assembler?
    private weak var transportCardsView: UIView?
    private var tableViewVerticalInset: CGFloat { return view.bounds.height * Constant.MainMenu.verticalInsetRatio }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupCardsViewController()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let splashImage = R.image.leafWithInsetsMask() else { return }
        SplashView.show(for: Constant.MainMenu.splashScreenDuration,
                        image: splashImage,
                        outerColor: R.clr.podoColors.green())
    }

    // MARK: - Private API

    private func setupCardsViewController() {
        guard let childView = assembler?.resolver.resolve(MainMenuChildView.self),
            let childViewController = childView.presentableEntity else {
                return
        }
        // Forward callbacks to the childView
        childView.onCardSelection = onCardSelection
        childView.onAddNewCardSelection = onAddNewCardSelection

        // UIKit calls .willMove implicitly before .addChildViewController
        addChildViewController(childViewController)
        tableView.addSubview(childViewController.view)
        childViewController.didMove(toParentViewController: self)
        transportCardsView = childViewController.view
        childViewController.view.snp.makeConstraints { make in
            make.centerX.width.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(tableView.snp.top)
                .offset(tableView.bounds.height * Constant.MainMenu.tableViewToCardViewOffsetRatio)
                .priority(.high)
        }
    }

    private func setupTableView() {
        tableView.register(R.nib.mainMenuTableViewCell)
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets(top: tableViewVerticalInset, left: 0, bottom: 0, right: 0)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = Constant.MainMenu.estimatedRowHeight
        // Setup EmptyDataSet_Swift
        tableView.emptyDataSetView { view in
            let title = NSAttributedString(string: R.string.localizable.noTransaction())
            let detailTitle = NSAttributedString(string: R.string.localizable.addCard())
            let imageWidth = view.frame.width * Constant.MainMenu.emptyImageWidthRatio
            let verticalOffset = view.frame.height * Constant.MainMenu.emptyVerticalOffsetRatio
            let image = #imageLiteral(resourceName: "crying-card").scaledImage(width: imageWidth)
            view.titleLabelString(title)
                .detailLabelString(detailTitle)
                .verticalOffset(verticalOffset)
                .imageTintColor(R.clr.podoColors.empty())
                .image(image)
        }
    }

    // MARK: - MainMenuView protocol conformance

    var onAddNewCardSelection: Completion?
    var onCardSelection: ((TransportCardViewModelProtocol) -> Void)?

    // MARK: - InteractiveTransitioningCapable protocol conformance

    var isTransitionInteractive = false
    var onInteractiveTransition: ((UIPanGestureRecognizer) -> Void)?

    // MARK: - SideMenuPresenting protocol conformance

    var onSideMenuSelection: Completion?
}

// MARK: - UITableViewDataSource protocol conformance

extension MainMenuViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfChildViewModels(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_unwrapping
        return tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.mainMenuTableViewCell, for: indexPath)!
            .configure(with: viewModel.childViewModel(for: indexPath))
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
