//
//  View.swift
//  Podo
//
//  Created by m3g0byt3 on 05/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit

protocol View {

    var presentableEntity: UIViewController? { get }
}

extension View where Self: UIViewController {

    var presentableEntity: UIViewController? {
        return self
    }
}
