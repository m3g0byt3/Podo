//
//  TransportCard.swift
//  Podo
//
//  Created by m3g0byt3 on 29/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RealmSwift

final class TransportCard: Object {

    // MARK: - Properties

    // swiftlint:disable:next force_try
    private static let notNumericRegex = try! NSRegularExpression(pattern: "[^0-9]+", options: .caseInsensitive)
    private static let podorozhnikIdentifier = 1
    private static let sputnikIdentifier = 2
    /// Type of card
    var cardType: TransportCardType { return TransportCardType(rawValue: _cardType)! }
    /// Identifier of card, used by an API
    var cardIdentifier: Int {
        switch self.cardType {
        case .sputnik: return TransportCard.sputnikIdentifier
        case .podorozhnikShort, .podorozhnikLong: return TransportCard.podorozhnikIdentifier
        }
    }
    /// Card unique number
    @objc dynamic var cardNumber = ""
    /// Private variable used to store `cardType` in Realm database
    @objc dynamic private var _cardType = 0
    /// Visual theme identifier for a card
    @objc dynamic var themeIdentifier = 0

    // MARK: - Initialization

    convenience init?(cardNumber: String) {
        self.init()
        guard
            // Get card number range used by regex matching
            let range = cardNumber.nsRange,
            // Check if card number contains only decimal digitis
            TransportCard.notNumericRegex.numberOfMatches(in: cardNumber, range: range) == 0,
            // Check if card number has proper length (equal `TransportCardType` raw value)
            let cardType = TransportCardType(rawValue: cardNumber.count) else {
                return nil
        }
        self._cardType = cardType.rawValue
        self.cardNumber = cardNumber
    }

    // MARK: - Public API

    override static func primaryKey() -> String {
        return #keyPath(TransportCard.cardNumber)
    }
}
