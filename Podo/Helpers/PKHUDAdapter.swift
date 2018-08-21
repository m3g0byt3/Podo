//
//  PKHUDAdapter.swift
//  Podo
//
//  Created by m3g0byt3 on 20/08/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import PKHUD

final class PKHUDAdapter: ErrorAdapterProtocol {

    // MARK: - Initialization

    init() {
        HUD.dimsBackground = true
    }

    // MARK: - ErrorAdapterProtocol protocol conformance

    func presentError(title: String?, message: String?) {
        UIResponder.current?.resignFirstResponder()
        HUD.flash(.labeledError(title: title, subtitle: message),
                  delay: Constant.ErrorDisplayDuration.normal)
    }

    func presentProgress(title: String?) {
        UIResponder.current?.resignFirstResponder()
        HUD.show(.labeledProgress(title: title, subtitle: nil))
    }

    func dismiss() {
        HUD.hide()
    }
}
