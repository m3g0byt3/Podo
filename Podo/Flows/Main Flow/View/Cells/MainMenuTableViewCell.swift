//
//  MainMenuTableViewCell.swift
//  Podo
//
//  Created by m3g0byt3 on 03/12/2017.
//  Copyright © 2017 m3g0byt3. All rights reserved.
//

import UIKit

final class MainMenuTableViewCell: UITableViewCell {

    // MARK: - IBOutlets

    @IBOutlet private weak var cardView: UIView!

    // MARK: - Properties

    var viewModel: MainMenuCellViewModel? {
        didSet {
            // TODO: Add actual implementation
        }
    }
}
