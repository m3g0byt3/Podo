//
//  ReportingServiceProtocol.swift
//  Podo
//
//  Created by m3g0byt3 on 07/08/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

protocol ReportingServiceProtocol {

    func beginReporting()
    func endReporting()
    func report(event: ReportingEvent)
}

enum ReportingEvent {

    case sideMenuItemSelected(type: SideMenuItemType)
    case transportCardAdded(identifier: String)
    case paymentInitiated(type: PaymentMethodType, sum: Int)
    case paymentSuccessful(type: PaymentMethodType)
    case paymentFailed(type: PaymentMethodType, reason: String)
    case onBoardCompleted
    case onBoardSkipped
}
