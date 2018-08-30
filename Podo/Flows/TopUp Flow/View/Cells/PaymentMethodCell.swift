//
//  PaymentMethodCell.swift
//  Podo
//
//  Created by m3g0byt3 on 17/04/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class PaymentMethodCell: UITableViewCell {

    // MARK: - Constants

    private static let alphaValue: CGFloat = 0.5

    // MARK: - IBOutlets

    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var icon: UIImageView!

    // MARK: - Properties

    private var disposeBag = DisposeBag()

    // MARK: - Public API

    override func prepareForReuse() {
        super.prepareForReuse()
        // Create new dispose bag on every re-use of the cell
        disposeBag = DisposeBag()
    }

    // MARK: - Private API

    private func disable() -> Completable {
        return Completable.create { [weak self] completable in
            let view = UIView(frame: .zero)
            let alphaValue = PaymentMethodCell.alphaValue

            self?.contentView.superview?.addSubview(view)
            self?.isUserInteractionEnabled = false
            view.backgroundColor = UIColor.white.withAlphaComponent(alphaValue)
            view.snp.makeConstraints { $0.edges.equalToSuperview() }

            completable(.completed)

            return Disposables.create()
        }
    }
}

// MARK: - Configurable protocol conformance

extension PaymentMethodCell: Configurable {

    typealias ViewModel = PaymentMethodCellViewModelProtocol

    @discardableResult
    func configure(with viewModel: PaymentMethodCellViewModelProtocol) -> Self {

        viewModel.output.title
            .asDriver(onErrorJustReturn: Constant.Placeholder.empty)
            .drive(title.rx.text)
            .disposed(by: disposeBag)

        viewModel.output.iconBlob
            .map(UIImage.init)
            .filterNil()
            .asDriver(onErrorJustReturn: UIImage())
            .drive(icon.rx.image)
            .disposed(by: disposeBag)

        viewModel.output.isEnabled
            .filter(!)
            .flatMap { [weak self] _ -> Completable in
                self?.disable() ?? .empty()
            }
            .subscribe()
            .disposed(by: disposeBag)

        return self
    }
}
