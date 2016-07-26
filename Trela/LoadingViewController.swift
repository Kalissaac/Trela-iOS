//
//  LoadingViewController.swift
//  SmaLert
//
//  Created by Kian on 7/17/16.
//  Copyright © 2016 Kalissaac Corp. All rights reserved.
//

import UIKit
import Firebase
import BWWalkthrough

class LoadingViewController: UIViewController, BWWalkthroughViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        ARSLineProgress.show()
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if !userDefaults.boolForKey("walkthroughPresented") {
            ARSLineProgress.hide()
            
            showWalkthrough()
            
            userDefaults.setBool(true, forKey: "walkthroughPresented")
            userDefaults.synchronize()
        } else {
            if ((FIRAuth.auth()?.currentUser) != nil) {
                delay(5) {
                    ARSLineProgress.hide()
                    let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("LoginLogout")
                    self.presentViewController(viewController!, animated: true, completion: { return })
                }
            } else {
                delay(5) {
                    ARSLineProgress.hide()
                    self.performSegueWithIdentifier("mapSegue", sender: nil)
                }
            }
        }
    }
    
    func showWalkthrough(){
        
        // Get view controllers and build the walkthrough
        let stb = UIStoryboard(name: "Walkthrough", bundle: nil)
        let walkthrough = stb.instantiateViewControllerWithIdentifier("walk") as! BWWalkthroughViewController
        let page_one = stb.instantiateViewControllerWithIdentifier("walk1")
        let page_two = stb.instantiateViewControllerWithIdentifier("walk2")
        let page_three = stb.instantiateViewControllerWithIdentifier("walk3")
        let page_four = stb.instantiateViewControllerWithIdentifier("walk4")
        
        // Attach the pages to the master
        walkthrough.delegate = self
        walkthrough.addViewController(page_one)
        walkthrough.addViewController(page_two)
        walkthrough.addViewController(page_three)
        walkthrough.addViewController(page_four)
        
        self.presentViewController(walkthrough, animated: true, completion: nil)
    }
    
    // MARK: - Walkthrough delegate
    
    func walkthroughCloseButtonPressed() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
