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
        case .white: return R.clr.podoColors.white()
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
        // TODO: Add actual implementation
        switch self {
        case .white: return R.clr.podoColors.white()
        case .red: return R.clr.appleHIG.red()
        case .orange: return R.clr.appleHIG.orange()
        case .yellow: return R.clr.appleHIG.yellow()
        case .cyan: return R.clr.appleHIG.teal()
        case .blue: return R.clr.appleHIG.blue()
        case .purple: return R.clr.appleHIG.purple()
        case .pink: return R.clr.appleHIG.pink()
        }
    }
}
