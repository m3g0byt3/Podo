//
//  SideMenuItem.swift
//  Podo
//
//  Created by m3g0byt3 on 22/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RealmSwift

/// Represents entry in side menu, stored in bundled Realm database
@objcMembers final class SideMenuItem: Object {

    // MARK: - Properties

    dynamic var identifier = 0
    dynamic var title = ""
    dynamic var imageBlob: Data?

    // MARK: - Initialization

    convenience init(title: SideMenuItemType, image: UIImage) {
        self.init()
        self.title = title.rawValue
        self.imageBlob = UIImagePNGRepresentation(image)
    }

    // MARK: - Public API

    override static func primaryKey() -> String {
        return #keyPath(SideMenuItem.identifier)
    }
}
