//
//  ListAlertViewController.swift
//  SmaLert
//
//  Created by Kian on 4/10/16.
//  Copyright © 2016 Kian Sutarwala. All rights reserved.
//

import UIKit

class ListAlertViewController: UIViewController, UITableViewDataSource {
    
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
        let cell = UITableViewCell()
        cell.textLabel?.text = "Map Type"
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    // This is the section part of the table.
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return ["Section 1", "Section 2"]
    }



}

