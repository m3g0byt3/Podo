//
//  PaymentResultCellViewModel.swift
//  Podo
//
//  Created by m3g0byt3 on 15/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

struct PaymentResultCellViewModel: PaymentResultCellViewModelProtocol,
                                   PaymentResultCellViewModelInputProtocol,
                                   PaymentResultCellViewModelOutputProtocol {

    // MARK: - PaymentResultCellViewModelProtocol protocol conformance

    var input: PaymentResultCellViewModelInputProtocol { return self }
    var output: PaymentResultCellViewModelOutputProtocol { return self }

    // MARK: - PaymentResultCellViewModelInputProtocol protocol conformance

    // MARK: - PaymentResultCellViewModelOutputProtocol protocol conformance

    let title: String
    let url: URL?

    // MARK: - Initialization

    init(station: Station, distance: Double) {
        let distanceString = String(format: "%.2f", distance / 1_000.0) + R.string.localizable.distanceSuffix()
        let nameString = station.name
        let transportTypeItem = URLQueryItem(name: "dirflg", value: "w")
        let locationItem = URLQueryItem(name: "daddr", value: "\(station.location.latitude),\(station.location.longitude)")
        var components = URLComponents()

        components.scheme = "https"
        components.host = "maps.apple.com"
        components.queryItems = [transportTypeItem, locationItem]

        self.title = "\(nameString) \(distanceString)"
        self.url = components.url
    }
}
