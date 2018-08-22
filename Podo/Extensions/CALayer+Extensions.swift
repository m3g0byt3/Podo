//
//  CALayer+Extensions.swift
//  Podo
//
//  Created by m3g0byt3 on 22/08/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import QuartzCore

extension CALayer {

    /// `CACurrentMediaTime` in layer's time space.
    var currentTime: CFTimeInterval {
        return convertTime(CACurrentMediaTime(), from: nil)
    }
}
