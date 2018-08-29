//
//  TrainIconView.swift
//  Podo
//
//  Created by m3g0byt3 on 18/12/2017.
//  Copyright © 2017 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
final class TrainIconView: UIView {

    // MARK: - Constants

    private static let imageInset: CGFloat = 5.0

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: - Public API

    override func didMoveToSuperview() {
        guard let superview = superview else { return }
        let superviewHeight = superview.frame.height
        frame.size = CGSize(width: superviewHeight, height: superviewHeight)
    }

    // MARK: - Private API

    private func setup() {
        let imageView = UIImageView(image: R.image.metroTrainIcon())
        addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = R.clr.podoColors.white()
        imageView.snp.makeConstraints { $0.edges.equalToSuperview().inset(TrainIconView.imageInset) }
    }
}
