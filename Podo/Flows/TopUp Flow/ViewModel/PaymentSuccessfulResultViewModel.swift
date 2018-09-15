//
//  PaymentSuccessfulResultViewModel.swift
//  Podo
//
//  Created by m3g0byt3 on 10/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RxSwift

final class PaymentSuccessfulResultViewModel: PaymentResultViewModelProtocol,
                                              PaymentResultViewModelInputProtocol,
                                              PaymentResultViewModelOutputProtocol {

    // MARK: - Constants

    private static let distanceDivider = 1_000.0
    private static let distanceSuffix = R.string.localizable.distanceSuffix()
    private static let stationsLimit = 3

    // MARK: - PaymentResultViewModelProtocol protocol conformance

    var input: PaymentResultViewModelInputProtocol { return self }
    var output: PaymentResultViewModelOutputProtocol { return self }

    // MARK: - PaymentResultViewModelOutputProtocol protocol conformance

    let isError: Bool

    let title: Single<String>

    let message: Single<String>

    lazy var isLoading: Observable<Bool> = self.stations
        .withLatestFrom(Observable.just(false))
        .startWith(true)

    lazy var stations: Observable<[String]> = self.location()
        .flatMap { [unowned self] location in
            self.stations(for: location)
        }
        .map(PaymentSuccessfulResultViewModel.stationNames)
        .asObservable()
        .share()

    // MARK: - Private properties

    private var locationService: LocationServiceProtocol?
    private var stationService: StationServiceProtocol?

    // MARK: - Initialization

    init(locationService: LocationServiceProtocol, stationService: StationServiceProtocol) {
        self.isError = false

        self.locationService = locationService

        self.stationService = stationService

        self.title = Single
            .just(R.string.localizable.successTitle())

        self.message = Single
            .just(R.string.localizable.successMessage() +
                  "\n" +
                  R.string.localizable.nearestSubwayStation())
    }

    // MARK: - Private API

    // TODO: Optimize usage of private methods

    private func location() -> Single<Location> {
        return .create { [weak self] single in
            self?.locationService?.getCurrentLocation { result in
                switch result {
                case .success(let location): single(.success(location))
                case .failure(let error): single(.error(error))
                }
            }

            return Disposables.create {
                self?.locationService?.cancel()
            }
        }
    }

    private func stations(for location: Location) -> Single<[(Station, Double)]> {
        let limit = PaymentSuccessfulResultViewModel.stationsLimit

        return .create { [weak self] single in
            self?.stationService?.stationsNear(location, limit: limit) { stations in
                single(.success(stations))
            }

            return Disposables.create {
                self?.stationService?.cancel()
            }
        }
    }

    private static func stationNames(_ stations: [(Station, Double)]) -> [String] {
        let divider = PaymentSuccessfulResultViewModel.distanceDivider
        let suffix = PaymentSuccessfulResultViewModel.distanceSuffix

        return stations.map { tuple -> String in
            let (station, distance) = tuple
            let distanceString = String(format: "%.2f \(suffix)", distance / divider)
            let nameString = station.name

            return "\(nameString) \(distanceString)"
        }
    }
}
