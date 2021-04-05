//
//  AppDelegate.swift
//  WeatherForInnovise
//
//  Created by Hellizar on 5.04.21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)

        if let window = self.window {
            let tabBarVC = MainTabBar()
            window.rootViewController = tabBarVC
            window.makeKeyAndVisible()
        }
        return true
    }
}

