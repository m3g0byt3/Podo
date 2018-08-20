//
//  ThemeAdapterProtocol.swift
//  Podo
//
//  Created by m3g0byt3 on 08/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit

enum Theme {

    case light, dark
}

protocol ThemeAdapterProtocol {

    var currentTheme: Theme { get set }

    func appearanceSetup()
    func changeTheme(_ theme: Theme)
}

extension ThemeAdapterProtocol {

    func appearanceSetup() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().barStyle = .black
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = R.clr.podoColors.green()
        UINavigationBar.appearance().tintColor = R.clr.podoColors.white()
        UIBarButtonItem.appearance().tintColor = R.clr.podoColors.white()
    }
}
