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
enum TransportCardType: Int {

    case sputnik = 11
    case podorozhnikShort = 19
    case podorozhnikLong = 26
    case unknown = 0
}
