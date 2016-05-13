//
//  SettingsViewController.swift
//  SmaLert
//
//  Created by Kian on 4/10/16.
//  Copyright © 2016 Kian Sutarwala. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Settings table data.
    let dataSettingsSec1:[String] = ["Map Type", "Home Location", "Setting 3", "Setting 4", "Setting 5"]
    let dataSettingsSec2:[String] = ["Setting 6", "Setting 7", "Setting 8", "Setting 9", "Setting 10"]
    let dataSettingsSec3:[String] = ["Terms and Conditions", "Privacy Policy"]
    let dataSettingsSec4:[String] = ["Help", "About", "Acknowledgements"]
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: This is the cell part of the table.
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellSetting", forIndexPath: indexPath)
        if indexPath.section == 0 {
            cell.textLabel?.text = dataSettingsSec1[indexPath.row]
        } else if indexPath.section == 1 {
            cell.textLabel?.text = dataSettingsSec2[indexPath.row]
        } else if indexPath.section == 2 {
            cell.textLabel?.text = dataSettingsSec3[indexPath.row]
        } else {
            cell.textLabel?.text = dataSettingsSec4[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return dataSettingsSec1.count
        } else if section == 1 {
            return dataSettingsSec2.count
        } else if section == 2 {
            return dataSettingsSec3.count
        } else {
            return dataSettingsSec4.count
        }
        
    }
    
    
    // MARK: This is the section part of the table.
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    
}

