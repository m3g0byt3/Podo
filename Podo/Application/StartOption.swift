//
//  StartOption.swift
//  Podo
//
//  Created by m3g0byt3 on 02/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit

// MARK: - Typealiases

typealias NotificationUserInfo = [AnyHashable: Any]

enum StartOption {

    case tutorial
    case settings
    case topUp(cardIdentifier: String)
    case addNewCard

    private enum ShortcutItemIdentifiers: String {
        case addNewCard
        case topUpCard
        case openSettings
    }

    // MARK: - Initialization

    init?(with shortcutItem: UIApplicationShortcutItem) {
        guard let shortcutType = shortcutItem.type.components(separatedBy: ".").last,
            let shortcutIdentifier = ShortcutItemIdentifiers(rawValue: shortcutType) else {
                return nil
        }

        switch shortcutIdentifier {
        case .addNewCard: self = .addNewCard
        // TODO: Extract card identifier from `userInfo` of `UIApplicationShortcutItem`
        case .topUpCard: self = .topUp(cardIdentifier: "cardIdentifier")
        case .openSettings: self = .settings
        }
    }

    init?(with notificationUserInfo: NotificationUserInfo) {
        fatalError("\(#function) not implemented yet!")
    }

    init?(with userActivity: NSUserActivity) {
        fatalError("\(#function) not implemented yet!")
    }
}
