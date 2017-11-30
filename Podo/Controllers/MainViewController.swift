//
//  MainViewController.swift
//  Podo
//
//  Created by m3g0byt3 on 23/11/2017.
//  Copyright © 2017 m3g0byt3. All rights reserved.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    //MARK: - Properties
    private let sideMenuTransitioningDelegate = SideMenuTransitioningDelegate()
    
    private lazy var squareView: UIView = { this in
        this.backgroundColor = R.clr.podoColors.blue()
        return this
    }(UIView())
    
    private lazy var edgePanGesture: UIScreenEdgePanGestureRecognizer = { this in
        this.edges = .left
        return this
    }(UIScreenEdgePanGestureRecognizer(target: self, action: #selector(edgePanHandler(_:))))
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = R.clr.podoColors.green()
        navigationItem.leftBarButtonItem?.tintColor = R.clr.podoColors.white()
        
        view.addGestureRecognizer(edgePanGesture)
        view.addSubview(squareView)
        squareView.snp.makeConstraints { make in
            make.size.equalToSuperview().multipliedBy(0.5)
            make.center.equalToSuperview()
        }
    }
    
    //MARK: - Control handlers
    @IBAction private func sideMenuButtonHandler(_ sender: UIBarButtonItem) {
        showSideMenu()
    }
    
    @objc private func edgePanHandler(_ sender: UIScreenEdgePanGestureRecognizer) {
        switch sender.state {
        case .began:
            showSideMenu()
        default:
            sideMenuTransitioningDelegate.interactorClosure?(sender)
        }
    }
    
    //MARK: - Private API
    private func showSideMenu() {
        let sideMenuVC = SideMenuViewController.navigationControllerInstance()
        sideMenuVC.modalPresentationStyle = .custom
        sideMenuVC.transitioningDelegate = sideMenuTransitioningDelegate
        present(sideMenuVC, animated: true)
    }
}
