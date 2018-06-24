//
//  CustomMargin.swift
//  Podo
//
//  Created by m3g0byt3 on 24/06/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import struct UIKit.CGFloat

protocol CustomMargin: Customizable {

    var marginMultiplier: CGFloat { get }
}

protocol DoubleMargin: CustomMargin {}

extension DoubleMargin {

    var marginMultiplier: CGFloat { return 2.0 }
}
