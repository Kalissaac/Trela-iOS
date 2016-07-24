//
//  ProfileDetailViewController.swift
//  SmaLert
//
//  Created by Kalissaac on 6/262/16.
//  Copyright © 2016 Kalissaac Corp. All rights reserved.
//

import UIKit

class ProfileDetailViewController: UIViewController {
    
    var barFrame:CGRect?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // self.tabBarController?.tabBar.hidden=true
        if let tabBar=self.tabBarController?.tabBar {
            self.barFrame=tabBar.frame
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                let newBarFrame=CGRectMake(self.barFrame!.origin.x, self.view.frame.size.height, self.barFrame!.size.width, self.barFrame!.size.height)
                tabBar.frame=newBarFrame
                }, completion: { (Bool) -> Void in
                    tabBar.hidden=true
            })
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden=false;
        if self.barFrame != nil {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                let newBarFrame=CGRectMake(self.barFrame!.origin.x, self.view.frame.size.height-self.barFrame!.size.height, self.view.frame.size.width, self.barFrame!.size.height)
                self.tabBarController?.tabBar.frame=newBarFrame
            })
        }
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
