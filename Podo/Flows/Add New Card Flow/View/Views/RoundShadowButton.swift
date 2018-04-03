//
//  RoundShadowButton.swift
//  Podo
//
//  Created by m3g0byt3 on 01/04/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit

@IBDesignable
final class RoundShadowButton: UIButton {

    // MARK: - Constants

    private static let heightToCornerRadiusRatio: CGFloat = 0.15
    private static let shadowOffset = CGSize(width: 0, height: 1.5)
    private static let shadowOpacity: Float = 0.5

    // MARK: - Properties

    @IBInspectable
    var heightToCornerRadiusRatio: CGFloat = RoundShadowButton.heightToCornerRadiusRatio {
        didSet {
            layer.cornerRadius = bounds.height * heightToCornerRadiusRatio
        }
    }

    @IBInspectable
    var shadowOffset: CGSize = RoundShadowButton.shadowOffset {
        didSet {
            layer.shadowOffset = shadowOffset
        }
    }

    @IBInspectable
    var shadowOpacity: Float = RoundShadowButton.shadowOpacity {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }

    // MARK: - Public API

    override var bounds: CGRect {
        didSet {
            layer.cornerRadius = bounds.height * heightToCornerRadiusRatio
        }
    }

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
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
    }
}
