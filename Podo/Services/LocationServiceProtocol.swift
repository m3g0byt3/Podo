//
//  LocationServiceProtocol.swift
//  Podo
//
//  Created by m3g0byt3 on 07/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import Result

protocol LocationServiceProtocol {

    typealias Completion = (Result<Location, AnyError>) -> Void

    func getCurrentLocation(completion: Completion)
}
