//
//  MarkView.swift
//  SuccessFailMark
//
//  Created by m3g0byt3 on 25/08/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
final class MarkView: UIView {

    // MARK: - Typealiases

    typealias AnimationParameters = (damping: CGFloat, initialVelocity: CGFloat, stiffness: CGFloat)

    // MARK: - Types

    enum MarkType {

        case success
        case fail
    }

    // MARK: - Constants

    private static let circleKeyPath = "circle animation"
    private static let markKeyPath = "mark animation"
    private static let markOffsetMultiplier: CGFloat = 0.1
    private static let fillColor: UIColor = .clear
    private static let startAngle: CGFloat = 0.0
    private static let endAngle: CGFloat = .pi * 2.0
    private static let fromValue: CGFloat = 0.0
    private static let toValue: CGFloat = 1.0
    private static let parameters: AnimationParameters = (8.0, -50.0, 150.0)

    // MARK: - Public properties

    @IBInspectable
    var isFailed: Bool = false

    @IBInspectable
    var duration: Double = 0.3

    @IBInspectable
    var color: UIColor = .green

    @IBInspectable
    lazy var lineWidth: CGFloat = bounds.width / 12.5

    // MARK: - Private properties

    private var markType: MarkType {
        return isFailed ? .fail : .success
    }

    private var radius: CGFloat {
        return bounds.width / 2 - lineWidth / 2
    }

    private var convertedCenter: CGPoint {
        return convert(center, from: superview)
    }

    private var markRectMultiplier: CGFloat {
        switch markType {
        case .success: return 1 / 2
        case .fail: return 1 / 1.7
        }
    }

    private var markRect: CGRect {
        let rect = bounds.insetBy(dx: (bounds.width - radius) * markRectMultiplier,
                                  dy: (bounds.height - radius) * markRectMultiplier)
        return rect.isEmpty ? .zero : rect
    }

    private weak var circleLayer: CAShapeLayer?

    private weak var markLayer: CAShapeLayer?

    // MARK: - Overrides

    override func layoutSubviews() {
        super.layoutSubviews()
        // Update frame and path for circleLayer
        circleLayer?.frame = bounds
        drawCircle(in: circleLayer, animated: false)
        // Update frame and path for markLayer
        markLayer?.frame = bounds
        switch markType {
        case .success: drawSuccessMark(in: markLayer, animated: false)
        case .fail: drawFailMark(in: markLayer, animated: false)
        }
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        // Do not draw if removed from superview
        guard superview != nil else { return }
        // Draw on the next run loop cycle to prevent race condition when IBInspectables not set yet
        DispatchQueue.main.async {
            self.createCircle()
            self.createMark()
        }
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        createCircle()
        createMark()
    }

    // MARK: - Private API

    private func createCircle() {
        let circleLayer = CAShapeLayer()
        circleLayer.frame = bounds
        layer.addSublayer(circleLayer)
        drawCircle(in: circleLayer, animated: true)
        self.circleLayer = circleLayer
    }

    private func createMark() {
        let markLayer = CAShapeLayer()
        markLayer.frame = bounds
        layer.addSublayer(markLayer)
        switch markType {
        case .success: drawSuccessMark(in: markLayer, animated: true)
        case .fail: drawFailMark(in: markLayer, animated: true)
        }
        self.markLayer = markLayer
    }

    private func drawCircle(in layer: CAShapeLayer?, animated: Bool) {
        let circlePath = UIBezierPath(arcCenter: convertedCenter,
                                      radius: radius,
                                      startAngle: type(of: self).startAngle,
                                      endAngle: type(of: self).endAngle,
                                      clockwise: true)

        layer?.lineWidth = lineWidth
        layer?.path = circlePath.cgPath
        layer?.fillColor = type(of: self).fillColor.cgColor
        layer?.strokeColor = color.cgColor

        if animated {
            let circleAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
            circleAnimation.fromValue = type(of: self).fromValue
            circleAnimation.toValue = type(of: self).toValue
            circleAnimation.duration = duration
            circleAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)

            layer?.add(circleAnimation, forKey: type(of: self).circleKeyPath)
        }
    }

    private func drawSuccessMark(in layer: CAShapeLayer?, animated: Bool) {
        let path = UIBezierPath()
        let xOffset = markRect.width * type(of: self).markOffsetMultiplier
        let yOffset = markRect.height * type(of: self).markOffsetMultiplier
        path.move(to: CGPoint(x: markRect.minX, y: markRect.midY) )
        path.addLine(to: CGPoint(x: markRect.midX - xOffset, y: markRect.maxY - yOffset))
        path.addLine(to: CGPoint(x: markRect.maxX, y: markRect.minY + yOffset))

        layer?.lineWidth = lineWidth
        layer?.path = path.cgPath
        layer?.fillColor = type(of: self).fillColor.cgColor
        layer?.strokeColor = color.cgColor
        layer?.lineCap = kCALineCapButt

        if animated {
            let animation = CASpringAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
            animation.fromValue = type(of: self).fromValue
            animation.toValue = type(of: self).toValue
            animation.damping = type(of: self).parameters.damping
            animation.initialVelocity = type(of: self).parameters.initialVelocity
            animation.stiffness = type(of: self).parameters.stiffness
            animation.duration = max(animation.settlingDuration, duration)

            layer?.add(animation, forKey: type(of: self).markKeyPath)
        }
    }

    private func drawFailMark(in layer: CAShapeLayer?, animated: Bool) {
        let markRectEndings = [CGPoint(x: markRect.minX, y: markRect.minY),
                               CGPoint(x: markRect.maxX, y: markRect.maxY),
                               CGPoint(x: markRect.maxX, y: markRect.minY),
                               CGPoint(x: markRect.minX, y: markRect.maxY)]

        for (index, ending) in markRectEndings.enumerated() {
            let path = UIBezierPath()
            path.move(to: convertedCenter)
            path.addLine(to: ending)

            let sublayer = layer?.sublayers?[safe: index] as? CAShapeLayer ?? CAShapeLayer()
            sublayer.lineWidth = lineWidth
            sublayer.fillColor = type(of: self).fillColor.cgColor
            sublayer.strokeColor = color.cgColor
            sublayer.lineCap = kCALineCapButt
            sublayer.path = path.cgPath

            layer?.addSublayerIfNotContains(sublayer)

            if animated {
                let animation = CASpringAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
                animation.fromValue = type(of: self).fromValue
                animation.toValue = type(of: self).toValue
                animation.damping = type(of: self).parameters.damping
                animation.initialVelocity = type(of: self).parameters.initialVelocity
                animation.stiffness = type(of: self).parameters.stiffness
                animation.duration = animation.settlingDuration

                sublayer.add(animation, forKey: type(of: self).markKeyPath)
            }
        }
    }
}
