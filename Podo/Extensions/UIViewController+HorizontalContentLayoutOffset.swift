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
            view.frame.origin.x += newValue
            navigationController?.navigationBar.frame.origin.x += newValue
            // Change toolBar origin only if it isn't hidden, or it will be misplaced
            if let isToolbarHidden = navigationController?.isToolbarHidden, !isToolbarHidden {
                navigationController?.toolbar?.frame.origin.x += newValue
            }
        }
    }
}
