//
//  HelperAssembly.swift
//  Podo
//
//  Created by m3g0byt3 on 08/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit
import Swinject
import Moya
import PKHUD

final class HelperAssembly: Assembly {

    func assemble(container: Container) {

        container.register(ThemeAdapterProtocol.self) { _ in
            return ThemeAdapter()
        }

        container.register(PluginType.self) { _ in
            return NetworkActivityPlugin { change, _ in
                let isIndicatorVisible: Bool

                switch change {
                case .began:
                    HUD.show(.progress)
                    isIndicatorVisible = true
                case .ended:
                    HUD.hide()
                    isIndicatorVisible = false
                }

                UIApplication.shared.isNetworkActivityIndicatorVisible = isIndicatorVisible
            }
        }
    }
}
