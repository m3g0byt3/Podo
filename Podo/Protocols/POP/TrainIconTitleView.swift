//
//  TrainIconTitleView.swift
//  Podo
//
//  Created by m3g0byt3 on 25/04/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit

/**
 `UIViewController` instance with `TrainIconView` set as `UINavigationItem's titleView`
 */
protocol TrainIconTitleView: NavigationBarTitleViewCustomizable {}

extension TrainIconTitleView {

    var titleView: UIView {
        return TrainIconView()
    }
}
