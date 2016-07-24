//
//  AlertListViewController.swift
//  Trela
//
//  Created by Kian on 7/22/16.
//  Copyright © 2016 Kalissaac Corp. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabaseUI

class AlertListViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet var alertTableView: UITableView!
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(AlertListViewController.handleRefresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh...")
        return refreshControl
    }()
    
    let firebaseRef = FIRDatabase.database().reference()
    var dataSource: FirebaseTableViewDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.alertTableView.rowHeight = UITableViewAutomaticDimension
        self.alertTableView.estimatedRowHeight = 140
        
        self.alertTableView.addSubview(self.refreshControl)
        
        self.dataSource = FirebaseTableViewDataSource(ref: self.firebaseRef, cellReuseIdentifier: "cellAlertList", view: self.alertTableView)
        self.dataSource.populateCellWithBlock { (cell: UITableViewCell, obj: NSObject) -> Void in
            let snap = obj as! FIRDataSnapshot
            
            // Populate cell as you see fit, like as below
            cell.textLabel?.text = snap.key as String
        }
        self.alertTableView.dataSource = self.dataSource
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.dataSource = FirebaseTableViewDataSource(ref: self.firebaseRef, cellReuseIdentifier: "cellAlertList", view: self.alertTableView)
        self.dataSource.populateCellWithBlock { (cell: UITableViewCell, obj: NSObject) -> Void in
            let snap = obj as! FIRDataSnapshot
            
            // Populate cell as you see fit, like as below
            cell.textLabel?.text = snap.key as String
        }
        self.alertTableView.dataSource = self.dataSource
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Refresh control delegate
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        // Do some reloading of data and update the table view's data source
        // Fetch more objects from a web service, for example...
        
        // TODO: - Reload data from Firebase
        
        self.alertTableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    
    // MARK: - Table view data source
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
     func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.alertTableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("alertDetailsSegue", sender: nil)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = alertTableView.dequeueReusableCellWithIdentifier("cellAlertList", forIndexPath: indexPath)
        self.dataSource = FirebaseTableViewDataSource(ref: self.firebaseRef, cellReuseIdentifier: "cellAlertList", view: self.alertTableView)
        self.dataSource.populateCellWithBlock { (cell: UITableViewCell, obj: NSObject) -> Void in
            let snap = obj as! FIRDataSnapshot
            
            // Populate cell as you see fit, like as below 
            cell.textLabel?.text = snap.key as String
        }
        self.alertTableView.dataSource = self.dataSource
        return cell
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
