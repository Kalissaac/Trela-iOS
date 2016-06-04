//
//  LoginViewController.swift
//  SmaLert
//
//  Created by Kian on 5/24/16.
//  Copyright © 2016 Kian Sutarwala. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBAction func noAccount(sender: UIButton) {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://kalissaac.github.io/SmaLert")!)
    }

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginIndicator: UIActivityIndicatorView!
    @IBAction func didPressLogin(sender: AnyObject) {
        loginIndicator.startAnimating()
        loginButton.selected = true
        // If both the email and password fields match what we are looking for... 
        if emailField.text == "Kian" && passwordField.text == "Kian" {
            delay(2, closure: { () -> () in
            self.loginIndicator.stopAnimating()
            self.loginButton.selected = false
            self.performSegueWithIdentifier("loginSegue", sender: nil) })
        // Otherwise, email or password are incorrect so...
        } else {
            delay(2, closure: { () -> () in
            self.loginIndicator.stopAnimating()
            self.loginButton.selected = false
            let alertController = UIAlertController(title: "Oops!", message: "The email adress and/or password you entered were not reconized!", preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "Try again", style: .Cancel) { (action) in
            }
            alertController.addAction(cancelAction)
            self.presentViewController(alertController, animated: true) {
            } })
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
