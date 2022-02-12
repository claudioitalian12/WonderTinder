//
//  AppDelegate.swift
//  WonderTinder
//
//  Created by Claudio Cavalli on 08/02/22.
//

import UIKit
import WonderNavigator

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appNavigator: WonderProtocol.Navigator.AppNavigator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        initialDestination()
        
        return true
    }
    
    private func initialDestination() {
        appNavigator = WonderProtocol.Navigator.AppNavigator(initialDestination: .home)
        self.window = UIWindow()
        self.window?.rootViewController = appNavigator?.navigationController
        self.window?.overrideUserInterfaceStyle = .light
        self.window?.makeKeyAndVisible()
    }
}

