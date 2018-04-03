//
//  ScanCardTextField.swift
//  Podo
//
//  Created by m3g0byt3 on 28/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit

@IBDesignable
final class ScanCardTextField: UITextField {

    // MARK: - Properties

    private static let overlayViewOffset: CGFloat = 4

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: - Public API

    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let initialRect = super.rightViewRect(forBounds: bounds)
        let offset: CGFloat = type(of: self).overlayViewOffset
        let size = CGSize(width: bounds.height - offset, height: bounds.height - offset)
        return CGRect(origin: initialRect.origin, size: size)
    }

    // MARK: - Private API

    private func setup() {
        let button = UIButton(type: .custom)
        button.setImage(R.image.scanCard(), for: .normal)
        rightView = button
        rightViewMode = .always
    }
}
