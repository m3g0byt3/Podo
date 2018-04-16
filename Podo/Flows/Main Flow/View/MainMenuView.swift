//
//  MainMenuView.swift
//  Podo
//
//  Created by m3g0byt3 on 28/02/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

typealias MainMenuView = MainMenuParentView & MainMenuChildView

protocol MainMenuParentView: View, InteractiveTransitioningCapable, SideMenuPresenting {}

protocol MainMenuChildView: View {

    var onAddNewCardSelection: Completion? { get set }
    var onCardSelection: ((CardsCellViewModel) -> Void)? { get set }
}
