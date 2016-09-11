//
//  AppDelegate.swift
//  CheatCodes
//
//  Created by Dave Lyon on 09/09/2016.
//  Copyright (c) 2016 Dave Lyon. All rights reserved.
//

import UIKit
import CheatCodes

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    override var keyCommands: [UIKeyCommand]? {
        return UIKeyCommand.cheatCodes
    }

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

/// Example of custom commands
extension AppDelegate {

    func configureCustomCheats() {
        [
            CheatCodeCommand(input: "g", action: #selector(logInUser), discoverabilityTitle: "Log in a default user account"),
            CheatCodeCommand(input: "f", modifierFlags: [.command, .alternate], action: #selector(resetFirstRunScreens), discoverabilityTitle: "Reset all first run screens"),

        ].forEach { UIKeyCommand.addCheatCode($0) }

    }

    func logInUser() {
        print("Log in a user")
    }

    func resetFirstRunScreens() {
        print("First run screens reset!")
    }
}
