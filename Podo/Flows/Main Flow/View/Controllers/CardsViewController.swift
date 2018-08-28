//
//  CardsViewController.swift
//  Podo
//
//  Created by m3g0byt3 on 09/12/2017.
//  Copyright © 2017 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class CardsViewController: UIViewController,
                                 MainMenuChildView {

    // MARK: - IBOutlets

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var pageControl: UIPageControl!
    @IBOutlet private weak var collectionViewTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var collectionViewBottomConstraint: NSLayoutConstraint!

    // MARK: - Properties

    // swiftlint:disable:next implicitly_unwrapped_optional
    var viewModel: CardsViewModelProtocol!
    private let disposeBag = DisposeBag()

    /// Stores initial this VC's view size after `viewDidAppear(_ animated:)` called
    private var viewInitialSize: CGSize?

    /// Returns ratio between initial and current height of this VC's view
    private var parentViewHeightRatio: CGFloat? {
        guard let viewInitialSize = viewInitialSize else { return nil }
        return view.bounds.height / viewInitialSize.height
    }

    /// Setup constraints for the collection view.
    /// - warning: ⚠️ Dispatched once. ⚠️
    private lazy var setupCollectionViewTopConstraint: () -> Void = {
        // First deactivate top-to-superview IB constrait..
        NSLayoutConstraint.deactivate([collectionViewTopConstraint])
        // ..Then add fixed height constrait - to avoid wrong collectionView initial centering
        collectionView.snp.makeConstraints { $0.height.equalTo(view.bounds.height) }
        // Return dummy closure
        return {}
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupBindings()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupCollectionViewTopConstraint()
        viewInitialSize = view.bounds.size
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        transformCollectionView()
    }

    // MARK: - MainMenuChildView protocol conformance

    var onAddNewCardSelection: Completion?
    var onCardSelection: ((TransportCardViewModelProtocol) -> Void)?

    // MARK: - Types

    private enum ViewModelWrapper {
        case data(TransportCardViewModelProtocol)
        case empty
    }

    // MARK: - Private API

    private func setupBindings() {
        // Cell factory
        viewModel.output.childViewModels
            .flatMap(CardsViewController.wrapViewModels)
            .asDriver(onErrorJustReturn: [])
            .drive(collectionView.rx.items) { collectionView, index, wrappedViewModel in
                let indexPath = IndexPath(item: index, section: 0)
                switch wrappedViewModel {
                case .data(let viewModel):
                    return collectionView
                        // swiftlint:disable force_unwrapping
                        .dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.cardsCollectionViewCell, for: indexPath)!
                        .configure(with: viewModel)
                case .empty:
                    return collectionView
                        // swiftlint:disable force_unwrapping
                        .dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.addNewCardCollectionViewCell, for: indexPath)!
                }
            }
            .disposed(by: disposeBag)

        // Cell selection
        collectionView.rx.modelSelected(ViewModelWrapper.self)
            .subscribe(onNext: { [weak self] wrappedViewModel in
                switch wrappedViewModel {
                case .data(let viewModel): self?.onCardSelection?(viewModel)
                case .empty: self?.onAddNewCardSelection?()
                }
            })
            .disposed(by: disposeBag)

        // numberOfPages for pageControl
        viewModel.output.childViewModels
            .flatMap(CardsViewController.wrapViewModels)
            .map { $0.count }
            .asDriver(onErrorJustReturn: 0)
            .drive(pageControl.rx.numberOfPages)
            .disposed(by: disposeBag)

        // pageControl -> collectionView
        pageControl.rx.value
            .skip(1)
            .map { IndexPath(item: $0, section: 0) }
            .subscribe(onNext: { [weak self] indexPath in
                self?.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            })
            .disposed(by: disposeBag)

        // collectionView -> pageControl
        collectionView.rx.didScroll
            .map { [weak self] _ in
                self?.collectionView.currentRow(inSection: 0, alongAxis: .horizontal)
            }
            .filterNil()
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: 0)
            .drive(pageControl.rx.currentPage)
            .disposed(by: disposeBag)
    }

    /// Wraps view models inside simple wrapper enum `ViewModelWrapper` and appends `ViewModelWrapper.empty`
    /// at the end of the resulting sequence to show additional `add new card` cell.
    /// - parameter viewModels: Array of view models.
    /// - returns: Driver trait: `Driver<[ViewModelWrapper]`
    private static func wrapViewModels(_ viewModels: [TransportCardViewModelProtocol]) -> Driver<[ViewModelWrapper]> {
        let wrappedViewModels = viewModels.map(ViewModelWrapper.data)
        let empty = [ViewModelWrapper.empty]
        return Driver.of(Array([wrappedViewModels, empty].joined()))
    }

    private func setupCollectionView() {
        collectionView.register(R.nib.cardsCollectionViewCell)
        collectionView.register(R.nib.addNewCardCollectionViewCell)
        // Apply offset to bottom-to-superview IB constrait
        collectionViewBottomConstraint.constant = Constant.MainMenu.collectionViewBottomOffset
    }

    private func transformCollectionView() {
        guard let ratio = parentViewHeightRatio else { return }
        let scrollUpAlpha = 2 - pow(ratio, 4)
        let scrollDownAlpha = min(1, pow(ratio, 1.5))
        let scale = max(1, ratio)
        pageControl.alpha = ratio > 1 ? scrollUpAlpha : scrollDownAlpha
        collectionView.alpha = scrollDownAlpha
        collectionView.transform = CGAffineTransform(scaleX: scale, y: scale)
    }
}
