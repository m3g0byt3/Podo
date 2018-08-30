//
//  ThemeAdapter.swift
//  Podo
//
//  Created by m3g0byt3 on 08/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

final class ThemeAdapter: ThemeAdapterProtocol {

    // MARK: - ThemeAdapterProtocol protocol conformance

    var currentTheme: Theme = .light

    func changeTheme(_ theme: Theme) {}
}
