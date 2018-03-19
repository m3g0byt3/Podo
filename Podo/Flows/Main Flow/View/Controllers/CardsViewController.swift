//
//  CardsViewController.swift
//  Podo
//
//  Created by m3g0byt3 on 09/12/2017.
//  Copyright © 2017 m3g0byt3. All rights reserved.
//

import UIKit
import SnapKit

final class CardsViewController: UIViewController, MainMenuChildView {

    // MARK: - IBOutlets

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var collectionViewTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var collectionViewBottomConstraint: NSLayoutConstraint!

    // MARK: - Properties

    // swiftlint:disable:next implicitly_unwrapped_optional
    var viewModel: AnyViewModel<CardsCellViewModel>!
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
     - warning: Dispatched once.
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
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupCollectionViewTopConstraint()
        viewInitialSize = view.bounds.size
    }

    override func viewWillLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let ratio = parentViewHeightRatio {
            collectionView.alpha = min(1, ratio)
            collectionView.transform = CGAffineTransform(scaleX: max(1, ratio), y: max(1, ratio))
        }
    }

    // MARK: - Private API

    private func setupCollectionView() {
        collectionView.register(R.nib.cardsCollectionViewCell)
        // Apply offset to bottom-to-superview IB constrait
        collectionViewBottomConstraint.constant = Constant.MainMenu.collectionViewBottomOffset
    }

    // MARK: - MainMenuChildView protocol conformance

    var onAddNewCardSelection: Completion?
    var onCardSelection: ((CardsCellViewModel) -> Void)?
}

// MARK: - UICollectionViewDataSource protocol conformance

extension CardsViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // TODO: return +1, because there should be an `add new card` cell
        return viewModel.numberOfChildViewModels(in: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.nib.cardsCollectionViewCell.identifier, for: indexPath)
        if let cell = cell as? CardsCollectionViewCell {
            cell.viewModel = viewModel.childViewModel(for: indexPath)
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegate protocol conformance

extension CardsViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if let childViewModel = viewModel.childViewModel(for: indexPath) {
            onCardSelection?(childViewModel)
        } else {
            onAddNewCardSelection?()
        }
    }
}
