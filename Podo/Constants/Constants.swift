//
//  Constants.swift
//  Podo
//
//  Created by m3g0byt3 on 23/11/2017.
//  Copyright © 2017 m3g0byt3. All rights reserved.
//

import UIKit

struct AnimationDuration {
    static let normal: TimeInterval = 0.30
    static let short: TimeInterval = 0.15
    
    @available(*, unavailable) init() {}
}

struct DimmingViewAlpha {
    /// Alpha level at the beginning of presentation
    static let initial: CGFloat = 0.0
    /// Alpha level at the end of presentation
    static let final: CGFloat = 0.25
    
    @available(*, unavailable) init() {}
}

struct SideMenu {
    /// Width ratio between screen width and side menu width
    static let widthRatio: CGFloat = 0.7
    /// Boundary value to decide complete or cancel interactive transition if pan gesture has ended
    static let boundaryTransitionPercentage: CGFloat = 0.50
    // Offset that may be added to or substracted from `boundaryTransitionPercentage` for better visual experience
    static let boundaryTransitionPercentageOffset: CGFloat = 0.05
    
    @available(*, unavailable) init() {}
}

struct MainMenu {
    /// Insets between titleView icon and its container
    static let imageInset: CGFloat = 5
    /// tableView's estimatedHeightForRowAt
    static let estimatedRowHeight: CGFloat = 75
    /// Ratio between screen height and height of transportCardsView
    static let verticalInsetRatio: CGFloat = 0.25
    
    @available(*, unavailable) init() {}
}
