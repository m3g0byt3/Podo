//
//  AppDelegateConfigurable.swift
//  Podo
//
//  Created by m3g0byt3 on 07/08/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit

protocol AppDelegateConfigurable: class {

    var rootView: UIViewController? { get }
    var rootCoordinator: Coordinator? { get set }
}
