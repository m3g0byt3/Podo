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

    func presentError(title: String?, message: String?, completion: Completion?) {
        UIResponder.current?.resignFirstResponder()
        HUD.allowsInteraction = true
        HUD.flash(.labeledError(title: title, subtitle: message), delay: Constant.ErrorDisplayDuration.normal) { _ in
            completion?()
        }
    }

    func presentProgress(title: String?, completion: Completion?) {
        UIResponder.current?.resignFirstResponder()
        HUD.allowsInteraction = false
        HUD.show(.labeledProgress(title: title, subtitle: nil))
        completion?()
    }

    func dismiss() {
        HUD.hide()
    }
}
