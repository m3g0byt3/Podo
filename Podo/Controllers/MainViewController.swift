//
//  MainViewController.swift
//  Podo
//
//  Created by m3g0byt3 on 23/11/2017.
//  Copyright © 2017 m3g0byt3. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: - Properties
    private let sideMenuTransitioningDelegate = SideMenuTransitioningDelegate()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = R.clr.podoColors.green()
        navigationItem.leftBarButtonItem?.tintColor = R.clr.podoColors.white()
    }
    
    //MARK: - Control handlers
    @IBAction private func showSideMenu(_ sender: UIBarButtonItem) {
        let sideMenuVC = SideMenuViewController()
        sideMenuVC.modalPresentationStyle = .custom
        sideMenuVC.transitioningDelegate = sideMenuTransitioningDelegate
        present(sideMenuVC, animated: true)
    }
}
