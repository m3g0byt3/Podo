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
    
    //MARK: - Properties
    private lazy var squareView: UIView = { this in
        this.backgroundColor = R.clr.podoColors.orange()
        return this
    }(UIView())
    
    //MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = R.clr.podoColors.green()
        
        view.addSubview(squareView)
        squareView.snp.makeConstraints { make in
            make.size.equalToSuperview().dividedBy(2)
            make.center.equalToSuperview()
        }
    }
}
