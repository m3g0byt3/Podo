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
    @IBOutlet private weak var tableView: UITableView!
    private let sideMenuTransitioningDelegate = SideMenuTransitioningDelegate()
    private weak var transportCardsView: UIView?
    private lazy var tableViewDelegate = TableViewProvider()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupMiscellaneousUI()
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
    
    
    private func setupTableView() {
        let tableViewVerticalInset = view.bounds.height * MainMenu.verticalInsetRatio
        let transportCardsView = UIView()
        transportCardsView.backgroundColor = R.clr.podoColors.green()
        tableView.addSubview(transportCardsView)
        self.transportCardsView = transportCardsView
        transportCardsView.snp.makeConstraints { make in
            make.centerX.width.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.bottom.equalToSuperview().inset(-tableViewVerticalInset * MainMenu.verticalInsetRatio)
        }
        
        tableView.register(R.nib.cardsTableViewCell)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = tableViewDelegate
        tableView.delegate = self
        tableView.contentInset = UIEdgeInsets(top: tableViewVerticalInset, left: 0, bottom: 0, right: 0)
    }
    
    private func setupMiscellaneousUI() {
        let edgePanGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(edgePanHandler(_:)))
        edgePanGesture.edges = .left
        view.addGestureRecognizer(edgePanGesture)
        navigationItem.titleView = TitleView()
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return MainMenu.estimatedRowHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let transportCardsView = transportCardsView,
            let transportCardsViewIndex = tableView.subviews.index(of: transportCardsView) {
            tableView.exchangeSubview(at: 0, withSubviewAt: transportCardsViewIndex)
        }
    }
}
