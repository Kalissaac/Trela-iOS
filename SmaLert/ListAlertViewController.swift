//
//  ListAlertViewController.swift
//  SmaLert
//
//  Created by Kian on 4/10/16.
//  Copyright © 2016 Kian Sutarwala. All rights reserved.
//

import UIKit

class ListAlertViewController: UIViewController, UITableViewDataSource {
    
    let dataListAlerts:[String] = ["SmaLert Alert 1", "SmaLert Alert 2", "SmaLert Alert 3", "SmaLert Alert 4", "SmaLert Alert 5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // This is the cell part of the table.
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellListAlert", forIndexPath: indexPath)
        cell.textLabel?.text = dataListAlerts[indexPath.row]
        cell.detailTextLabel?.text = "SmaLert Alert Description"
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataListAlerts.count
    }
    
}

