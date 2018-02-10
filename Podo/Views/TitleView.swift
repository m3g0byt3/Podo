//
//  TitleView.swift
//  Podo
//
//  Created by m3g0byt3 on 18/12/2017.
//  Copyright © 2017 m3g0byt3. All rights reserved.
//

import UIKit

class TitleView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        let imageView = UIImageView(image: R.image.metroTrainIcon())
        addSubview(imageView)
        imageView.snp.makeConstraints { $0.edges.equalToSuperview().inset(MainMenu.imageInset) }
    }

    override func didMoveToSuperview() {
        self.snp.updateConstraints { make in
            make.center.height.equalToSuperview()
            make.width.equalTo(self.snp.height)
        }
    }
}
