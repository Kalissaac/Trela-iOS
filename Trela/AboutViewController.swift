//
//  AboutViewController.swift
//  Trela
//
//  Created by Kian on 8/6/16.
//  Copyright © 2016 Kalissaac Corp. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var otherLabel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        versionLabel.font = UIFont(name: "Raleway-Light", size: 24)
        otherLabel.titleLabel?.font = UIFont(name: "Raleway-Light", size: 18)
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
