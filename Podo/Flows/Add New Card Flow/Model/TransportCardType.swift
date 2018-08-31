//
//  TransportCardType.swift
//  Podo
//
//  Created by m3g0byt3 on 31/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

/// Strongly-typed representation of trasport card type
/// - Remark: Raw value = length of the card number for appropriate card type
enum TransportCardType {

    private enum RawValues {
        static let sputnik = 11
        static let podorozhnikShort = 19
        static let podorozhnikLong = 26
        static let unknown = 0
    }

    @available(*, unavailable, message: "Not supported yet")
    case sputnik
    case podorozhnikShort
    case podorozhnikLong
    case unknown
}

// MARK: - RawRepresentable protocol conformance

extension TransportCardType: RawRepresentable {

    init?(rawValue: Int) {
        switch rawValue {
        case RawValues.podorozhnikShort: self = .podorozhnikShort
        case RawValues.podorozhnikLong: self = .podorozhnikLong
        case RawValues.unknown: self = .unknown
        default: return nil
        }
    }

    var rawValue: Int {
        switch self {
        case .sputnik: fatalError("Not supported yet")
        case .podorozhnikShort: return RawValues.podorozhnikShort
        case .podorozhnikLong: return RawValues.podorozhnikLong
        case .unknown: return RawValues.unknown
        }
    }
}
