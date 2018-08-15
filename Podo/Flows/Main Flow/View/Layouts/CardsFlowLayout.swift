//
//  CardsFlowLayout.swift
//  Podo
//
//  Created by m3g0byt3 on 10/12/2017.
//  Copyright © 2017 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit

/// Horizontally-scrolled, paginated UICollectionViewFlowLayout
final class CardsFlowLayout: UICollectionViewFlowLayout {

    // MARK: - Properties

    /// Setup initial insets for the collection view.
    /// - warning: ⚠️ Dispatched once. ⚠️
    private lazy var setupInitialInsets: () -> Void = { [weak self] in
        self?.collectionView?.contentInset = UIEdgeInsets(top: 0, left: initialInsets, bottom: 0, right: initialInsets)
        // Return dummy closure
        return {}
    }()

    private var initialInsets: CGFloat {
        guard let collectionView = collectionView else { return 0.0 }
        return (collectionView.bounds.width - itemSize.width) / 2
    }

    // MARK: - Public API

    override var itemSize: CGSize {
        get {
            guard let collectionView = collectionView else { return .zero }
            let edgesOffset = Constant.MainMenu.cellEdgesOffset
            let widthRatio = Constant.MainMenu.cellWidthToCollectionViewWidthRatio
            let aspectRatio = Constant.MainMenu.creditCardAspectRatio
            let width = collectionView.frame.width * widthRatio - edgesOffset
            let height = width * aspectRatio + edgesOffset

            return CGSize(width: width, height: height)
        }
        set {}
    }

    override var scrollDirection: UICollectionViewScrollDirection {
        get { return .horizontal }
        set {}
    }

    override var minimumLineSpacing: CGFloat {
        get { return 0 }
        set {}
    }

    override func prepare() {
        super.prepare()
        setupInitialInsets()
    }

    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint,
                                      withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return proposedContentOffset }
        let offsetStep = collectionView.contentSize.width / CGFloat(collectionView.numberOfItems(inSection: 0))
        let offsetMultiplier = round((proposedContentOffset.x + initialInsets) / offsetStep)
        let offset = offsetStep * offsetMultiplier - initialInsets

        return CGPoint(x: offset, y: 0)
    }
}
