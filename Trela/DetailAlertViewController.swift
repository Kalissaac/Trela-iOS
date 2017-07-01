//
//  DetailAlertViewController.swift
//  Trela
//
//  Created by Kalissaac on 6/18/16.
//  Copyright © 2016 Kalissaac Corp. All rights reserved.
//

import UIKit
import Firebase

struct alertDetail {
    
    let title : String!
    let descriptionLong : String!
    let location : String!
    let type : String!
    let organization : String!
}

var alertID = 0

class DetailAlertViewController: UIViewController {
    
    @IBOutlet weak var detailAlertTableView: UITableView!
    var alertDetails = [alert]()
    
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
