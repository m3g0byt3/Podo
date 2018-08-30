//
//  MainMenuViewModel.swift
//  Podo
//
//  Created by m3g0byt3 on 03/12/2017.
//  Copyright © 2017 m3g0byt3. All rights reserved.
//

import Foundation
import RxSwift

final class MainMenuViewModel: MainMenuViewModelProtocol,
                               MainMenuViewModelInputProtocol,
                               MainMenuViewModelOutputProtocol {

    // MARK: - MainMenuViewModelProtocol protocol conformance

    var input: MainMenuViewModelInputProtocol { return self }
    var output: MainMenuViewModelOutputProtocol { return self }

    // MARK: - MainMenuViewModelOutputProtocol protocol conformance

    let emptyTitle: Single<String>
    let emptyMessage: Single<String>
    let emptyImageBlob: Single<Data?>
    let paymentResults: Observable<[MainMenuCellViewModelProtocol]>

    // MARK: - Constants

    private static let keyPath = #keyPath(PaymentItem.date)
    private static let sortOption = SortOption.descending(keyPath: keyPath)

    // MARK: - Private properties

    private let model: AnyDatabaseService<PaymentItem>

    // MARK: - Initialization

    init(_ model: AnyDatabaseService<PaymentItem>) {
        self.model = model

        self.emptyTitle = Single
            .just(R.string.localizable.noTransaction())

        self.emptyMessage = Single
            .just(R.string.localizable.addCard())

        self.emptyImageBlob = Single
            .just(R.image.cryingCard()?.pngData())

        self.paymentResults = model.itemsObservable(sorted: MainMenuViewModel.sortOption)
            .map { $0.map(MainMenuCellViewModel.init) }
            .share()
    }
}
