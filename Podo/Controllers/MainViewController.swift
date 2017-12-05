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
    
    private lazy var tableViewDelegate = TableViewProvider()
    private lazy var edgePanGesture: UIScreenEdgePanGestureRecognizer = { this in
        this.edges = .left
        return this
    }(UIScreenEdgePanGestureRecognizer(target: self, action: #selector(edgePanHandler(_:))))
    
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            setupTableView()
        }
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        view.addGestureRecognizer(edgePanGesture)
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
    
    private func setupNavigationItem() {
        let titleViewContainer = UIView()
        let titleView = UIImageView(image: R.image.metroTrainIcon())
        titleViewContainer.addSubview(titleView)
        titleView.contentMode = .scaleAspectFit
        titleView.snp.makeConstraints { $0.edges.equalToSuperview().inset(3) }

        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = R.clr.podoColors.green()
        navigationItem.leftBarButtonItem?.tintColor = R.clr.podoColors.white()
        navigationItem.titleView = titleViewContainer
    }
    
    private func setupTableView() {
        tableView.register(R.nib.cardsTableViewCell)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.dataSource = tableViewDelegate
        tableView.backgroundColor = R.clr.podoColors.background()
    }
}
