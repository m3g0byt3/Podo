//
//  TitleView.swift
//  Podo
//
//  Created by m3g0byt3 on 08/12/2017.
//  Copyright © 2017 m3g0byt3. All rights reserved.
//

import UIKit

class TitleView: NibSettableView {
    
    //TODO: Add actual implementation
    
    @IBOutlet private weak var imageView: UIImageView!
    
    override func updateConstraints() {
        imageView.snp.makeConstraints { $0.edges.equalToSuperview().inset(MainMenu.imageInset) }
        super.updateConstraints()
    }
}
