//
//  Constants.swift
//  Podo
//
//  Created by m3g0byt3 on 23/11/2017.
//  Copyright © 2017 m3g0byt3. All rights reserved.
//

import UIKit

enum Constant {

    enum AnimationDuration {
        /// Normal animation duration
        static let normal: TimeInterval = 0.30
        /// Short animation duration
        static let short: TimeInterval = 0.15
    }

    enum DimmingViewAlpha {
        /// Alpha level at the beginning of presentation
        static let initial: CGFloat = 0.0
        /// Alpha level at the end of presentation
        static let final: CGFloat = 0.25
    }

    enum SideMenu {
        /// Width ratio between screen width and side menu width
        static let widthRatio: CGFloat = 0.7
        /// Boundary value to decide complete or cancel interactive transition if pan gesture has ended
        static let boundaryTransitionPercentage: CGFloat = 0.50
        /// Offset that may be added to or substracted from `boundaryTransitionPercentage` for better visual experience
        static let boundaryTransitionPercentageOffset: CGFloat = 0.05
    }

    enum MainMenu {
        /// Insets between titleView icon and its container
        static let imageInset: CGFloat = 5
        /// tableView's estimatedHeightForRowAt
        static let estimatedRowHeight: CGFloat = 75
        /// Ratio between screen height and height of CardsViewController
        static let verticalInsetRatio: CGFloat = 0.25
        /// Ratio between UICollectionViewCell height and height of UICollectionView
        static let cellHeightToSuperViewHeightRatio: CGFloat = 0.60
        /// Left and right margins in UICollectionViewCell (as set in the IB)
        static let cellLeftRightMargins: CGFloat = 8 * 2
        /// Ratio between width and height of standard sized credit cards
        static let cardViewHeightWidthRatio: CGFloat = 0.628
        /// Ratio between height of tableView and offset for bottom of CardsViewController's view
        static let tableViewToCardViewOffsetRatio: CGFloat = 0.05
        /// Offset for constraint between bottom of CardsViewController's view and bottom of UICollectionView
        static let collectionViewBottomOffset: CGFloat = -16
    }
}
