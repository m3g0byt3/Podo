//
//  CardsViewController.swift
//  Podo
//
//  Created by m3g0byt3 on 09/12/2017.
//  Copyright © 2017 m3g0byt3. All rights reserved.
//

import UIKit
import SnapKit

class CardsViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    private lazy var collectionViewDatasource = СollectionViewProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.register(R.nib.cardsCollectionViewCell)
        collectionView.dataSource = collectionViewDatasource
        collectionView.backgroundColor = .clear
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().inset(MainMenu.collectionViewTopInset)
            make.height.equalToSuperview().multipliedBy(MainMenu.collectionViewHeightRatio)
        }
    }
}

extension MainViewController: UICollectionViewDelegate {
    //TODO: Add actual implementation
}
