//
//  SplashView.swift
//  Podo
//
//  Created by m3g0byt3 on 22/08/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit

final class SplashView: UIView {

    // MARK: - Constants

    static let fillRule = "even-odd"
    static let fillMode = "forwards"
    static let scaleKeyPath = "transform.scale"
    static let colorKeyPath = "backgroundColor"
    static let alphaValue: CGFloat = 0
    static let innerRectScale: CGFloat = 0.4
    static let outerRectScale: CGFloat = 3.0
    static let imageInset: CGFloat = -2
    static let dimmingDelayRatio = 0.3
    static let scaleToValue = 8.0
    static let scaleTiming = CAMediaTimingFunction(controlPoints: 0.3, -0.20, 0.55, 0.33)

    // MARK: - Typealias

    typealias Completion = () -> Void

    // MARK: - Private properties

    private weak var shapeMaskLayer: CALayer?
    private var dimmingToValue: UIColor?
    private var completion: Completion?
    private var duration: TimeInterval = 0
    private var dimmingDelay: TimeInterval {
        return duration * SplashView.dimmingDelayRatio
    }

    // MARK: - Initialization

    override private init(frame: CGRect) {
        super.init(frame: frame)
    }

    @available(*, unavailable, message:
    """
    This class cannot be instantiated from StoryBoard/XIB,
    use \"show(for:image:outerColor:innerColor:completion:)\" instead.
    """)
    required init?(coder aDecoder: NSCoder) {
        fatalError("This class cannot be instantiated from StoryBoard/XIB")
    }

    // MARK: - Public API

    static func show(for duration: TimeInterval,
                     image: UIImage,
                     outerColor: UIColor? = .black,
                     innerColor: UIColor? = .white,
                     completion: Completion? = nil) {

        // MARK: - Create required instances

        guard let baseRect = UIApplication.shared.keyWindow?.frame else { return }
        let maskView = UIView(frame: baseRect)
        let dimmingView = SplashView(frame: baseRect)
        let imageMaskLayer = CALayer()
        let shapeMaskLayer = CAShapeLayer()
        let innerRect = baseRect.scaledBy(dx: SplashView.innerRectScale, dy: SplashView.innerRectScale)
        let outerRect = baseRect.scaledBy(dx: SplashView.outerRectScale, dy: SplashView.outerRectScale)
        let innerPath = UIBezierPath(rect: innerRect)
        let outerPath = UIBezierPath(rect: outerRect)
        guard let shapeMaskPath = UIBezierPath(paths: outerPath, innerPath) else { return }

        // MARK: - Setup inner mask (masked by the image)

        // Small insents equal 1pt on the each side to prevent
        // some visual glithes while layer scaled animatedly
        imageMaskLayer.frame = innerRect.insetBy(dx: SplashView.imageInset, dy: SplashView.imageInset)
        imageMaskLayer.contents = image.cgImage

        // MARK: - Setup outer mask (masked by the path)

        shapeMaskLayer.frame = baseRect
        shapeMaskLayer.path = shapeMaskPath.cgPath
        shapeMaskLayer.fillRule = SplashView.fillRule
        shapeMaskLayer.addSublayer(imageMaskLayer)

        // MARK: - Setup splash view

        maskView.backgroundColor = outerColor
        maskView.layer.mask = shapeMaskLayer

        // MARK: - Setup dimming view (placed below splash view) and save required references.

        dimmingView.backgroundColor = innerColor
        dimmingView.duration = duration
        dimmingView.shapeMaskLayer = shapeMaskLayer
        dimmingView.dimmingToValue = innerColor?.withAlphaComponent(SplashView.alphaValue)
        dimmingView.completion = completion
        dimmingView.addSubview(maskView)

        // MARK: - Add view to hierarchy

        UIApplication.shared.keyWindow?.addSubview(dimmingView)
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        guard superview != nil else { return }

        // MARK: - Setup animations

        let scaleAnimation = CABasicAnimation(keyPath: SplashView.scaleKeyPath)
        scaleAnimation.toValue = SplashView.scaleToValue
        scaleAnimation.duration = duration
        scaleAnimation.timingFunction = SplashView.scaleTiming
        scaleAnimation.fillMode = SplashView.fillMode
        scaleAnimation.isRemovedOnCompletion = false

        let dimmingAnimation = CABasicAnimation(keyPath: SplashView.colorKeyPath)
        dimmingAnimation.toValue = dimmingToValue?.cgColor
        // Convert absolute time to the layer's time space
        dimmingAnimation.beginTime = layer.currentTime + dimmingDelay
        dimmingAnimation.duration = duration - dimmingDelay
        scaleAnimation.fillMode = SplashView.fillMode
        dimmingAnimation.isRemovedOnCompletion = false
        dimmingAnimation.delegate = AnimationDelegate(self, completion: completion)

        // MARK: - Apply animations

        shapeMaskLayer?.add(scaleAnimation, forKey: SplashView.scaleKeyPath)
        layer.add(dimmingAnimation, forKey: SplashView.colorKeyPath)
    }
}

/// Lightweight helper to avoid retain cycle between an `CAAnimation` instance and its delegate.
private class AnimationDelegate: NSObject, CAAnimationDelegate {

    // MARK: - Private properties

    private weak var view: UIView?
    private var completion: Completion?

    // MARK: - Initialization

    init(_ viewToRemove: UIView, completion: Completion? = nil) {
        self.view = viewToRemove
        self.completion = completion
    }

    // MARK: - CAAnimationDelegate protocol conformance

    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        view?.removeFromSuperview()
        completion?()
    }
}
