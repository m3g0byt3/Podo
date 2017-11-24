//
//  SideMenuViewController.swift
//  Podo
//
//  Created by m3g0byt3 on 23/11/2017.
//  Copyright © 2017 m3g0byt3. All rights reserved.
//

import UIKit
import SnapKit

class SideMenuViewController: UIViewController {

    //MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler(_:)))
        view.addGestureRecognizer(tapGesture)
        view.backgroundColor = R.clr.podoColors.blue()
    }
    
    //MARK: - Control handlers
    @objc private func tapGestureHandler(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true)
    }
}
