//
//  SettingsView.swift
//  Podo
//
//  Created by m3g0byt3 on 18/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

protocol SettingsView: View, SideMenuPresenting, InteractiveTransitioningCapable {

    var onClose: Completion? { get set }
}
