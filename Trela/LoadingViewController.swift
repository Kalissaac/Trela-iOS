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
import ARSLineProgress

class LoadingViewController: UIViewController, BWWalkthroughViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        ARSLineProgress.show()
        
        let userDefaults = UserDefaults.standard
        if !userDefaults.bool(forKey: "walkthroughPresented") {
            ARSLineProgress.hide()
            
            showWalkthrough()
            
            userDefaults.set(true, forKey: "walkthroughPresented")
            userDefaults.synchronize()
        } else {
            Auth.auth().addStateDidChangeListener { auth, user in
                if let user = user {
                    // User is signed in.
                    print("User's email: \(user.email!)")
                    delay(5) {
                        ARSLineProgress.hide()
                        delay(0.25) {
                            self.performSegue(withIdentifier: "mapSegue", sender: nil)
                        }
                    }
                } else {
                    // No user is signed in.
                    delay(5) {
                        ARSLineProgress.hide()
                        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginLogout")
                        self.present(viewController!, animated: true, completion: { return })
                    }
                }
            }
        }
    }
    
    func showWalkthrough(){
        
        // Get view controllers and build the walkthrough
        let stb = UIStoryboard(name: "Walkthrough", bundle: nil)
        let walkthrough = stb.instantiateViewController(withIdentifier: "walk") as! BWWalkthroughViewController
        let page_one = stb.instantiateViewController(withIdentifier: "walk1")
        let page_two = stb.instantiateViewController(withIdentifier: "walk2")
        let page_three = stb.instantiateViewController(withIdentifier: "walk3")
        let page_four = stb.instantiateViewController(withIdentifier: "walk4")
        
        // Attach the pages to the master
        walkthrough.delegate = self
        walkthrough.add(viewController:page_one)
        walkthrough.add(viewController:page_two)
        walkthrough.add(viewController:page_three)
        walkthrough.add(viewController:page_four)
        
        self.present(walkthrough, animated: true, completion: nil)
    }
    
    // MARK: - Walkthrough delegate
    
    func walkthroughCloseButtonPressed() {
        self.dismiss(animated: true, completion: nil)
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
