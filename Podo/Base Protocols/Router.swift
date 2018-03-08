//
//  Router.swift
//  Podo
//
//  Created by m3g0byt3 on 04/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

typealias Completion = (() -> Void)

protocol Router {

    // Presentation
    func present(_ view: View, animated: Bool, completion: Completion?)
    func push(_ view: View, animated: Bool)

    // Dismissal
    func dismiss(animated: Bool, completion: Completion?)
    func pop(animated: Bool)
}
