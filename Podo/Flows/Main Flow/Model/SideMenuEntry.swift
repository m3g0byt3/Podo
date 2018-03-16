//
//  SideMenuEntry.swift
//  RealmBuilder
//
//  Created by m3g0byt3 on 14/02/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import RealmSwift

/**
 Represents entry in side menu, stored in bundled Realm database
 */
final class SideMenuEntry: Object {

    // MARK: - Properties

    @objc dynamic var title = ""
    @objc dynamic var type = ""
    @objc dynamic var identifier = 0
    @objc private dynamic var iconBlob: Data?
    var icon: UIImage? {
        return iconBlob.flatMap { UIImage(data: $0) }
    }

    // MARK: - Initialization

    convenience init(title: SideMenuEntryTitle, type: SideMenuEntryType, icon: UIImage? = nil) {
        self.init()
        self.title = title.rawValue
        self.type = type.rawValue
        self.iconBlob = icon.flatMap { UIImagePNGRepresentation($0) }
    }

    // MARK: - Public API

    override static func primaryKey() -> String? {
        return #keyPath(SideMenuEntry.identifier)
    }
}
