//
//  CoreLocationService.swift
//  Podo
//
//  Created by m3g0byt3 on 07/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import CoreLocation

final class CoreLocationService: NSObject {

    // MARK: - Private properties

    private lazy var manager: CLLocationManager = { this in
        this.delegate = self
        this.desiredAccuracy = kCLLocationAccuracyHundredMeters
        return this
    }(CLLocationManager())

    private var _completion: LocationServiceProtocol.Completion?

    // MARK: - Private API

    private func handle(status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined: manager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways: manager.requestLocation()
        case .denied: _completion?(.failure(.accessDenied))
        case .restricted: _completion?(.failure(.accessRestricted))
        }
    }
}

// MARK: - LocationServiceProtocol protocol conformance

extension CoreLocationService: LocationServiceProtocol {

    func getCurrentLocation(completion: @escaping LocationServiceProtocol.Completion) {
        _completion = completion
        handle(status: CLLocationManager.authorizationStatus())
    }

    func cancel() {
        manager.stopUpdatingLocation()
    }
}

// MARK: - CLLocationManagerDelegate protocol conformance

extension CoreLocationService: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        handle(status: status)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate {
            let wrapped = Location(coordinate2D: coordinate)
            _completion?(.success(wrapped))
        } else {
            _completion?(.failure(.unableToLocate))
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        _completion?(.failure(.underlying(error)))
    }
}

// MARK: - Convenience initializer for `Location` wrapper

private extension Location {

    init(coordinate2D: CLLocationCoordinate2D) {
        self.latitude = coordinate2D.latitude
        self.longitude = coordinate2D.longitude
    }
}
