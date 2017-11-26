//
//  UIViewController+horizontalContentLayoutOffset.swift
//  Podo
//
//  Created by m3g0byt3 on 26/11/2017.
//  Copyright © 2017 m3g0byt3. All rights reserved.
//

import UIKit

extension UIViewController {
    
    open var horizontalContentLayoutOffset: CGFloat {
        
        get {
            return view.frame.origin.x
        }
        
        set {
            navigationController?.navigationBar.frame.origin.x += newValue
            navigationController?.toolbar.frame.origin.x += newValue
            view.frame.origin.x += newValue
        }
    }
}
