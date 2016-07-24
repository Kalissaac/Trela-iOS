//
//  LoadingViewController.swift
//  SmaLert
//
//  Created by Kian on 7/17/16.
//  Copyright © 2016 Kalissaac Corp. All rights reserved.
//

import UIKit
import Firebase

class LoadingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(false)
        ARSLineProgress.show()
        if ((FIRAuth.auth()?.currentUser) != nil) {
            delay(5, closure: {
                ARSLineProgress.hide()
                let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("LoginLogout")
                self.presentViewController(viewController!, animated: true, completion: { return })
            })
        } else {
            delay(5, closure: {
                ARSLineProgress.hide()
                self.performSegueWithIdentifier("mapSegue", sender: nil)
            })
        }
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
