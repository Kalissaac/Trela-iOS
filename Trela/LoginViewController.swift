//
//  LoginViewController.swift
//  Trela
//
//  Created by Kalissaac on 5/24/16.
//  Copyright © 2016 Kalissaac Corp. All rights reserved.
//

import UIKit
import Firebase
import Presentr
import SWMessages

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: HideShowPasswordTextField!
    @IBOutlet weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.navigationBarHidden = true
    }

    @IBAction func didPressLogin(sender: AnyObject) {
        ARSLineProgress.show()
        loginButton.selected = true
        if emailField.text == "" {
            delay(2) {
                ARSLineProgress.showFail()
                self.loginButton.selected = false
                SWMessage.sharedInstance.showNotificationWithTitle(
                    "Oops!",
                    subtitle: "You didn't enter an email!",
                    type: .Error )
                }
        } else if passwordField.text == "" {
            delay(2) {
                ARSLineProgress.showFail()
                self.loginButton.selected = false
                SWMessage.sharedInstance.showNotificationWithTitle(
                    "Oops!",
                    subtitle: "You didn't enter a password!",
                    type: .Error )
            }
        } else {
            delay(2) {
                FIRAuth.auth()?.signInWithEmail(self.emailField.text!, password: self.passwordField.text!, completion: { (user, error) -> Void in
                    if error == nil {
                        ARSLineProgress.showSuccess()
                        self.loginButton.selected = false
                        self.performSegueWithIdentifier("loginSegue", sender: nil)
                    } else {
                        ARSLineProgress.showFail()
                        self.loginButton.selected = false
                        SWMessage.sharedInstance.showNotificationWithTitle(
                            "Oops!",
                            subtitle: error?.localizedDescription,
                            type: .Error )
                    }
                })
            }
        }
    }
    @IBAction func noAccount(sender: UIButton) {
        // TODO: Decide whether to allow users to create an account or not.
        
        UIApplication.sharedApplication().openURL(NSURL(string: "http://kalissaac.github.io/Trela")!)
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

// MARK: UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, textField string: String) -> Bool {
        return passwordField.textField(textField, shouldChangeCharactersInRange: range, replacementString: string)
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        passwordField.textFieldDidEndEditing(textField)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == emailField { // Switch focus to other text field
            passwordField.becomeFirstResponder()
        }
        return true
    }
}

// MARK: HideShowPasswordTextFieldDelegate
// Implementing this delegate is entirely optional.
// It's useful when you want to show the user that their password is valid.
extension LoginViewController: HideShowPasswordTextFieldDelegate {
    func isValidPassword(password: String) -> Bool {
        return password.characters.count > 6
    }
}
