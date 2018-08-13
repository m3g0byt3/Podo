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
import BSK

final class ServiceAssembly: Assembly {

    func assemble(container: Container) {

        container.register(NetworkServiceProtocol.self) { _ in
            let adapter = BSKAdapter()
            return BSKNetworkService(adapter)
        }

        container.register(AnyDatabaseService<SideMenuItem>.self) { _ in
            // Create custom configuration for bundled `sideMenuItemsRealm` database file
            let configuration = Realm.Configuration(fileURL: R.file.sideMenuItemsRealm(),
                                                    readOnly: true,
                                                    objectTypes: [SideMenuItem.self])
            guard let service = try? RealmDatabaseService<SideMenuItem>(configuration: configuration) else {
                unableToResolve(RealmDatabaseService<SideMenuItem>.self)
            }
            return AnyDatabaseService<SideMenuItem>(service)
        }

        container.register(AnyDatabaseService<TransportCard>.self) { _ in
            guard let service = try? RealmDatabaseService<TransportCard>() else {
                unableToResolve(RealmDatabaseService<TransportCard>.self)
            }
            return AnyDatabaseService<TransportCard>(service)
        }

        container.register(AnyDatabaseService<PaymentMethod>.self) { _ in
            // Create custom configuration for bundled `paymentMethodsRealm` database file
            let configuration = Realm.Configuration(fileURL: R.file.paymentMethodsRealm(),
                                                    readOnly: true,
                                                    objectTypes: [PaymentMethod.self])
            guard let service = try? RealmDatabaseService<PaymentMethod>(configuration: configuration) else {
                unableToResolve(RealmDatabaseService<PaymentMethod>.self)
            }
            return AnyDatabaseService<PaymentMethod>(service)
        }
    }
}
