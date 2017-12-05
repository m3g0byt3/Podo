//
//  UIViewController+SafeAreaLayoutGuide.swift
//  Podo
//
//  Created by m3g0byt3 on 05/12/2017.
//  Copyright © 2017 m3g0byt3. All rights reserved.
//

import UIKit

@available(iOS 9, *)
public extension UIViewController {
    
    var safeAreaLayoutGuide: UILayoutGuide {
        
        if #available(iOS 11, *) { return view.safeAreaLayoutGuide }
        
        let layoutGuide = UILayoutGuide()
        view.addLayoutGuide(layoutGuide)
        NSLayoutConstraint.activate([layoutGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     layoutGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     layoutGuide.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
                                     layoutGuide.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor)])
        return layoutGuide
    }
}
