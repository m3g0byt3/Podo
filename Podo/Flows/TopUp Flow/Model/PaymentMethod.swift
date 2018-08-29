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

    var type: PaymentMethodType { return PaymentMethodType(rawValue: _type) ?? .unknown }
    @objc private dynamic var _type = ""
    @objc dynamic var imageBlob: Data?
    @objc dynamic var isVisible = false
    @objc dynamic var isEnabled = false
    @objc dynamic var identifier = ""

    // MARK: - Initialization

    convenience required init(type: PaymentMethodType, image: UIImage, enabled: Bool = false, visible: Bool = false) {
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
