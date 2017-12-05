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
    private lazy var edgePanGesture: UIScreenEdgePanGestureRecognizer = { this in
        this.edges = .left
        return this
    }(UIScreenEdgePanGestureRecognizer(target: self, action: #selector(edgePanHandler(_:))))

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        setupTableView()
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
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = R.clr.podoColors.green()
        navigationItem.leftBarButtonItem?.tintColor = R.clr.podoColors.white()
        
        guard let navBarHeight = navigationController?.navigationBar.frame.height else { return }
        
        let titleViewContainerFrame = CGRect(x: 0, y: 0, width: navBarHeight, height: navBarHeight)
        let titleImageView = UIImageView(image: R.image.metroTrainIcon())
        titleImageView.contentMode = .scaleAspectFit
        navigationItem.titleView = UIView(frame: titleViewContainerFrame)
        navigationItem.titleView?.addSubview(titleImageView)
        titleImageView.snp.makeConstraints { $0.edges.equalToSuperview().inset(MainMenu.imageInset) }
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
