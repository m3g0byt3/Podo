//
//  FirebaseStationService.swift
//  Podo
//
//  Created by m3g0byt3 on 07/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import FirebaseDatabase

final class FirebaseStationService {

    // MARK: - Private properties

    private lazy var reference = Database.database().reference(withPath: path)
    private let path: String
    private let queue = DispatchQueue(label: "com.m3g0byt3.podo.firebase.\(UUID().uuidString)",
                                      qos: .userInitiated,
                                      attributes: .concurrent)

    // MARK: - Initialization

    init(path: String) {
        self.path = path
    }
}

// MARK: - StationServiceProtocol protocol conformance

extension FirebaseStationService: StationServiceProtocol {

    func stationsNear(_ location: Location,
                      limit: Int,
                      completion: @escaping StationServiceProtocol.Completion) {
        queue.async { [weak self] in
            self?.reference.observeSingleEvent(of: .value) { snapshot in
                let stations = snapshot.children
                    .compactMap { $0 as? DataSnapshot }
                    .compactMap(Station.init)
                    .map { ($0, location.distance(to: $0.location)) }
                    .sorted { $0.1 < $1.1 }
                    .prefix(limit)

                completion(Array(stations))
            }
        }
    }

    func cancel() {
        reference.removeAllObservers()
    }
}

// MARK: - Convenience initializer for `Station` model

private extension Station {

    init?(child: DataSnapshot) {
        guard
            let dict = child.value as? [String: Any],
            let name = dict[Constant.Firebase.nameKey] as? String,
            let latitude = dict[Constant.Firebase.latitudeKey] as? Double,
            let longitude = dict[Constant.Firebase.longitudeKey] as? Double
        else { return nil }

        self.name = name
        self.location = Location(latitude: latitude, longitude: longitude)
    }
}
