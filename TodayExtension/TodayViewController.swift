//
//  TodayViewController.swift
//  TodayExtension
//
//  Created by Kian on 7/22/16.
//  Copyright © 2016 Kalissaac Corp. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet weak var allAlertsButton: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        
        allAlertsButton.titleLabel?.font = UIFont(name: "Raleway-Regular", size: 15)
    }
    
    @IBAction func didTapButton(sender: AnyObject) {
        let openURL = NSURL(string: "Trela://AllAlerts")
        self.extensionContext?.openURL(openURL!, completionHandler: nil)
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
    
}
