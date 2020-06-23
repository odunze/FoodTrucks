//
//  AppDelegate.swift
//  Redfin FoodTrucks
//
//  Created by Lotanna Igwe-Odunze on 6/20/20.
//  Copyright © 2020 Lotanna Igwe-Odunze. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let nav = UINavigationController(rootViewController: ListViewController())
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = nav
        window!.makeKeyAndVisible()
        
        return true
    }
}
