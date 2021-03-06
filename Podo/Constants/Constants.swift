//
//  Constants.swift
//  Podo
//
//  Created by m3g0byt3 on 23/11/2017.
//  Copyright © 2017 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit

enum Constant {

    enum Flows: String {
        case tutorial
        case settings
        case topUp
        case addNewCard
        case main
    }

    enum Firebase {
        static let path = "subways"
        static let nameKey = "na"
        static let latitudeKey = "la"
        static let longitudeKey = "lo"
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

    enum ErrorDisplayDuration {
        /// Normal display duration
        static let normal: TimeInterval = 2.0
        /// Short display duration
        static let short: TimeInterval = 0.9
    }

    enum DimmingViewAlpha {
        /// Alpha level at the beginning of presentation
        static let initial: CGFloat = 0.0
        /// Alpha level at the end of presentation
        static let final: CGFloat = 0.5
    }

    enum CardView {
        static let cornerRadiusToWidthRatio: CGFloat = 15.0
        static let shadowOpacity: Float = 0.44
        static let shadowRadius: CGFloat = 13.0
        static let shadowOffset = CGSize(width: 0, height: -6)
        static let presentationDuration: TimeInterval = 0.40
        static let successHeightRatio: CGFloat = 1.0 / 2.0
        static let errorHeightRatio: CGFloat = 1.0 / 3.8
    }

    enum SideMenu {
        /// tableView's rowHeight
        static let rowHeight: CGFloat = 50.0
        /// Width ratio between screen width and side menu width
        static let widthRatio: CGFloat = 0.7
        /// Boundary value to decide complete or cancel interactive transition if pan gesture has ended
        static let boundaryTransitionPercentage: CGFloat = 0.50
        /// Offset that may be added to or substracted from `boundaryTransitionPercentage` for better visual experience
        static let boundaryTransitionPercentageOffset: CGFloat = 0.05
    }

    enum Placeholder {
        /// Placeholder from empty character ("")
        static let empty = ""
        /// Placeholder from space character (" ")
        static let space = " "
    }

    enum MainMenu {
        /// Splash screen display duration
        static let splashScreenDuration = 0.8
        /// TableView's estimatedHeightForRowAt
        static let estimatedRowHeight: CGFloat = 75.0
        /// Ratio between screen height and height of CardsViewController
        static let verticalInsetRatio: CGFloat = 0.30
        /// Ratio between UICollectionViewCell width and width of UICollectionView
        static let cellWidthToCollectionViewWidthRatio: CGFloat = 0.65
        /// Top, bottom, leading, trailing constant for UICollectionViewCell's view constraints to the superview (set in the IB)
        static let cellEdgesOffset: CGFloat = 8.0
        /// Aspect ratio for standard sized credit cards
        static let creditCardAspectRatio: CGFloat = 0.628
        /// Ratio between height of tableView and offset for bottom of CardsViewController's view
        static let tableViewToCardViewOffsetRatio: CGFloat = 0.05
        /// Offset for constraint between bottom of CardsViewController's view and bottom of UICollectionView
        static let collectionViewBottomOffset: CGFloat = -16.0
        /// Ratio between width of image from `EmptyDataSet` and view's width
        static let emptyImageWidthRatio: CGFloat = 1.0 / 3.0
        /// Ratio between verticalOffset for `EmptyDataSet` and view's height
        static let emptyVerticalOffsetRatio: CGFloat = -0.15
    }

    enum PaymentMethodsMenu {
        /// TableView's estimatedHeightForRowAt
        static let estimatedRowHeight: CGFloat = 50.0
    }

    enum CardPaymentMenu {
        /// TableView's estimatedHeightForRowAt
        static let estimatedRowHeight: CGFloat = 250.0
        /// TableView's header height
        static let headerHeight: CGFloat = 32.0
        /// TableView's footer height
        static let footerHeight: CGFloat = .leastNonzeroMagnitude
        /// Margin for cells
        static let cellMarginValue: CGFloat = 16.0
        /// Fixed sum button left/right content inset
        static let sumButtonHorizontalInset: CGFloat = 8.0
        /// Fixed sum button top/bottom content inset
        static let sumButtonVerticalInset: CGFloat = 4.0
    }
}
