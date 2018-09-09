//
//  StationServiceProtocol.swift
//  Podo
//
//  Created by m3g0byt3 on 07/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

protocol StationServiceProtocol {

    typealias Completion = ([(Station, Location.Distance)]) -> Void

    func stationsNear(_ location: Location, limit: Int, completion: @escaping Completion)

    func cancel()
}
