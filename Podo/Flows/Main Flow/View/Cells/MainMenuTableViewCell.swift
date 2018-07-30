//
//  MainMenuTableViewCell.swift
//  Podo
//
//  Created by m3g0byt3 on 03/12/2017.
//  Copyright © 2017 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit

final class MainMenuTableViewCell: UITableViewCell {

    // MARK: - IBOutlets

    @IBOutlet private weak var cardView: UIView!
}

// MARK: - Configurable protocol conformance

extension MainMenuTableViewCell: Configurable {

    typealias ViewModel = MainMenuCellViewModelProtocol

    @discardableResult
    func configure(with viewModel: MainMenuCellViewModelProtocol) -> Self {
        // TODO: Add actual implementation
        return self
    }
}
