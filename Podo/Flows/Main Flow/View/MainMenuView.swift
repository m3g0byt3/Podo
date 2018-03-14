//
//  MainMenuView.swift
//  Podo
//
//  Created by m3g0byt3 on 28/02/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

protocol MainMenuView: View {

    var onSideMenuSelection: Completion? { get set }
    var onAddNewCardSelection: Completion? { get set }
    // TODO: Replace `Any` with actual view-model class
    var onCardSelection: ((Any) -> Void)? { get set }
}
