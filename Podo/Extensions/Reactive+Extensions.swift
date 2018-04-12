//
//  Reactive+Extensions.swift
//  Podo
//
//  Created by m3g0byt3 on 28/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: UITextField {

    /**
     Reactive wrapper for target action pattern on `self.leftView` as `UIButton`
     */
    var leftOverlayButtonTap: ControlEvent<Void>? {
        return base.leftView.flatMap { $0 as? UIButton }?.rx.tap
    }

    /**
     Reactive wrapper for target action pattern on `self.rightView` as `UIButton`
     */
    var rightOverlayButtonTap: ControlEvent<Void>? {
        return base.rightView.flatMap { $0 as? UIButton }?.rx.tap
    }
}

extension Reactive where Base: GradientView {

    /// Bindable sink for `gradientColors` property.
    var gradientColors: Binder<[UIColor]> {
        return Binder(self.base) { view, gradientColors in
            view.gradientColors = gradientColors
        }
    }
}
