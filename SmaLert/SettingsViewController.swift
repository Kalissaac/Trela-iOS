//
//  SettingsViewController.swift
//  SmaLert
//
//  Created by Kian on 4/22/16.
//  Copyright © 2016 Kian Sutarwala. All rights reserved.
//

import UIKit
import iAd

class SecondViewController: UIViewController, UITableViewDataSource {
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Map Type"
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
}

