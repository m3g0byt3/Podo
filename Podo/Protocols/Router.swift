//
//  Router.swift
//  Podo
//
//  Created by m3g0byt3 on 04/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

protocol Router: class {

    // Presentation
    func setRootView(_ view: View, animated: Bool, fullscreen: Bool)
    func present(_ view: View, animated: Bool, completion: Completion?)
    func push(_ view: View, animated: Bool)

    // Dismissal
    func dismiss(animated: Bool, completion: Completion?)
    func popToRootView(animated: Bool)
    func pop(animated: Bool)
}
