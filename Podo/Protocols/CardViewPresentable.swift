//
//  CardViewPresentable.swift
//  Podo
//
//  Created by m3g0byt3 on 24/08/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit

protocol CardViewPresentable {

    var panGesture: UIPanGestureRecognizer { get }
    var screenHeightRatio: CGFloat { get }
}

extension CardViewPresentable {

    var screenHeightRatio: CGFloat { return 1.0 }
}

extension CardViewPresentable {

    func frameInPresentingView(_ view: UIView) -> CGRect {
        let topInset = view.frame.height - view.frame.height * screenHeightRatio
        let insets = UIEdgeInsets(top: topInset, left: 0, bottom: 0, right: 0)
        return view.frame.inset(by: insets)
    }
}
