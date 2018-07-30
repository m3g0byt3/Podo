//
//  CardsViewController.swift
//  Podo
//
//  Created by m3g0byt3 on 09/12/2017.
//  Copyright © 2017 m3g0byt3. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class CardsViewController: UIViewController,
                                 MainMenuChildView {

    // MARK: - IBOutlets

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var collectionViewTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var collectionViewBottomConstraint: NSLayoutConstraint!

    // MARK: - Properties

    // swiftlint:disable:next implicitly_unwrapped_optional
    var viewModel: CardsViewModelProtocol!
    private let disposeBag = DisposeBag()
    /**
     Stores initial this VC's view size after `viewDidAppear(_ animated:)` called
     */
    private var viewInitialSize: CGSize?
    /**
     Returns ratio between initial and current height of this VC's view
     */
    private var parentViewHeightRatio: CGFloat? {
        guard let viewInitialSize = viewInitialSize else { return nil }
        return view.bounds.height / viewInitialSize.height
    }
    /**
     Setup constraints for the collection view.
     - warning: ⚠️ Dispatched once. ⚠️
     */
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
        if let ratio = parentViewHeightRatio {
            collectionView.alpha = min(1, ratio)
            collectionView.transform = CGAffineTransform(scaleX: max(1, ratio), y: max(1, ratio))
        }
    }

    // MARK: - MainMenuChildView protocol conformance

    var onAddNewCardSelection: Completion?
    var onCardSelection: ((TransportCardViewModelProtocol) -> Void)?

    // MARK: - Types

    private enum ViewModelWrapper {
        // swiftlint:disable:next identifier_name
        case data(TransportCardViewModelProtocol)
        case empty
    }

    // MARK: - Private API

    private func setupBindings() {
        // Cell factory
        viewModel.childViewModels
            .flatMap(CardsViewController.wrapViewModels)
            .asDriver(onErrorJustReturn: [])
            .drive(collectionView.rx.items) { (collectionView, index, wrappedViewModel) in
                let indexPath = IndexPath(item: index, section: 0)
                switch wrappedViewModel {
                case .data(let viewModel):
                    return collectionView
                        .dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.cardsCollectionViewCell, for: indexPath)!
                        .configure(with: viewModel)
                case .empty:
                    return collectionView
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
    }

    /**
     Wraps view models inside simple wrapper enum `ViewModelWrapper` and appends `ViewModelWrapper.empty`
     at the end of the resulting sequence to show additional `add new card` cell.
     - parameter viewModels: Array of view models.
     - returns: Driver trait: `Driver<[ViewModelWrapper]`
     */
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
}
