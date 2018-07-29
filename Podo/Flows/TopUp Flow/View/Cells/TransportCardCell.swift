//
//  TransportCardCell.swift
//  Podo
//
//  Created by m3g0byt3 on 21/06/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class TransportCardCell: UITableViewCell {

    // MARK: - IBOutlets

    @IBOutlet private weak var transportCardView: RoundShadowView!
    @IBOutlet private weak var transportCardLabel: UILabel!

    // MARK: - Properties

    private var disposeBag = DisposeBag()

    // MARK: - Public API

    override func prepareForReuse() {
        super.prepareForReuse()
        // Create new dispose bag on every re-use of the cell
        disposeBag = DisposeBag()
    }
}

// MARK: - Configurable protocol conformance

extension TransportCardCell: Configurable {

    typealias ViewModel = TransportCardViewModelProtocol

    @discardableResult
    func configure(with viewModel: ViewModel) -> Self {

        viewModel.cardTitle
            .drive(transportCardLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.cardTheme
            .map { [$0.firstGradientColor, $0.secondGradientColor] }
            .drive(transportCardView.rx.gradientColors)
            .disposed(by: disposeBag)

        return self
    }
}
