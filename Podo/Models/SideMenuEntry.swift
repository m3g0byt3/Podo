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
@objcMembers final class SideMenuEntry: Object {

    // MARK: - Properties
    dynamic var title = ""
    dynamic var type = ""
    dynamic var identifier = 0

    // MARK: - Inits
    convenience init(title: SideMenuEntryTitle, type: SideMenuEntryType) {
        self.init()
        self.title = title.rawValue
        self.type = type.rawValue
    }

    // MARK: - Public API
    override static func primaryKey() -> String? {
        return #keyPath(SideMenuEntry.identifier)
    }
}
