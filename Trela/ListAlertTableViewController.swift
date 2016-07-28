//
//  ListAlertTableViewController.swift
//  Trela
//
//  Created by Kalissaac on 5/24/16.
//  Copyright © 2016 Kalissaac Corp. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseDatabaseUI

class ListAlertTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var barFrame:CGRect?
    @IBOutlet var alertTableView: UITableView!
    var searchController: UISearchController!
    var resultsController = UITableViewController()
    
    let dataListAlerts:[String] = ["Trela Alert 1", "Trela Alert 2", "Trela Alert 3", "Trela Alert 4", "Trela Alert 5"]
    let dataListAlertsDescription:[String] = ["Trela Alert Description 1", "Trela Alert Description 2", "Trela Alert Description 3", "Trela Alert Description 4", "Trela Alert Description 5"]
    // Make sure that dataListAlerts and dataListAlertsDescription have the same number of strings or the app will crash.
    var filteredAlerts = [String]()
    var filteredAlertsDescriptions = [String]()
    
    //let ref = Firebase(url: "https://Trela-16111.firebaseio.com/alerts")


    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.resultsController.tableView.dataSource = self
        self.resultsController.tableView.delegate = self
        self.searchController = UISearchController(searchResultsController: self.resultsController)
        self.alertTableView.tableHeaderView = self.searchController.searchBar
        self.searchController.searchBar.tintColor = UIColor.redColor()
        self.resultsController.tableView.tintColor = UIColor.redColor()
        self.searchController.searchResultsUpdater = self
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search Alerts"
        self.searchController.searchBar.returnKeyType = .Search
        definesPresentationContext = true
        
        self.alertTableView.rowHeight = UITableViewAutomaticDimension
        self.alertTableView.estimatedRowHeight = 140
        self.refreshControl?.addTarget(self, action: #selector(ListAlertTableViewController.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        refreshControl!.attributedTitle = NSAttributedString(string: "Pull to refresh...")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Search bar delegate
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        self.filteredAlerts = self.dataListAlerts.filter { (alert:String) -> Bool in
            if alert.lowercaseString.containsString(self.searchController.searchBar.text!.lowercaseString) {
                return true
            } else {
                return false
            }
        }
        self.filteredAlertsDescriptions = self.dataListAlertsDescription.filter { (alertDescription:String) -> Bool in
            if alertDescription.lowercaseString.containsString(self.searchController.searchBar.text!.lowercaseString) {
                return true
            } else {
                return false
            }
        }
        self.resultsController.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("alertDetailsSegue", sender: nil)
    }

    // MARK: - Table view data source
    
    func refresh(sender:AnyObject) {
        // Updating your data here...
        delay(2, closure: { () -> () in
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        })
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if tableView == self.tableView {
            return dataListAlerts.count
        } else {
            return filteredAlerts.count
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView == self.tableView {
            let cell = tableView.dequeueReusableCellWithIdentifier("cellListAlert", forIndexPath: indexPath)
            cell.textLabel?.text = dataListAlerts[indexPath.row]
            cell.textLabel?.font = UIFont(name: "Raleway-Regular", size: 15)
            cell.detailTextLabel?.text = dataListAlertsDescription[indexPath.row]
            cell.detailTextLabel?.font = UIFont(name: "Raleway-Light", size: 11)
            return cell
        } else {
            let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cellFilteredListAlert")
            cell.textLabel?.text = filteredAlerts[indexPath.row]
            cell.textLabel?.font = UIFont(name: "Raleway-Regular", size: 16)
            cell.detailTextLabel?.text = filteredAlertsDescriptions[indexPath.row]
            cell.detailTextLabel?.font = UIFont(name: "Raleway-Light", size: 11)
            cell.accessoryType = .DetailButton
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.alertTableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
