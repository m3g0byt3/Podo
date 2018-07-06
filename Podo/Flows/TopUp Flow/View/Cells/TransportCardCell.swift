//
//  TransportCardCell.swift
//  Podo
//
//  Created by m3g0byt3 on 21/06/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit

final class TransportCardCell: UITableViewCell {

    // MARK: - IBOutlets

    @IBOutlet private weak var transportCardView: RoundShadowView!
    @IBOutlet private weak var transportCardLabel: UILabel!
}

// MARK: - Configurable protocol conformance

extension TransportCardCell: Configurable {

    typealias ViewModel = Any

    @discardableResult
    func configure(with viewModel: Any) -> Self {
        // TODO: Add actual implementation
        return self
    }
}
