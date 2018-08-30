//
//  PaymentItem.swift
//  Podo
//
//  Created by m3g0byt3 on 30/08/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RealmSwift

final class PaymentItem: Object {

    // MARK: - Properties

    /// The payment date.
    @objc dynamic var date = Date()
    /// Unique identifier (`UUID`).
    @objc dynamic var identifier = UUID().uuidString
    /// Payment amount.
    @objc dynamic var amount = 0
    /// Payment status (successful or not).
    @objc dynamic var isSuccessful = true
    /// Paid transport card.
    @objc dynamic var transportCard: TransportCard?
    /// Private property for serialization/deserialization `PaymentMethodType` property.
    @objc private dynamic var _paymentType = ""
    /// Type of payment method used for payment.
    var paymentType: PaymentMethodType {
        return PaymentMethodType(rawValue: _paymentType) ?? .unknown
    }

    // MARK: - Initialization

    convenience required init(
        amount: Int,
        isSuccessful: Bool,
        transportCard: TransportCard,
        paymentType: PaymentMethodType
    ) {
        self.init()
        self.amount = amount
        self.isSuccessful = isSuccessful
        self.transportCard = transportCard
        self._paymentType = paymentType.rawValue
    }

    // MARK: - Public API

    override static func primaryKey() -> String? {
        return #keyPath(PaymentItem.identifier)
    }
}
