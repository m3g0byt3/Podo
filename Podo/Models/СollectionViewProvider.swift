//
//  СollectionViewProvider.swift
//  Podo
//
//  Created by m3g0byt3 on 07/12/2017.
//  Copyright © 2017 m3g0byt3. All rights reserved.
//

import UIKit

final class СollectionViewProvider: NSObject {
    // TODO: Add actual implementation
}

// MARK: - UICollectionViewDataSource protocol conformance
extension СollectionViewProvider: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // TODO: Add actual implementation
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // TODO: Add actual implementation
        return collectionView.dequeueReusableCell(withReuseIdentifier: R.nib.cardsCollectionViewCell.identifier, for: indexPath)
    }
}
