//
//  StartOption.swift
//  Podo
//
//  Created by m3g0byt3 on 02/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit

enum StartOption {

    case tutorial
    case settings
    case topUp(transpordCard: TransportCardViewModelProtocol)
    case addNewCard

    // MARK: - Constants

    private enum ShortcutItemIdentifiers: String {
        case addNewCard
        case topUpCard
        case openSettings
    }

    // MARK: - Typealiases

    typealias NotificationUserInfo = [AnyHashable: Any]

    // MARK: - Initialization

    init?(with shortcutItem: UIApplicationShortcutItem) {
        guard
            let shortcutType = shortcutItem.type.components(separatedBy: ".").last,
            let shortcutIdentifier = ShortcutItemIdentifiers(rawValue: shortcutType)
        else { return nil }

        switch shortcutIdentifier {
        case .addNewCard: self = .addNewCard
        case .openSettings: self = .settings
        // TODO: Add actual implementation: extract card identifier from `userInfo` of `UIApplicationShortcutItem`
        case .topUpCard:
            assertionFailure("Not implemented")
            return nil
        }
    }

    init?(with notificationUserInfo: NotificationUserInfo) {
        // TODO: Add actual implementation
        assertionFailure("Not implemented")
        return nil
    }

    init?(with userActivity: NSUserActivity) {
        // TODO: Add actual implementation
        assertionFailure("Not implemented")
        return nil
    }
}
