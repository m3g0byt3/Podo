//
//  UITextField+Extensions.swift
//  Podo
//
//  Created by m3g0byt3 on 11/07/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit

extension UITextField {

    static let performSwizzling: () -> Void = {
        try? swizzleMethod(from: #selector(becomeFirstResponder), to: #selector(swizzledBecomeFirstResponder))
        return {}
    }()

    @objc
    private func swizzledBecomeFirstResponder() -> Bool {
        print("swizzled")

        let top = topView(for: self)

        print(top)

        return swizzledBecomeFirstResponder()
    }

    private func topView(for view: UIView?) -> UIView? {
        if view?.superview is UIWindow {
            return view
        }
        return topView(for: view?.superview)
    }
}
