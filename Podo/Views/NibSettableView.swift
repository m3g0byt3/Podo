//
//  NibSettableView.swift
//  Podo
//
//  Created by m3g0byt3 on 08/12/2017.
//  Copyright © 2017 m3g0byt3. All rights reserved.
//

import UIKit
import SnapKit

class NibSettableView: UIView {

    @IBOutlet weak var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        let className = String(describing: type(of: self))
        Bundle.main.loadNibNamed(className, owner: self, options: nil)
        addSubview(contentView)
        contentView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}
