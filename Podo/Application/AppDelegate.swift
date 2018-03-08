//
//  AppDelegate.swift
//  Podo
//
//  Created by m3g0byt3 on 23/11/2017.
//  Copyright © 2017 m3g0byt3. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Properties

    var window: UIWindow?

    var rootViewController: UINavigationController {
        // swiftlint:disable force_cast
        return window!.rootViewController as! UINavigationController
    }

    private lazy var coordinator: Coordinator? = {
        return ApplicationAssembler.defaultAssembler.resolver.resolve(Router.self, argument: rootViewController)
            .flatMap { ApplicationAssembler.defaultAssembler.resolver.resolve(Coordinator.self, argument: $0) }
    }()

    // MARK: - UIApplicationDelegate protocol conformance

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        var startOption: StartOption?

        if let shortcutItem = launchOptions?[.shortcutItem] as? UIApplicationShortcutItem {
            startOption = StartOption(with: shortcutItem)
        }
        coordinator?.start(with: startOption)

        return startOption == nil
    }

    // MARK: - Handle 3D Touch shortcuts

    func application(_ application: UIApplication,
                     performActionFor shortcutItem: UIApplicationShortcutItem,
                     completionHandler: @escaping (Bool) -> Void) {
        let startOption = StartOption(with: shortcutItem)
        coordinator?.start(with: startOption)
        completionHandler(startOption != nil)
    }

    // MARK: - Handle push notifications

    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        let startOption = StartOption(with: userInfo)
        coordinator?.start(with: startOption)
    }

    // MARK: - Handle Handoff

    func application(_ application: UIApplication,
                     continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        let startOption = StartOption(with: userActivity)
        coordinator?.start(with: startOption)
        return true
    }
}
