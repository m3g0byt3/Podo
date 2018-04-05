//
//  CheckMarkView.swift
//  Podo
//
//  Created by m3g0byt3 on 20/02/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit

@IBDesignable
final class CheckMarkView: UIView {

    // MARK: - Public API

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        let context = UIGraphicsGetCurrentContext()
        let lineWidth: CGFloat = 2
        let rightMargin: CGFloat = 3
        let checkMarkRadius: CGFloat = 7
        let xCoord = bounds.maxX - rightMargin
        let yCoord = bounds.midY

        context?.setLineWidth(lineWidth)
        context?.setLineCap(.round)
        context?.setLineJoin(.round)
        context?.move(to: CGPoint(x: xCoord - checkMarkRadius, y: yCoord - checkMarkRadius))
        context?.addLine(to: CGPoint(x: xCoord, y: yCoord))
        context?.addLine(to: CGPoint(x: xCoord - checkMarkRadius, y: yCoord + checkMarkRadius))
        context?.setStrokeColor(R.clr.podoColors.white().cgColor)
        context?.strokePath()
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
        backgroundColor = UIColor.clear
    }
}
