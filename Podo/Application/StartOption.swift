//
//  StartOption.swift
//  Podo
//
//  Created by m3g0byt3 on 02/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit

enum StartOption {

    case tutorial
    case settings
    // swiftlint:disable:next identifier_name
    case topUp(transpordCard: CardsCellViewModel)
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
        guard let shortcutType = shortcutItem.type.components(separatedBy: ".").last,
            let shortcutIdentifier = ShortcutItemIdentifiers(rawValue: shortcutType) else {
                return nil
        }

        switch shortcutIdentifier {
        case .addNewCard: self = .addNewCard
        // TODO: Extract card identifier from `userInfo` of `UIApplicationShortcutItem`
        case .topUpCard: notImplemented()
        case .openSettings: self = .settings
        }
    }

    init?(with notificationUserInfo: NotificationUserInfo) {
        notImplemented()
    }

    init?(with userActivity: NSUserActivity) {
        notImplemented()
    }
}
