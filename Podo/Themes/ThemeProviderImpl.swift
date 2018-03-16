//
//  ThemeProviderImpl.swift
//  Podo
//
//  Created by m3g0byt3 on 08/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

final class ThemeProviderImpl: ThemeProvider {

    // MARK: - Properties

    var currentTheme: Theme = .light

    // MARK: - Public API

    func changeTheme(_ theme: Theme) {}
}
