//
//  UIResponder+Extensions.swift
//  Podo
//
//  Created by m3g0byt3 on 17/07/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit

extension UIResponder {

    // MARK: - Public API

    /// Represent current First Responder, if any.
    static var current: UIResponder? {
        UIResponder._current = nil
        UIApplication.shared.sendAction(#selector(setFirstResponder), to: nil, from: nil, for: nil)

        return UIResponder._current
    }

    // MARK: - Private API

    private weak static var _current: UIResponder?

    @objc private func setFirstResponder() {
        UIResponder._current = self
    }
}
