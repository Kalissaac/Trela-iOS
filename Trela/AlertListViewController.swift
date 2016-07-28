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
import Presentr

class AlertListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var alertTableView: UITableView!
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(AlertListViewController.handleRefresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh...")
        return refreshControl
    }()
    
    var firebaseRef: FIRDatabaseReference!
    var database: FIRDatabase!
    var dataSource: FirebaseTableViewDataSource!
    
    let dataListAlerts:[String] = ["Trela Alert 1", "Trela Alert 2", "Trela Alert 3", "Trela Alert 4", "Trela Alert 5"]
    let dataListAlertsDescription:[String] = ["Trela Alert Description 1", "Trela Alert Description 2", "Trela Alert Description 3", "Trela Alert Description 4", "Trela Alert Description 5"]
    // Make sure that dataListAlerts and dataListAlertsDescription have the same number of strings or the app will crash.
    var filteredAlerts = [String]()
    var filteredAlertsDescriptions = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.alertTableView.rowHeight = UITableViewAutomaticDimension
        self.alertTableView.estimatedRowHeight = 140
        
        self.alertTableView.addSubview(self.refreshControl)
        
        self.firebaseRef = FIRDatabase.database().referenceFromURL("https://trela-9a57f.firebaseio.com/alert-text")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //ARSLineProgress.show()
        /*self.dataSource = FirebaseTableViewDataSource(ref: self.firebaseRef, cellReuseIdentifier: "cellAlertList", view: self.alertTableView)
         self.dataSource.populateCellWithBlock { (cell: UITableViewCell, obj: NSObject) -> Void in
         let snap = obj as! FIRDataSnapshot
         
         // Populate cell as you see fit, like as below
         cell.textLabel?.text = snap.key as String
         }
        self.alertTableView.dataSource = self.dataSource*/
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if !userDefaults.boolForKey("notificationAsked") {
            delay(5) {
                let presenter: Presentr = {
                    let presenter = Presentr(presentationType: .Alert)
                    presenter.transitionType = .CoverVerticalFromTop // Optional
                    return presenter
                } ()
                let titleText = "We have to ask you..."
                let bodyText = "Would you like us to notify you when there is a new alert? We will only ask you this one time."
                let controller = Presentr.alertViewController(title: titleText, body: bodyText)
                let noAction = AlertAction(title: "Nope", style: .Destructive) {
                    
                    userDefaults.setBool(true, forKey: "notificationAsked")
                    userDefaults.synchronize()
                    
                }
                let okAction = AlertAction(title: "Sure!", style: .Cancel) {
                    
                    let notificationTypes: UIUserNotificationType = [UIUserNotificationType.Alert, UIUserNotificationType.Badge, UIUserNotificationType.Sound]
                    let notificationSettings = UIUserNotificationSettings(forTypes: notificationTypes, categories: nil)
                    UIApplication.sharedApplication().registerForRemoteNotifications()
                    UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
                    
                    userDefaults.setBool(true, forKey: "notificationAsked")
                    userDefaults.synchronize()
                }
                controller.addAction(noAction)
                controller.addAction(okAction)
                presenter.presentationType = .Alert
                self.customPresentViewController(presenter, viewController: controller, animated: true, completion: nil)
            }
        }
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
        if tableView == self.alertTableView {
            return dataListAlerts.count
        } else {
            return filteredAlerts.count
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView == self.alertTableView {
            let cell = tableView.dequeueReusableCellWithIdentifier("cellAlertList", forIndexPath: indexPath)
            cell.textLabel?.text = dataListAlerts[indexPath.row]
            cell.textLabel?.font = UIFont(name: "Raleway-Regular", size: 15)
            cell.detailTextLabel?.text = dataListAlertsDescription[indexPath.row]
            cell.detailTextLabel?.font = UIFont(name: "Raleway-Light", size: 11)
            return cell
        } else {
            let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cellFilteredAlertList")
            cell.textLabel?.text = filteredAlerts[indexPath.row]
            cell.textLabel?.font = UIFont(name: "Raleway-Regular", size: 16)
            cell.detailTextLabel?.text = filteredAlertsDescriptions[indexPath.row]
            cell.detailTextLabel?.font = UIFont(name: "Raleway-Light", size: 11)
            cell.accessoryType = .DetailButton
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.alertTableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("alertDetailsSegue", sender: nil)
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
