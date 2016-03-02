//
//  AppDelegate.swift
//  Your App
//
//  Created by Swift Off Starting Template.
//  Copyright © 2016 You. All rights reserved.
//

import Material
import UIKit
import Rollbar

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // This code initializes Rollbar Crash/Error Reporting
        // More information can be found at https://rollbar.com
        // Replace <ROLLBAR_TOKEN> with the token you get after signing up for Rollbar
        // Rollbar provides a free tier for use
        Rollbar.initWithAccessToken("<ROLLBAR_TOKEN>")
        
        // This code initializes Primer's Signup and Login Flows
        // More information can be found at https://goprimer.com
        // Replace <PRIMER_TOKEN> with the token you get after signing up with Primer
        // Primer provides a free tier for user
        // More documentation available here: https://docs.goprimer.com
        Primer.sharedInstance().onboardDelegate = LoginManager.sharedInstance
        Primer.sharedInstance().requiresLogin = true // ensures users signup or login before accessing app
        Primer.sharedInstance().registerClientWithToken("<PRIMER_TOKEN>")
        
        // Get view controllers from storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyboard.instantiateViewControllerWithIdentifier("MainViewController") as! MainViewController
        let sideViewController = storyboard.instantiateViewControllerWithIdentifier("SideViewController") as! SideViewController
        
        // Configure the window with the SideNavigationViewController as the root view controller
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = SideNavigationViewController(mainViewController: mainViewController, leftViewController: sideViewController)
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

