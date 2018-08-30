//
//  PaymentMethod.swift
//  Podo
//
//  Created by m3g0byt3 on 22/04/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RealmSwift

final class PaymentMethod: Object {

    // MARK: - Properties

    /// PNG Representation of payment icon.
    @objc dynamic var imageBlob: Data?
    /// The payment method is displayed or not.
    @objc dynamic var isVisible = false
    /// The payment method is enabled or not.
    @objc dynamic var isEnabled = false
    /// Unique identifier (`UUID`).
    @objc dynamic var identifier = ""
    /// Private property for serialization/deserialization `PaymentMethodType` property.
    @objc private dynamic var _type = ""
    /// Type of payment method.
    var type: PaymentMethodType {
        return PaymentMethodType(rawValue: _type) ?? .unknown
    }

    // MARK: - Initialization

    convenience required init(
        type: PaymentMethodType,
        image: UIImage,
        enabled: Bool = false,
        visible: Bool = false
    ) {
        self.init()
        self._type = type.rawValue
        self.isEnabled = enabled
        self.isVisible = visible
        self.imageBlob = UIImagePNGRepresentation(image)
        self.identifier = UUID().uuidString
    }

    // MARK: - Public API

    override static func primaryKey() -> String? {
        return #keyPath(PaymentMethod.identifier)
    }
}
