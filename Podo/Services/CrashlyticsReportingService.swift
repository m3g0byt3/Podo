//
//  CrashlyticsReportingService.swift
//  Podo
//
//  Created by m3g0byt3 on 07/08/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import Fabric
import Crashlytics

/// A lightweight wrapper for Crashlytics framework
struct CrashlyticsReportingService: ReportingServiceProtocol {

    // MARK: - Private properties

    private let service: _CrashlyticsReportingService

    // MARK: - Initialization

    init() {
        self.service = _CrashlyticsReportingService.shared
    }

    // MARK: - ReportingServiceProtocol protocol conformance

    func beginReporting() {
        service.beginReporting()
    }

    func endReporting() {
        service.endReporting()
    }

    func report(event: ReportingEvent) {
        service.report(event: event)
    }
}

/// Internal wrapper around Crashlytics singleton
private class _CrashlyticsReportingService: ReportingServiceProtocol {

    // MARK: - Private properties

    static let shared = _CrashlyticsReportingService()

    /// Initialize Crashlytics
    /// - warning: ⚠️ Dispatched once ⚠️
    private lazy var initialize: () -> Void = {
        Fabric.with([Crashlytics.self])
        // Return dummy closure
        return {}
    }()

    // MARK: - Initialization

    private init() {}

    // MARK: - ReportingServiceProtocol protocol conformance

    func beginReporting() {
        initialize()
    }

    func endReporting() {
        // Does nothing because Crashlytics can't stop reporting.
    }

    func report(event: ReportingEvent) {
        let customAttributes: [String: Any]?

        switch event {
        case let .transportCardAdded(identifier):
            customAttributes = ["card identifier": identifier]

        case let .paymentInitiated(type, sum):
            customAttributes = ["payment type": type.rawValue, "payment sum": sum]

        case let .paymentSuccessful(type):
            customAttributes = ["payment type": type.rawValue]

        case let .paymentFailed(type, reason):
            customAttributes = ["payment type": type.rawValue, "failure reason": reason]

        case let .sideMenuItemSelected(type):
            customAttributes = ["menu item type": type.rawValue]

        case .onBoardCompleted, .onBoardSkipped:
            customAttributes = nil
        }

        Answers.logCustomEvent(withName: String(describing: event),
                               customAttributes: customAttributes)
    }
}

extension ReportingEvent: CustomStringConvertible {

    var description: String {
        switch self {
        case .sideMenuItemSelected: return "Side menu item selected"
        case .transportCardAdded: return "Transport card added"
        case .paymentInitiated: return "Payment initiated"
        case .paymentSuccessful: return "Payment successful"
        case .paymentFailed: return "Payment failed"
        case .onBoardCompleted: return "Onboarding completed"
        case .onBoardSkipped: return "Onboarding skipped"
        }
    }
}
