//
//  Location.swift
//  Podo
//
//  Created by m3g0byt3 on 07/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

/// Just a `CLLocationCoordinate2D` wrapper to avoid Core Location import.
struct Location {

    // MARK: - Typealiases

    typealias Degrees = Double
    typealias Distance = Double

    // MARK: - Constants

    private static let earthRadius = 6_371e3

    // MARK: - Public properties

    let latitude: Degrees
    let longitude: Degrees

    /// Calculates distance between other location.
    /// - Note: Based in Haversine formula: https://www.movable-type.co.uk/scripts/latlong.html
    /// - Parameter location: Other location
    /// - Returns: Distance bewteen this location and other location in meters.
    func distance(to location: Location) -> Distance {
        let deltaLatitude = (self.latitude - location.latitude).radians
        let deltaLongitude = (self.longitude - location.longitude).radians
        let aValue =
            pow(sin(deltaLatitude / 2.0), 2.0) +
            cos(self.latitude.radians) *
            cos(location.latitude.radians) *
            pow(sin(deltaLongitude / 2.0), 2.0)
        let cValue = 2.0 * atan2(sqrt(aValue), sqrt(1.0 - aValue))
        return Location.earthRadius * cValue
    }
}
