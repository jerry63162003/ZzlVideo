//
//  AppDelegate.swift
//  ZzlVideo
//
//  Created by dev10001 fh on 4/20/20.
//  Copyright © 2020 dev10001 fh. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        let tabBar = BBTabBarController.init()
        tabBar.tabBar.barTintColor = .white
        window?.rootViewController = tabBar
        window?.backgroundColor=UIColor.white
        window?.makeKeyAndVisible()
        return true
    }
}

