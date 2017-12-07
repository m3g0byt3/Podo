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
        let identifier = "com.m3g0byt3.safeAreaLayoutGuide"
        // Early exit if we're on iOS 11.x
        if #available(iOS 11, *) {
            return view.safeAreaLayoutGuide
        }
        // Early exit if we already have layoutGuide
        if let layoutGuide = view.layoutGuides.first(where: { $0.identifier == identifier}) {
            return layoutGuide
        }
        // Create new layoutGuide
        let layoutGuide = UILayoutGuide()
        layoutGuide.identifier = identifier
        view.addLayoutGuide(layoutGuide)
        NSLayoutConstraint.activate([layoutGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     layoutGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     layoutGuide.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
                                     layoutGuide.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor)])
        return layoutGuide
    }
}
