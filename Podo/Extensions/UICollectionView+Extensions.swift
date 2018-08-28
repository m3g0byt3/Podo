//
//  UICollectionView+Extensions.swift
//  Podo
//
//  Created by m3g0byt3 on 28/08/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {

    typealias Axis = UICollectionView.ScrollDirection

    /// Current row (based on `.contentOffset` property) in collection view's section along given axis.
    /// - parameters:
    ///     - section: Collection view's section.
    ///     - axis: Axis.
    /// - returns: Current row in section along given axis.
    func currentRow(inSection section: Int, alongAxis axis: Axis) -> Int {
        let numberOfItems = self.numberOfItems(inSection: section)
        let contentOffsetAlongAxis: CGFloat
        let contentSizeAlongAxis: CGFloat
        let insetAlongAxis: CGFloat

        switch axis {
        case .horizontal:
            contentSizeAlongAxis = contentSize.width
            insetAlongAxis = contentInset.left
            contentOffsetAlongAxis = contentOffset.x
        case .vertical:
            contentSizeAlongAxis = contentSize.height
            insetAlongAxis = contentInset.top
            contentOffsetAlongAxis = contentOffset.y
        }

        guard numberOfItems > 0, contentSizeAlongAxis > 0 else { return 0 }

        let widthPerItem = contentSizeAlongAxis / CGFloat(numberOfItems)
        let fullContentOffset = contentOffsetAlongAxis + insetAlongAxis
        let itemNumber = abs(fullContentOffset / widthPerItem)

        return Int(itemNumber.rounded())
    }
}
