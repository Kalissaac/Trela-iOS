//
//  AppDelegate.swift
//  Trela
//
//  Created by Kalissaac on 4/10/16.
//  Copyright © 2016 Kalissaac Corp. All rights reserved.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift
import ARSLineProgress

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window:UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        /* // PURGE
        if let bundle = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundle)
        } */
        
        // Initialize Firebase.
        // Use Firebase library to configure APIs
        FirebaseApp.configure()
        IQKeyboardManager.sharedManager().enable = true
        
        UINavigationBar.appearance().tintColor = UIColor.red
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: UIFont(name: "Raleway-Medium", size: UIFont.labelFontSize)!]
        UILabel.appearance().substituteFontName = "Raleway-Regular"
        UILabel.appearance().substituteFontNameMedium = "Raleway-Medium"
        UILabel.appearance().substituteFontNameLight = "Raleway-Light"
        UILabel.appearance().substituteFontNameBold = "Raleway-Medium"
        UITextView.appearance().substituteFontName = "Raleway-Regular"
        UITextField.appearance().substituteFontName = "Raleway-Regular"
        let attributesBarButton = [NSFontAttributeName:UIFont(name: "Raleway-Regular", size: UIFont.labelFontSize)!]
        UIBarButtonItem.appearance().setTitleTextAttributes(attributesBarButton, for: UIControlState())
        let attributesBarButtonBold = [NSFontAttributeName:UIFont(name: "Raleway-Medium", size: UIFont.labelFontSize)!]
        UIBarButtonItem.appearance().setTitleTextAttributes(attributesBarButtonBold, for: .highlighted)
        
        // setup language and radius defaults
        let userDefaults = UserDefaults.standard
        if !(userDefaults.string(forKey: "language") != nil) {
            userDefaults.set("0", forKey: "language")
            userDefaults.synchronize()
        }
        if !(userDefaults.string(forKey: "radius") != nil) {
            userDefaults.set("0", forKey: "radius")
            userDefaults.synchronize()
        }
        // ars line progress
        ARSLineProgressConfiguration.circleColorInner = UIColor(red: 218.0/255.0, green: 74.0/255.0, blue: 68.0/255.0, alpha: 1.0).cgColor
        ARSLineProgressConfiguration.circleColorMiddle = UIColor(red: 218.0/255.0, green: 86.0/255.0, blue: 80.0/255.0, alpha: 1.0).cgColor
        ARSLineProgressConfiguration.circleColorOuter = UIColor(red: 218.0/255.0, green: 158.0/255.0, blue: 159.0/255.0, alpha: 1.0).cgColor
        
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        Database.database().goOffline()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        
        Database.database().goOnline()
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
        Database.database().goOffline()
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        let alertViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListAlertTable") as! UINavigationController
        self.window!.rootViewController!.present(alertViewController, animated: true, completion: nil)
        return true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        print("MessageID: \(userInfo["gcm_message_id"]!)")
        print(userInfo)
    }
    
}

extension UILabel {
    
    var substituteFontName : String {
        get { return self.font.fontName }
        set { self.font = UIFont(name: "Raleway-Regular", size: self.font.pointSize) }
    }
    
    var substituteFontNameMedium : String {
        get { return self.font.fontName }
        set {
            if self.font.fontName.range(of: "Medium") != nil {
                self.font = UIFont(name: "Raleway-Medium", size: self.font.pointSize)
            }
        }
    }
    
    var substituteFontNameBold : String {
        get { return self.font.fontName }
        set {
            if self.font.fontName.range(of: "Bold") != nil {
                self.font = UIFont(name: "Raleway-Medium", size: self.font.pointSize)
            }
        }
    }
    
    var substituteFontNameLight : String {
        get { return self.font.fontName }
        set {
            if self.font.fontName.range(of: "Light") != nil {
                self.font = UIFont(name: "Raleway-Light", size: self.font.pointSize)
            }
        }
    }
    
}

extension UITextView {
    
    var substituteFontName : String {
        get { return self.font!.fontName }
        set { self.font = UIFont(name: "Raleway-Regular", size: self.font!.pointSize) }
    }
    
}

extension UITextField {
    
    var substituteFontName : String {
        get { return self.font!.fontName }
        set { self.font = UIFont(name: "Raleway-Regular", size: self.font!.pointSize) }
    }
}
