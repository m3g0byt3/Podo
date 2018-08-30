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

    /// Appends the layer to the layer’s list of sublayers only
    /// if the given layer not yet added to the layer’s list of sublayers.
    /// - parameter layer: The layer to be added.
    func addSublayerIfNotContains(_ layer: CALayer) {
        if let sublayers = sublayers {
            guard !sublayers.contains(layer) else { return }
            addSublayer(layer)
        } else {
            addSublayer(layer)
        }
    }
}
