//
//  RoundShadowView.swift
//  Podo
//
//  Created by m3g0byt3 on 03/12/2017.
//  Copyright © 2017 m3g0byt3. All rights reserved.
//

import UIKit

class RoundShadowView: UIView {
    
    private struct Values {
        static let cornerRadiusRatio: CGFloat = 0.10
        static let shadowOffset = CGSize(width: 0, height: 1)
        static let shadowOpacity: Float = 0.20
        
        @available(*, unavailable) init() {}
    }
    
    override var bounds: CGRect {
        didSet {
            layer.cornerRadius = bounds.height * Values.cornerRadiusRatio
        }
    }
    
    override func awakeFromNib() {
        backgroundColor = R.clr.podoColors.white()
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = Values.shadowOffset
        layer.shadowOpacity = Values.shadowOpacity
    }
}
