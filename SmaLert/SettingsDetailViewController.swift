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
    let dataSettingsDetail:[String] = ["Standard", "Satellite", "Hybrid"]

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
        let cell = tableView.dequeueReusableCellWithIdentifier("cellUnSelected", forIndexPath: indexPath)
        cell.textLabel?.text = dataSettingsDetail[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return dataSettingsDetail.count
    }
    
    
    var lastSelection: NSIndexPath!
    
    @IBOutlet weak var myTableView: UITableView!
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if self.lastSelection != nil {
            self.myTableView.cellForRowAtIndexPath(self.lastSelection)?.accessoryType = .None
        }
        
        self.myTableView.cellForRowAtIndexPath(indexPath)?.accessoryType = .Checkmark
        
        self.lastSelection = indexPath
        
        self.myTableView.deselectRowAtIndexPath(indexPath, animated: true)
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
