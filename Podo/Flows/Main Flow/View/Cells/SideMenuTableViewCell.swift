//
//  SideMenuTableViewCell.swift
//  Podo
//
//  Created by m3g0byt3 on 09/02/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit

final class SideMenuTableViewCell: UITableViewCell {

    // MARK: - IBOutlets

    @IBOutlet private weak var customImageView: UIImageView!
    @IBOutlet private weak var customTextLabel: UILabel!

    // MARK: - Properties

    var viewModel: SideMenuCellViewModel? {
        didSet {
            // TODO: Add actual implementation
        }
    }

    // MARK: - Public API

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    // MARK: - Private API

    private func setup() {
        let checkMarkViewFrame = CGRect(x: 0, y: 0, width: 20, height: 20)

        customTextLabel.textColor = R.clr.podoColors.white()
        backgroundColor = R.clr.podoColors.green()
        accessoryView = CheckMarkView(frame: checkMarkViewFrame)
    }
}