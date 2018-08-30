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
import EmptyDataSet_Swift
import RxSwift
import RxCocoa

final class MainMenuViewController: UIViewController,
                                    MainMenuView,
                                    TrainIconTitleView {

    // MARK: - MainMenuView protocol conformance

    var onAddNewCardSelection: Completion?
    var onCardSelection: ((TransportCardViewModelProtocol) -> Void)?

    // MARK: - InteractiveTransitioningCapable protocol conformance

    var isTransitionInteractive = false
    var onInteractiveTransition: ((UIPanGestureRecognizer) -> Void)?

    // MARK: - SideMenuPresenting protocol conformance

    var onSideMenuSelection: Completion?

    // MARK: - Typealiases

    private typealias EmptyDataSetConfig = (NSAttributedString, NSAttributedString, UIImage)

    // MARK: - IBOutlets

    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Public properties

    // swiftlint:disable:next implicitly_unwrapped_optional
    var viewModel: MainMenuViewModelProtocol!
    var childView: MainMenuChildView?

    // MARK: - Private properties

    private let disposeBag = DisposeBag()
    private weak var transportCardsView: UIView?

    private var tableViewVerticalInset: CGFloat {
        return view.bounds.height * Constant.MainMenu.verticalInsetRatio
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        setupChildViewController()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let splashImage = R.image.leafWithInsetsMask() else { return }
        #if SHOW_SPLASH_SCREEN
        SplashView.show(for: Constant.MainMenu.splashScreenDuration,
                        image: splashImage,
                        outerColor: R.clr.podoColors.green())
        #endif
    }

    // MARK: - Private API

    private func setupChildViewController() {
        guard let childViewController = childView?.presentableEntity else { return }
        // Forward callbacks to the childView
        childView?.onCardSelection = onCardSelection
        childView?.onAddNewCardSelection = onAddNewCardSelection

        // UIKit calls .willMove implicitly before .addChildViewController
        addChildViewController(childViewController)
        tableView.addSubview(childViewController.view)
        childViewController.didMove(toParentViewController: self)
        transportCardsView = childViewController.view
        childViewController.view.snp.makeConstraints { maker in
            maker.centerX.width.equalToSuperview()
            maker.top.equalTo(safeAreaLayoutGuide.snp.top)
            maker.bottom.equalTo(tableView.snp.top)
                .offset(tableView.bounds.height * Constant.MainMenu.tableViewToCardViewOffsetRatio)
                .priority(.high)
        }
    }

    private func setupUI() {
        tableView.register(R.nib.mainMenuTableViewCell)
        tableView.contentInset = UIEdgeInsets(top: tableViewVerticalInset, left: 0, bottom: 0, right: 0)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = Constant.MainMenu.estimatedRowHeight
    }

    private func setupBindings() {
        let identifier = R.nib.mainMenuTableViewCell.identifier
        let type = MainMenuTableViewCell.self

        viewModel.output.paymentResults
            .asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(cellIdentifier: identifier, cellType: type)) { _, viewModel, cell in
                cell.configure(with: viewModel)
            }
            .disposed(by: disposeBag)

        tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)

        let title = viewModel.output.emptyTitle
            .asDriver(onErrorJustReturn: Constant.Placeholder.empty)
            .map(NSAttributedString.init)
            .asObservable()

        let message = viewModel.output.emptyMessage
            .asDriver(onErrorJustReturn: Constant.Placeholder.empty)
            .map(NSAttributedString.init)
            .asObservable()

        let image = viewModel.output.emptyImageBlob
            .asDriver(onErrorJustReturn: nil)
            .filterNil()
            .map(UIImage.init)
            .filterNil()
            .map { $0.withRenderingMode(.alwaysTemplate) }
            .asObservable()

        Observable.combineLatest(title, message, image)
            .flatMap { [weak self] config -> Completable in
                return self?.configureEmptyDataset(config) ?? .empty()
            }
            .subscribe()
            .disposed(by: disposeBag)
    }

    private func configureEmptyDataset(_ config: EmptyDataSetConfig) -> Completable {
        return Completable.create { [weak self] completable in
            self?.tableView.emptyDataSetView { view in
                let imageWidth = view.frame.width * Constant.MainMenu.emptyImageWidthRatio
                let verticalOffset = view.frame.height * Constant.MainMenu.emptyVerticalOffsetRatio
                let image = config.2.scaledImage(width: imageWidth)
                view.titleLabelString(config.0)
                    .detailLabelString(config.1)
                    .verticalOffset(verticalOffset)
                    .image(image)
                    .imageTintColor(R.clr.podoColors.empty())
            }

            completable(.completed)

            return Disposables.create()
        }
    }
}

// MARK: - UITableViewDelegate protocol conformance

extension MainMenuViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Place `transportCardsView` on the top of `tableView`
        if  let transportCardsView = transportCardsView,
            let transportCardsViewIndex = tableView.subviews.index(of: transportCardsView) {
            tableView.exchangeSubview(at: 0, withSubviewAt: transportCardsViewIndex)
        }
    }
}
