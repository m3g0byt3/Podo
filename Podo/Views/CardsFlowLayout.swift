//
//  CardsFlowLayout.swift
//  Podo
//
//  Created by m3g0byt3 on 10/12/2017.
//  Copyright © 2017 m3g0byt3. All rights reserved.
//

import UIKit
/// Horizontally-scrolled, paginated UICollectionViewFlowLayout
class CardsFlowLayout: UICollectionViewFlowLayout {

    private var initialInsetsDidSet = false
    private var initialInsets: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        return (collectionView.bounds.width - itemSize.width) / 2
    }
    
    override var itemSize: CGSize {
        get {
            guard let frame = collectionView?.frame else { return CGSize.zero }
            let height = frame.height * MainMenu.cellHeightToSuperViewHeightRatio
            let width = height / MainMenu.cardViewHeightWidthRatio + MainMenu.cellLeftRightMargins
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
        if !initialInsetsDidSet, let collectionView = collectionView {
            initialInsetsDidSet = true
            collectionView.contentInset = UIEdgeInsets(top: 0, left: initialInsets, bottom: 0, right: initialInsets)
        }
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return proposedContentOffset }
        
        let offsetStep = collectionView.contentSize.width / CGFloat(collectionView.numberOfItems(inSection: 0))
        let offsetMultiplier = round((proposedContentOffset.x + initialInsets) / offsetStep)
        let offset = offsetStep * offsetMultiplier - initialInsets
        
        return CGPoint(x: offset, y: 0)
    }
}
