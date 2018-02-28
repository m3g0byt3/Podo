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

    lazy var window: UIWindow? = {
        return UIWindow(frame: UIScreen.main.bounds)
    }()

    private var rootViewController: UIViewController? {
        return ApplicationAssembler.defaultAssembler.resolver.resolve(MainView.self)
            .flatMap { $0 as? UIViewController }
            .map { UINavigationController(rootViewController: $0) }
    }

    // MARK: - Lifecycle

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        appearanceSetup()

        return true
    }

    // MARK: - Private API

    private func appearanceSetup() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().barStyle = .black
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = R.clr.podoColors.green()
    }
}
