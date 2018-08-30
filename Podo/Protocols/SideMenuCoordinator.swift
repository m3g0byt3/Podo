//
//  SideMenuCoordinator.swift
//  Podo
//
//  Created by m3g0byt3 on 15/04/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

/// Represents `Coordinator` instance that can handle side menu requests from its view.
protocol SideMenuCoordinator: Coordinator {

    var onSideMenuFlowStart: Completion? { get set }
}
