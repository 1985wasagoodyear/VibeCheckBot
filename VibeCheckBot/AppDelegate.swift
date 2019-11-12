//
//  AppDelegate.swift
//  VibeCheckBot
//
//  Created by K Y on 11/6/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import UIKit
import OAuthSwift
import Firebase

private let IS_DEBUGGING = false

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    lazy var twitterService: TwitterServiceProtocol = {
        if IS_DEBUGGING {
            return ProxyTwitterService()
        }
        return TwitterService()
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = initialViewController()
        window?.makeKeyAndVisible()
        
        // Use Firebase library to configure APIs
        FirebaseApp.configure()
        
        return true
    }
    
    func initialViewController() -> UIViewController {
        let hasUserSignedIn = twitterService.readFromKeychain()
        let vc: UIViewController
        if hasUserSignedIn {
            // Y: Make tweet screen
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vibeVC = storyboard.instantiateViewController(withIdentifier: "VibeViewController") as! VibeViewController
            vibeVC.service = twitterService
            vc = vibeVC
        }
        else {
            // N: Sign in screen
            let signInVC = SignInVibeViewController()
            signInVC.service = twitterService
            vc = signInVC
        }
        return vc
    }
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        if (url.host == Constants.oauthcallback) {
            OAuthSwift.handle(url: url)
        }
        return true
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
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

