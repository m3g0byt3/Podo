//
//  InteractiveTransitioningCapable.swift
//  Podo
//
//  Created by m3g0byt3 on 12/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit

/// Object that can initiate and update interactive transitions (presentation/dismissal).
protocol InteractiveTransitioningCapable: class {

    var isTransitionInteractive: Bool { get set }
    var onInteractiveTransition: ((UIPanGestureRecognizer) -> Void)? { get set }
}
