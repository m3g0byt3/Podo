//
//  UIBezierPath+Extensions.swift
//  Podo
//
//  Created by m3g0byt3 on 22/08/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit

extension UIBezierPath {

    /// Create an `UIBezierPath` instance by combining multiple paths.
    /// - parameter paths: `UIBezierPath` instances.
    /// - returns: Combined `UIBezierPath` or nil, if no paths provided.
    convenience init?(paths: UIBezierPath...) {
        guard let summaryPath = paths.first else { return nil }
        paths.dropFirst().forEach(summaryPath.append)
        self.init(cgPath: summaryPath.cgPath)
    }
}
