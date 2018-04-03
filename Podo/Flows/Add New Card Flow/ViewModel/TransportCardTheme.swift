//
//  TransportCardTheme.swift
//  Podo
//
//  Created by m3g0byt3 on 01/04/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit.UIColor

/**
 Represents color theme for transport card.
 */
enum TransportCardTheme: Int {

    case white
    case red
    case orange
    case yellow
    case cyan
    case blue
    case purple
    case pink
}

extension TransportCardTheme {

    /// First gradient color
    var firstGradientColor: UIColor {
        // TODO: Add actual implementation
        switch self {
        case .white: return .white
        case .red: return .red
        case .orange: return .orange
        case .yellow: return .yellow
        case .cyan: return .cyan
        case .blue: return .blue
        case .purple: return .purple
        case .pink: return .magenta
        }
    }

    /// Second gradient color
    var secondGradientColor: UIColor {
        // TODO: Add actual implementation
        switch self {
        case .white: return .white
        case .red: return .red
        case .orange: return .orange
        case .yellow: return .yellow
        case .cyan: return .cyan
        case .blue: return .blue
        case .purple: return .purple
        case .pink: return .magenta
        }
    }
}
