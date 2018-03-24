//
//  ServiceAssembly.swift
//  Podo
//
//  Created by m3g0byt3 on 28/02/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import Swinject
import RealmSwift

final class ServiceAssembly: Assembly {

    func assemble(container: Container) {

        container.register(NetworkService.self) { _ in
            // TODO: Add actual implementation
            fatalError("Not implemented yet!")
        }

        container.register(AnyDatabaseService<SideMenuItem>.self) { _ in
            // Create custom configuration for bundled `sideMenuItemsRealm` database file
            let configuration = Realm.Configuration(fileURL: R.file.sideMenuItemsRealm(),
                                                    readOnly: true,
                                                    objectTypes: [SideMenuItem.self])
            guard let service = try? DatabaseServiceImpl<SideMenuItem>(configuration: configuration) else {
                fatalError("Unable to load configuration database from the application bundle.")
            }
            return AnyDatabaseService<SideMenuItem>(service)
        }
    }
}
