//
//  LoginViewController.swift
//  Trela
//
//  Created by Kalissaac on 5/24/16.
//  Copyright © 2016 Kalissaac Corp. All rights reserved.
//

import UIKit
import Firebase
import SWMessages
import ARSLineProgress

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: HideShowPasswordTextField!
    @IBOutlet weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.isNavigationBarHidden = true
    }

    @IBAction func didPressLogin(_ sender: AnyObject) {
        ARSLineProgress.show()
        loginButton.isSelected = true
        if emailField.text == "" {
            delay(2) {
                ARSLineProgress.showFail()
                self.loginButton.isSelected = false
                SWMessage.sharedInstance.showNotificationWithTitle(
                    "Oops!",
                    subtitle: "You didn't enter an email!",
                    type: .error )
                }
        } else if passwordField.text == "" {
            delay(2) {
                ARSLineProgress.showFail()
                self.loginButton.isSelected = false
                SWMessage.sharedInstance.showNotificationWithTitle(
                    "Oops!",
                    subtitle: "You didn't enter a password!",
                    type: .error )
            }
        } else {
            delay(2) {
                Auth.auth().signIn(withEmail: self.emailField.text!, password: self.passwordField.text!, completion: { (user, error) -> Void in
                    if error == nil {
                        ARSLineProgress.showSuccess()
                        self.loginButton.isSelected = false
                        self.performSegue(withIdentifier: "loginSegue", sender: nil)
                        self.addUser()
                    } else {
                        ARSLineProgress.showFail()
                        self.loginButton.isSelected = false
                        SWMessage.sharedInstance.showNotificationWithTitle("Oops!", subtitle: error?.localizedDescription, type: .error)
                        SWMessage.sharedInstance.showNotificationInViewController(self, title: "Oops!2", subtitle: (error?.localizedDescription)!, type: .error)
                    }
                })
            }
        }
    }
    @IBAction func noAccount(_ sender: UIButton) {
        // TODO: Decide whether to allow users to create an account or not.
        
        UIApplication.shared.openURL(URL(string: "http://kalissaac.github.io/Trela")!)
    }
    
    func addUser() {
        
        let hasLoggedIn = true
        
        let user: [String: AnyObject] = ["hasLoggedIn" : hasLoggedIn as AnyObject]
        let databaseRef = Database.database().reference()
        databaseRef.child("Users").child((Auth.auth().currentUser?.uid)!).updateChildValues(user)
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
    func textField(_ textField: UITextField, shouldChangeCharactersInRange range: NSRange, textField string: String) -> Bool {
        return passwordField.textField(textField, shouldChangeCharactersInRange: range, replacementString: string)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        passwordField.textFieldDidEndEditing(textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
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
    func isValidPassword(_ password: String) -> Bool {
        return password.characters.count >= 6
    }
}
