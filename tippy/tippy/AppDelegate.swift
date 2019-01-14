//
//  AppDelegate.swift
//  tippy
//
//  Created by Ryan Sullivan on 1/8/19.
//  Copyright © 2019 Ryan Sullivan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let defaults = UserDefaults.standard
        let option1 = defaults.string(forKey: "option1")
        let option2 = defaults.string(forKey: "option2")
        let option3 = defaults.string(forKey: "option3")
        if option1 == nil {
            defaults.set("15%", forKey: "option1")
        }
        if option2 == nil {
            defaults.set("20%", forKey: "option2")
        }
        if option3 == nil {
            defaults.set("25%", forKey: "option3")
        }
        
        let locale = NSLocale.current
        defaults.set(locale.identifier, forKey: "locale")

        
        let theme = defaults.string(forKey: "theme")
        if theme == nil {
            defaults.set("Light", forKey: "theme")
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        let defaults = UserDefaults.standard
        defaults.set(Date(), forKey: "timestamp")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

