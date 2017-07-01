//
//  CreateAccountViewController.swift
//  Trela
//
//  Created by Kian on 8/26/16.
//  Copyright © 2016 Kalissaac Corp. All rights reserved.
//

import UIKit
import Firebase
import SWMessages
import ARSLineProgress

class CreateAccountViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: HideShowPasswordTextField!
    @IBOutlet var nameField: UITextField!
    @IBOutlet weak var createButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPressCreate(_ sender: AnyObject) {
        ARSLineProgress.show()
        createButton.isSelected = true
        if emailField.text == "" {
            delay(2) {
                ARSLineProgress.showFail()
                self.createButton.isSelected = false
                SWMessage.sharedInstance.showNotificationWithTitle(
                    "Oops!",
                    subtitle: "You didn't enter an email!",
                    type: .error )
            }
        } else if passwordField.text == "" {
            delay(2) {
                ARSLineProgress.showFail()
                self.createButton.isSelected = false
                SWMessage.sharedInstance.showNotificationWithTitle(
                    "Oops!",
                    subtitle: "You didn't enter a password!",
                    type: .error )
            }
        } else {
            delay(2) {
                Auth.auth().createUser(withEmail: self.emailField.text!, password: self.passwordField.text!, completion: { (user, error) in
                    
                    if error != nil {
                        self.login()
                    } else {
                        self.login()
                    }
                })
            }
        }
    }
    
    func addUser() {
        
        let hasLoggedIn = true
        let name = nameField.text
        
        let user: [String: AnyObject] = ["hasLoggedIn" : hasLoggedIn as AnyObject, "name" : name! as AnyObject]
        let databaseRef = Database.database().reference()
        databaseRef.child("Users").child((Auth.auth().currentUser?.uid)!).updateChildValues(user)
    }
    
    func login() {
        
        Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!, completion: { (user, error) in
            
            if error == nil {
                ARSLineProgress.showSuccess()
                self.createButton.isSelected = false
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                self.addUser()
            } else {
                ARSLineProgress.showFail()
                self.createButton.isSelected = false
                SWMessage.sharedInstance.showNotificationWithTitle(
                    "Oops!",
                    subtitle: error?.localizedDescription,
                    type: .error )
            }
        })
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
extension CreateAccountViewController: UITextFieldDelegate {
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
extension CreateAccountViewController: HideShowPasswordTextFieldDelegate {
    func isValidPassword(_ password: String) -> Bool {
        return password.characters.count >= 6
    }
}
