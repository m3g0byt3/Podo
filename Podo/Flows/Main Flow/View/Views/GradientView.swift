//
//  GradientView.swift
//  Podo
//
//  Created by m3g0byt3 on 06/04/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit

/**
 Gradient view with up to four gradient colors.
 */
@IBDesignable
class GradientView: UIView {
    /**
     Represents direction of the gradient.

     Raw values:
     - Left To Right = 0
     - Right To Left = 1
     - Top To Bottom = 2
     - Bottom To Top = 3
     - Top Left To Bottom Right = 4
     - Bottom Left To Top Right = 5
     - Top Right To Bottom Left = 6
     - Bottom Right To Top Left = 7
     */
    enum Direction: Int {

        fileprivate var points: (startPoint: CGPoint, endPoint: CGPoint) {
            switch self {
            case .leftToRight: return (CGPoint(x: 0, y: 0.5), CGPoint(x: 1, y: 0.5))
            case .rightToLeft: return (CGPoint(x: 1, y: 0.5), CGPoint(x: 0, y: 0.5))
            case .topToBottom: return (CGPoint(x: 0.5, y: 0), CGPoint(x: 0.5, y: 1))
            case .bottomToTop: return (CGPoint(x: 0.5, y: 1), CGPoint(x: 0.5, y: 0))
            case .topLeftToBottomRight: return (CGPoint(x: 0, y: 0), CGPoint(x: 1, y: 1))
            case .bottomLeftToTopRight: return (CGPoint(x: 0, y: 1), CGPoint(x: 1, y: 0))
            case .topRightToBottomLeft: return (CGPoint(x: 1, y: 0), CGPoint(x: 0, y: 1))
            case .bottomRightToTopLeft: return (CGPoint(x: 1, y: 1), CGPoint(x: 0, y: 0))
            }
        }

        case leftToRight
        case rightToLeft
        case topToBottom
        case bottomToTop
        case topLeftToBottomRight
        case bottomLeftToTopRight
        case topRightToBottomLeft
        case bottomRightToTopLeft
    }

    // MARK: - IBInspectables

    @IBInspectable private var firstColor: UIColor? {
        didSet {
            firstColor.map { gradientColors.append($0) }
        }
    }

    @IBInspectable private var secondColor: UIColor? {
        didSet {
            secondColor.map { gradientColors.append($0) }
        }
    }

    @IBInspectable private var thirdColor: UIColor? {
        didSet {
            thirdColor.map { gradientColors.append($0) }
        }
    }

    @IBInspectable private var fourthColor: UIColor? {
        didSet {
            fourthColor.map { gradientColors.append($0) }
        }
    }

    @IBInspectable private var gradientDirection: Int = 0 {
        didSet {
            Direction(rawValue: gradientDirection).map { direction = $0 }
        }
    }

    // MARK: - Properties

    /// Gradient direction
    var direction = Direction.leftToRight {
        didSet {
            updateGradient()
        }
    }

    /// Gradient colors
    var gradientColors = [UIColor]() {
        didSet {
            updateGradient()
        }
    }

    private var gradientLayer: CAGradientLayer {
        // swiftlint:disable:next force_cast
        return layer as! CAGradientLayer
    }

    // MARK: - Public API

    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    // MARK: - Initialization

    convenience init(frame: CGRect, colors: [UIColor], direction: Direction) {
        self.init(frame: frame)
        self.direction = direction
        self.gradientColors = colors
        updateGradient()
    }

    // MARK: - Private API

    private func updateGradient() {
        gradientLayer.startPoint = direction.points.startPoint
        gradientLayer.endPoint = direction.points.endPoint
        gradientLayer.colors = gradientColors.map { $0.cgColor }
    }
}
