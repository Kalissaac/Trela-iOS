//
//  SettingsDetailViewController.swift
//  SmaLert
//
//  Created by Kian on 5/10/16.
//  Copyright © 2016 Kian Sutarwala. All rights reserved.
//

import UIKit
import MapKit

class SettingsDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    // Settings Details table data.
    let dataSettingsDetailSec1:[String] = ["Standard", "Satellite", "Hybrid"]
    let dataSettingsDetailSec2:[String] = ["Setting 6", "Setting 7", "Setting 8", "Setting 9", "Setting 10"]
    let dataSettingsDetailSec3:[String] = ["Terms and Conditions", "Privacy Policy"]
    let dataSettingsDetailSec4:[String] = ["Help", "About", "Acknowledgements"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: This is the cell part of the table.
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellSelected", forIndexPath: indexPath)
        if indexPath.section == 0 {
            cell.textLabel?.text = dataSettingsDetailSec1[indexPath.row]
        }
        else if indexPath.section == 1 {
            cell.textLabel?.text = dataSettingsDetailSec2[indexPath.row]
        }
        else if indexPath.section == 2 {
            cell.textLabel?.text = dataSettingsDetailSec3[indexPath.row]
        }
        else {
            cell.textLabel?.text = dataSettingsDetailSec4[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return dataSettingsDetailSec1.count
        }
        else if section == 1 {
            return dataSettingsDetailSec2.count
        }
        else if section == 2 {
            return dataSettingsDetailSec3.count
        }
        else {
            return dataSettingsDetailSec4.count
        }
        
    }
    
    
    // MARK: This is the section part of the table.
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 1 {
               return
            }
            else {
                return
            }
        }
        else {
            return
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
