//
//  LocationServiceProtocol.swift
//  Podo
//
//  Created by m3g0byt3 on 07/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import Result

enum LocationError: Error, LocalizedError {

    case accessDenied
    case accessRestricted
    case unableToLocate
    case underlying(Error)
}

protocol LocationServiceProtocol {

    typealias Completion = (Result<Location, LocationError>) -> Void

    func getCurrentLocation(completion: @escaping Completion)

    func cancel()
}
