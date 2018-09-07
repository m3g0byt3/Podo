//
//  CoreLocationService.swift
//  Podo
//
//  Created by m3g0byt3 on 07/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import Result
import CoreLocation

class CoreLocationService: NSObject {

    // MARK: - Private properties

    private lazy var manager: CLLocationManager = { this in
        this.delegate = self
        this.desiredAccuracy = kCLLocationAccuracyHundredMeters
        return this
    }(CLLocationManager())

    private var completion: LocationServiceProtocol.Completion?

    // MARK: - Private API

    private func handle(status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined: manager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways: manager.requestLocation()
        case .denied: break // TODO: Handle an error
        case .restricted: break // TODO: Handle an error
        }
    }
}

// MARK: - LocationServiceProtocol protocol conformance

extension CoreLocationService: LocationServiceProtocol {

    func getCurrentLocation(completion: (Result<Location, AnyError>) -> Void) {
        handle(status: CLLocationManager.authorizationStatus())
    }
}

// MARK: - CLLocationManagerDelegate protocol conformance

extension CoreLocationService: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        handle(status: status)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate = locations.last?.coordinate else {
            // TODO: Handle an error
            return
        }
        let wrapped = Location(coordinate2D: coordinate)
        completion?(.success(wrapped))
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // TODO: Handle an error
    }
}

// MARK: - Convenience initializer for `Location` wrapper

private extension Location {

    init(coordinate2D: CLLocationCoordinate2D) {
        self.latitude = coordinate2D.latitude
        self.longitude = coordinate2D.longitude
    }
}
