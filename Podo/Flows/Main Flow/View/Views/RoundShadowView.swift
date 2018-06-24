//
//  RoundShadowView.swift
//  Podo
//
//  Created by m3g0byt3 on 03/12/2017.
//  Copyright © 2017 m3g0byt3. All rights reserved.
//

import UIKit

@IBDesignable
class RoundShadowView: GradientView {

    // MARK: - Constants

    private static let heightToCornerRadiusRatio: CGFloat = 0.1
    private static let shadowOffset = CGSize(width: 0, height: 1.5)
    private static let shadowOpacity: Float = 1 / 3
    private static let shadowRadius: CGFloat = 3.0
    private static let shadowColor: UIColor = .black

    // MARK: - Properties

    @IBInspectable
    var heightToCornerRadiusRatio: CGFloat = RoundShadowView.heightToCornerRadiusRatio {
        didSet {
            layer.cornerRadius = bounds.height * heightToCornerRadiusRatio
        }
    }

    @IBInspectable
    var shadowOffset: CGSize = RoundShadowView.shadowOffset {
        didSet {
            layer.shadowOffset = shadowOffset
        }
    }

    @IBInspectable
    var shadowOpacity: Float = RoundShadowView.shadowOpacity {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }

    @IBInspectable
    var shadowRadius: CGFloat = RoundShadowView.shadowRadius {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }

    @IBInspectable
    var shadowColor: UIColor = RoundShadowView.shadowColor {
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
    }

    // MARK: - Public API

    override var bounds: CGRect {
        didSet {
            layer.cornerRadius = bounds.height * heightToCornerRadiusRatio
        }
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: - Private API

    private func setup() {
        layer.masksToBounds = false
        layer.cornerRadius = frame.height * heightToCornerRadiusRatio
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
}
