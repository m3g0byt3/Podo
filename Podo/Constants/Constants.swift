//
//  Constants.swift
//  Podo
//
//  Created by m3g0byt3 on 23/11/2017.
//  Copyright © 2017 m3g0byt3. All rights reserved.
//

import UIKit

enum Constant {

    enum Flows: String {
        case tutorial
        case settings
        case topUp
        case addNewCard
        case main
    }

    enum AnimationDuration {
        /// Normal animation duration
        static let normal: TimeInterval = 0.30
        /// Short animation duration
        static let short: TimeInterval = 0.15
    }

    enum ThrottleDuration {
        /// Throttle duration for UIButton
        static let button: TimeInterval = 1.0
        /// Throttle duration for UITextField
        static let textField: TimeInterval = 0.3
    }

    enum DimmingViewAlpha {
        /// Alpha level at the beginning of presentation
        static let initial: CGFloat = 0.0
        /// Alpha level at the end of presentation
        static let final: CGFloat = 0.5
    }

    enum SideMenu {
        /// tableView's rowHeight
        static let rowHeight: CGFloat = 50
        /// Width ratio between screen width and side menu width
        static let widthRatio: CGFloat = 0.7
        /// Boundary value to decide complete or cancel interactive transition if pan gesture has ended
        static let boundaryTransitionPercentage: CGFloat = 0.50
        /// Offset that may be added to or substracted from `boundaryTransitionPercentage` for better visual experience
        static let boundaryTransitionPercentageOffset: CGFloat = 0.05
    }

    enum MainMenu {
        /// TableView's estimatedHeightForRowAt
        static let estimatedRowHeight: CGFloat = 75
        /// Ratio between screen height and height of CardsViewController
        static let verticalInsetRatio: CGFloat = 0.25
        /// Ratio between UICollectionViewCell width and width of UICollectionView
        static let cellWidthToCollectionViewWidthRatio: CGFloat = 0.65
        /// Top, bottom, leading, trailing constant for UICollectionViewCell's view constraints to the superview (set in the IB)
        static let cellEdgesOffset: CGFloat = 8
        /// Aspect ratio for standard sized credit cards
        static let creditCardAspectRatio: CGFloat = 0.628
        /// Ratio between height of tableView and offset for bottom of CardsViewController's view
        static let tableViewToCardViewOffsetRatio: CGFloat = 0.05
        /// Offset for constraint between bottom of CardsViewController's view and bottom of UICollectionView
        static let collectionViewBottomOffset: CGFloat = -16
        /// Ratio between width of image from `EmptyDataSet` and view's width
        static let emptyImageWidthRatio: CGFloat = 1 / 3
        /// Ratio between verticalOffset for `EmptyDataSet` and view's height
        static let emptyVerticalOffsetRatio: CGFloat = -0.15
    }

    enum TopUpMenu {
        /// TableView's estimatedHeightForRowAt
        static let estimatedRowHeight: CGFloat = 50
    }

    enum CardPaymentMenu {
        /// TableView's estimatedHeightForRowAt
        static let estimatedRowHeight: CGFloat = 250
        /// TableView's header height
        static let headerHeight: CGFloat = 32
        /// TableView's footer height
        static let footerHeight: CGFloat = .leastNonzeroMagnitude
        /// Margin for cells
        static let cellMarginValue: CGFloat = 16
    }
}
