//
//  CardsCollectionViewCell.swift
//  Podo
//
//  Created by m3g0byt3 on 07/12/2017.
//  Copyright © 2017 m3g0byt3. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class CardsCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlets

    @IBOutlet private weak var cardView: RoundShadowView!
    @IBOutlet private weak var cardNumberLabel: UILabel!

    // MARK: - Properties

    private var disposeBag = DisposeBag()

    // MARK: - Public API

    override func awakeFromNib() {
        super.awakeFromNib()
        cardNumberLabel.font = UIFont.preferredFont(forTextStyle: .footnote, withSymbolicTraits: .traitBold)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        // Create new dispose bag on every re-use of the cell
        disposeBag = DisposeBag()
    }
}

// MARK: - Configurable protocol conformance

extension CardsCollectionViewCell: Configurable {

    typealias ViewModel = TransportCardViewModelProtocol

    @discardableResult
    func configure(with viewModel: TransportCardViewModelProtocol) -> Self {

        viewModel.cardTitle
            .asDriver(onErrorJustReturn: "")
            .drive(cardNumberLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.cardTheme
            .map { [$0.firstGradientColor, $0.secondGradientColor] }
            .asDriver(onErrorJustReturn: [])
            .drive(cardView.rx.gradientColors)
            .disposed(by: disposeBag)

        return self
    }
}
