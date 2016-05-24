//
//  TodayViewController.swift
//  SmaLert Today Extension
//
//  Created by Kian on 5/23/16.
//  Copyright © 2016 Kian Sutarwala. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    
    @IBAction func actionAllAlerts(sender: UIButton) {
        let openURL = NSURL (string: "SmaLert://AllAlerts")
        self.extensionContext?.openURL(openURL!, completionHandler: nil)
    }
    
}
