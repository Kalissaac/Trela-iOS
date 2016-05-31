//
//  ListAlertViewController.swift
//  SmaLert
//
//  Created by Kian on 4/10/16.
//  Copyright © 2016 Kian Sutarwala. All rights reserved.
//

import UIKit

class ListAlertViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate {
    
    let dataListAlerts:[String] = ["SmaLert Alert 1", "SmaLert Alert 2", "SmaLert Alert 3", "SmaLert Alert 4", "SmaLert Alert 5"]
    let dataListAlertsDescription:[String] = ["SmaLert Alert Description 1", "SmaLert Alert Description 2", "SmaLert Alert Description 3", "SmaLert Alert Description 4", "SmaLert Alert Description 5"]
    // Make sure that dataListAlerts and dataListAlertsDescription have the same number of strings or the app will crash.
    
    // MARK: This is the search part of the table.
    
    @IBOutlet var alertTableView: UITableView!
    
    var friendsArray = [FriendItem]()
    var filteredFriends = [FriendItem]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.friendsArray += [FriendItem(name: "")]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: This is the cell part of the table.
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = alertTableView.dequeueReusableCellWithIdentifier("cellListAlert", forIndexPath: indexPath)
        cell.textLabel?.text = dataListAlerts[indexPath.row]
        cell.detailTextLabel?.text = dataListAlertsDescription[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataListAlerts.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.alertTableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}

