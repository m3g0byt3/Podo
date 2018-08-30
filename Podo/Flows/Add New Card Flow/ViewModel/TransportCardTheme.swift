//
//  TransportCardTheme.swift
//  Podo
//
//  Created by m3g0byt3 on 01/04/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit.UIColor

/// Represents color theme for transport card.
enum TransportCardTheme: Int {

    case green
    case red
    case orange
    case yellow
    case cyan
    case blue
    case purple
    case pink
}

extension TransportCardTheme {

    private static var alphaComponent: CGFloat = 0.5

    /// First gradient color
    var firstGradientColor: UIColor {
        switch self {
        case .green: return R.clr.podoColors.green()
        case .red: return R.clr.appleHIG.red()
        case .orange: return R.clr.appleHIG.orange()
        case .yellow: return R.clr.appleHIG.yellow()
        case .cyan: return R.clr.appleHIG.teal()
        case .blue: return R.clr.appleHIG.blue()
        case .purple: return R.clr.appleHIG.purple()
        case .pink: return R.clr.appleHIG.pink()
        }
    }

    /// Second gradient color
    var secondGradientColor: UIColor {
        return firstGradientColor.withAlphaComponent(TransportCardTheme.alphaComponent)
    }
}
