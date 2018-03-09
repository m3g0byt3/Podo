//
//  NavigationBarTitleView.swift
//  Podo
//
//  Created by m3g0byt3 on 18/12/2017.
//  Copyright © 2017 m3g0byt3. All rights reserved.
//

import UIKit

final class NavigationBarTitleView: UIView {

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
        snp.updateConstraints { make in
            make.center.height.equalToSuperview()
            make.width.equalTo(snp.height)
        }
    }

    // MARK: - Private API

    private func setup() {
        let imageView = UIImageView(image: R.image.metroTrainIcon())
        addSubview(imageView)
        imageView.snp.makeConstraints { $0.edges.equalToSuperview().inset(Constant.MainMenu.imageInset) }
    }
}
