//
//  Swinject+Flow.swift
//  Podo
//
//  Created by m3g0byt3 on 05/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import Swinject

extension Container {

    @discardableResult
    func register<Service>(
        _ serviceType: Service.Type,
        flow: Constant.Flows,
        factory: @escaping (Resolver) -> Service
        ) -> ServiceEntry<Service> {

        return _register(serviceType, factory: factory, name: flow.rawValue)
    }

    @discardableResult
    func register<Service, Arg1>(
        _ serviceType: Service.Type,
        flow: Constant.Flows,
        factory: @escaping (Resolver, Arg1) -> Service) -> ServiceEntry<Service> {

        return _register(serviceType, factory: factory, name: flow.rawValue)
    }
}

extension Resolver {

    func resolve<Service>(
        _ serviceType: Service.Type,
        flow: Constant.Flows) -> Service? {

        return resolve(serviceType, name: flow.rawValue)
    }

    func resolve<Service, Arg1>(
        _ serviceType: Service.Type,
        flow: Constant.Flows,
        argument: Arg1) -> Service? {

        return resolve(serviceType, name: flow.rawValue, argument: argument)
    }
}
