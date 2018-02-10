//
//  CardsViewController.swift
//  Podo
//
//  Created by m3g0byt3 on 09/12/2017.
//  Copyright © 2017 m3g0byt3. All rights reserved.
//

import UIKit
import SnapKit

final class CardsViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var collectionViewTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var collectionViewBottomConstraint: NSLayoutConstraint!

    // MARK: - Properties
    /// DataSource for collectionView
    private lazy var collectionViewDatasource = СollectionViewProvider()
    /// Stores initial this VC's view size after `viewDidAppear(_ animated:)` called
    private var viewInitialSize: CGSize?
    /// Returns ratio between initial and current height of this VC's view
    private var parentViewHeightRatio: CGFloat? {
        guard let viewInitialSize = viewInitialSize else { return nil }
        return view.bounds.height / viewInitialSize.height
    }

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
        collectionView.dataSource = collectionViewDatasource
        // Apply offset to bottom-to-superview IB constrait
        collectionViewBottomConstraint.constant = Constant.MainMenu.collectionViewBottomOffset
    }

    private func setupCollectionViewTopConstraint() {
        // First deactivate top-to-superview IB constrait..
        NSLayoutConstraint.deactivate([collectionViewTopConstraint])
        // ..Then add fixed height constrait - to avoid wrong collectionView initial centering
        collectionView.snp.makeConstraints { $0.height.equalTo(view.bounds.height) }
    }
}

// MARK: - UICollectionViewDelegate protocol conformance
extension MainViewController: UICollectionViewDelegate {
    // TODO: Add actual implementation
}
