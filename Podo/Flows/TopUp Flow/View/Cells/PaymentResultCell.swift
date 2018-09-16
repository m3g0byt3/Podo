//
//  PaymentResultCell.swift
//  Podo
//
//  Created by m3g0byt3 on 11/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

final class PaymentResultCell: UITableViewCell {

    // MARK: - Private properties

    private lazy var stationLabel: UILabel = { this in
        this.font = UIFont.preferredFont(forTextStyle: .footnote)
        this.textColor = R.clr.appleHIG.blue()
        this.textAlignment = .center
        this.numberOfLines = 0
        return this
    }(UILabel())

    // MARK: - Initialization

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    // MARK: - Public API

    override func prepareForReuse() {
        super.prepareForReuse()
        stationLabel.text = nil
    }

    override func updateConstraints() {
        stationLabel.snp.updateConstraints { maker in
            maker.center.equalToSuperview()
        }
        super.updateConstraints()
    }

    // MARK: - Private API

    private func setupUI() {
        selectionStyle = .none
        contentView.addSubview(stationLabel)
    }
}

// MARK: - Configurable protocol conformance

extension PaymentResultCell: Configurable {

    typealias ViewModel = PaymentResultCellViewModelProtocol

    @discardableResult
    func configure(with viewModel: ViewModel) -> Self {
        stationLabel.text = viewModel.output.title
        setNeedsUpdateConstraints()
        return self
    }
}
