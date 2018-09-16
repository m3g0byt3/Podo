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

    private static let stationsLimit = 3

    // MARK: - PaymentResultViewModelProtocol protocol conformance

    var input: PaymentResultViewModelInputProtocol { return self }
    var output: PaymentResultViewModelOutputProtocol { return self }

    // MARK: - PaymentResultViewModelOutputProtocol protocol conformance

    let isError: Bool

    let title: Single<String>

    let message: Single<String>

    lazy var errorMessage = self.lastLocation
        .thenIfError()
        .map { R.string.localizable.locationError() }
        .asSingle()

    lazy var isLoading = self.stations
        .withLatestFrom(Observable.just(false))
        .startWith(true)

    lazy var stations: Observable<[PaymentResultCellViewModelProtocol]> = self.lastLocation
        .flatMap { [unowned self] location in
            self.stations(for: location)
        }
        .map { $0.map(PaymentResultCellViewModel.init) }
        .share()

    // MARK: - Private properties

    private var locationService: LocationServiceProtocol?
    private var stationService: StationServiceProtocol?
    private lazy var lastLocation = self.location()
        .asObservable()
        .share()

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
}
