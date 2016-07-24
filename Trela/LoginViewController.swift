//
//  LoginViewController.swift
//  SmaLert
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
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        /*if ((FIRAuth.auth()?.currentUser) != nil) {
        } else {
            self.performSegueWithIdentifier("loginSegue", sender: nil)
        }*/
    }

    @IBAction func didPressLogin(sender: AnyObject) {
        func show() {}
        loginButton.selected = true
        if emailField.text == "" {
            delay(2, closure: { () -> () in
                func showFail() {}
                self.loginButton.selected = false
                let title = "Oops!"
                let body = "You didn't enter an email!"
                let controller = Presentr.alertViewController(title: title, body: body)
                let tryAgainAction = AlertAction(title: "Try again", style: .Cancel){}
                controller.addAction(tryAgainAction)
                let presenter = Presentr(presentationType: .Alert)
                self.customPresentViewController(presenter, viewController: controller, animated: true, completion: nil) })
        } else if passwordField.text == "" {
            delay(2, closure: { () -> () in
                func showFail() {}
                self.loginButton.selected = false
                let title = "Oops!"
                let body = "You didn't enter a password!"
                let controller = Presentr.alertViewController(title: title, body: body)
                let tryAgainAction = AlertAction(title: "Try again", style: .Cancel){}
                controller.addAction(tryAgainAction)
                let presenter = Presentr(presentationType: .Alert)
                self.customPresentViewController(presenter, viewController: controller, animated: true, completion: nil) })
        } else {
            FIRAuth.auth()?.signInWithEmail(emailField.text!, password: passwordField.text!, completion: { (user, error) -> Void in
                if error == nil {
                    func showSuccess() {}
                    self.loginButton.selected = false
                    self.performSegueWithIdentifier("loginSegue", sender: nil)
                } else {
                    func showFail() {}
                    self.loginButton.selected = false
                    SWMessage.sharedInstance.showNotificationInViewController ( self, title: "Oops!", subtitle: error?.localizedDescription, image: nil, type: .Error, duration: .Automatic, callback: nil, buttonTitle: "Try again", buttonCallback: {}, atPosition: .Top, canBeDismissedByUser: true )
                }
            })
        }
    }
    @IBAction func noAccount(sender: UIButton) {
        // TODO: Decide whether to allow users to create an account or not.
        
        UIApplication.sharedApplication().openURL(NSURL(string: "http://kalissaac.github.io/SmaLert")!)
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
