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
            unableToResolve(NetworkService.self)
        }

        container.register(AnyDatabaseService<SideMenuItem>.self) { _ in
            // Create custom configuration for bundled `sideMenuItemsRealm` database file
            let configuration = Realm.Configuration(fileURL: R.file.sideMenuItemsRealm(),
                                                    readOnly: true,
                                                    objectTypes: [SideMenuItem.self])
            guard let service = try? DatabaseServiceImpl<SideMenuItem>(configuration: configuration) else {
                unableToResolve(DatabaseServiceImpl<SideMenuItem>.self)
            }
            return AnyDatabaseService<SideMenuItem>(service)
        }

        container.register(AnyDatabaseService<TransportCard>.self) { _ in
            guard let service = try? DatabaseServiceImpl<TransportCard>() else {
                unableToResolve(DatabaseServiceImpl<TransportCard>.self)
            }
            return AnyDatabaseService<TransportCard>(service)
        }

        container.register(AnyDatabaseService<PaymentMethod>.self) { _ in
            // Create custom configuration for bundled `paymentMethodsRealm` database file
            let configuration = Realm.Configuration(fileURL: R.file.paymentMethodsRealm(),
                                                    readOnly: true,
                                                    objectTypes: [PaymentMethod.self])
            guard let service = try? DatabaseServiceImpl<PaymentMethod>(configuration: configuration) else {
                unableToResolve(DatabaseServiceImpl<PaymentMethod>.self)
            }
            return AnyDatabaseService<PaymentMethod>(service)
        }
    }
}
