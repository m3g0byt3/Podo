//
//  SideMenuPresentationController.swift
//  Podo
//
//  Created by m3g0byt3 on 24/11/2017.
//  Copyright © 2017 m3g0byt3. All rights reserved.
//

import UIKit

class SideMenuPresentationController: UIPresentationController {
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let container = containerView else { return UIScreen.main.bounds }
        
        return CGRect(x: 0, y: 0, width: container.frame.width * SideMenu.widthRatio,
                      height: container.frame.height)
    }
    
    override func presentationTransitionWillBegin() {
        //TODO: Add some code here
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        //TODO: Add some code here
    }
    
    override func dismissalTransitionWillBegin() {
        //TODO: Add some code here
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        //TODO: Add some code here
    }
}
