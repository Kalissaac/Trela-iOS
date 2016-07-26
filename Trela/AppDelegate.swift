//
//  AppDelegate.swift
//  Trela
//
//  Created by Kalissaac on 4/10/16.
//  Copyright © 2016 Kalissaac Corp. All rights reserved.
//

import UIKit
import Firebase
import FirebaseMessaging

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window:UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        // Initialize Firebase.
        // Use Firebase library to configure APIs
        FIRApp.configure()
        let notificationTypes: UIUserNotificationType = [UIUserNotificationType.Alert, UIUserNotificationType.Badge, UIUserNotificationType.Sound]
        let notificationSettings = UIUserNotificationSettings(forTypes: notificationTypes, categories: nil)
        application.registerForRemoteNotifications()
        application.registerUserNotificationSettings(notificationSettings)
        
        UINavigationBar.appearance().tintColor = UIColor.redColor()
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: UIFont(name: "Raleway-Medium", size: 20)!]
        UILabel.appearance().substituteFontName = "Raleway-Regular"
        UILabel.appearance().substituteFontNameMedium = "Raleway-Medium"
        UILabel.appearance().substituteFontNameBold = "Raleway-Medium"
        UITextView.appearance().substituteFontName = "Raleway-Regular"
        UITextField.appearance().substituteFontName = "Raleway-Regular"
        let attributesBarButton = [NSFontAttributeName:UIFont(name: "Raleway-Regular", size: 17)!]
        UIBarButtonItem.appearance().setTitleTextAttributes(attributesBarButton, forState: .Normal)
        let attributesBarButtonBold = [NSFontAttributeName:UIFont(name: "Raleway-Medium", size: 17)!]
        UIBarButtonItem.appearance().setTitleTextAttributes(attributesBarButtonBold, forState: .Highlighted)
        let attributesTabBar = [NSFontAttributeName:UIFont(name: "Raleway-Regular", size: 11)!]
        UITabBarItem.appearance().setTitleTextAttributes(attributesTabBar, forState: .Normal)
        let attributesSegmentedControl = [NSFontAttributeName:UIFont(name: "Raleway-Regular", size: 14)!]
        UISegmentedControl.appearance().setTitleTextAttributes(attributesSegmentedControl as [NSObject : AnyObject] , forState: .Normal)
        
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
    
    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
        let alertViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ListAlertTable") as! UINavigationController
        self.window!.rootViewController!.presentViewController(alertViewController, animated: true, completion: nil)
        return true
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
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
            if self.font.fontName.rangeOfString("Medium") != nil {
                self.font = UIFont(name: "Raleway-Medium", size: self.font.pointSize)
            }
        }
    }
    
    var substituteFontNameBold : String {
        get { return self.font.fontName }
        set {
            if self.font.fontName.rangeOfString("Bold") != nil {
                self.font = UIFont(name: "Raleway-Medium", size: self.font.pointSize)
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
