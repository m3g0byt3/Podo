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

    typealias Degrees = Double

    let latitude: Degrees
    let longitude: Degrees
}
