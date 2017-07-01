//
//  AlertListViewController.swift
//  Trela
//
//  Created by Kian on 7/22/16.
//  Copyright © 2016 Kalissaac Corp. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import Presentr

struct alert {
    
    let title : String!
    let descriptionShort : String!
}

class AlertListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var alertTableView: UITableView!
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(AlertListViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh...")
        return refreshControl
    }()

    var alerts = [alert]()
    
    var filteredAlerts = [String]()
    var filteredAlertsDescriptions = [String]()
    
    var alertID: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.alertTableView.rowHeight = UITableViewAutomaticDimension
        self.alertTableView.estimatedRowHeight = 140
        
        self.alertTableView.addSubview(self.refreshControl)
        
        let databaseRef = Database.database().reference()
        
        databaseRef.child("Init").observe(.childAdded, with: {
            snapshot in
            
            let value = snapshot.value as? NSDictionary
            
            let title = value?["title"] as? String
            
            let descriptionShort = value?["descriptionShort"] as? String
            
            self.alerts.insert(alert(title: title!, descriptionShort: descriptionShort!), at: 0)
            self.alertTableView.reloadData()
        })
        
        //newAlert()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let userDefaults = UserDefaults.standard
        if !userDefaults.bool(forKey: "notificationAsked") {
            delay(5) {
                let presenter: Presentr = {
                    let presenter = Presentr(presentationType: .alert)
                    presenter.transitionType = .coverVerticalFromTop // Optional
                    return presenter
                } ()
                let titleText = "We have to ask you..."
                let bodyText = "Would you like us to notify you when there is a new alert? We will only ask you this one time."
                let controller = Presentr.alertViewController(title: titleText, body: bodyText)
                let noAction = AlertAction(title: "Nope", style: .destructive) {
                    
                    userDefaults.set(true, forKey: "notificationAsked")
                    userDefaults.synchronize()
                    
                }
                let okAction = AlertAction(title: "Sure!", style: .cancel) {
                    
                    let notificationTypes: UIUserNotificationType = [UIUserNotificationType.alert, UIUserNotificationType.badge, UIUserNotificationType.sound]
                    let notificationSettings = UIUserNotificationSettings(types: notificationTypes, categories: nil)
                    UIApplication.shared.registerForRemoteNotifications()
                    UIApplication.shared.registerUserNotificationSettings(notificationSettings)
                    
                    userDefaults.set(true, forKey: "notificationAsked")
                    userDefaults.synchronize()
                }
                controller.addAction(noAction)
                controller.addAction(okAction)
                presenter.presentationType = .alert
                self.customPresentViewController(presenter, viewController: controller, animated: true, completion: nil)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Refresh control delegate
    
    func handleRefresh(_ refreshControl: UIRefreshControl) {
        // Do some reloading of data and update the table view's data source
        // Fetch more objects from a web service, for example...
        
        // TODO: - Reload data from Firebase
        
        self.alertTableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    
    // MARK: - Table view data source
    
    func newAlert() {
        
        let title = "Title"
        let descriptionShort = "Short"
        let descriptionLong = "Short"
        let location = "1 World Way Los Angeles, CA 90045"
        let type = "The type"
        let organization = "the organization"
        
        let alert: [String: AnyObject] = ["title" : title as AnyObject, "descriptionShort" : descriptionShort as AnyObject, "descriptionLong" : descriptionLong as AnyObject, "location" : location as AnyObject, "type" : type as AnyObject, "organization" : organization as AnyObject]
        let databaseRef = Database.database().reference()
        databaseRef.child("Init").childByAutoId().setValue(alert)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if tableView == self.alertTableView {
            return alerts.count
        } else {
            return filteredAlerts.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellAlertList", for: indexPath)
        cell.textLabel?.text = alerts[indexPath.row].title
        cell.detailTextLabel?.text = alerts[indexPath.row].descriptionShort
        
        return cell
        
        /*if tableView == self.alertTableView {
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
        }*/
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.alertTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        self.performSegue(withIdentifier: "alertDetailsSegue", sender: nil)
        
        
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "alertDetailsSegue" {
            
            alertID = 1
            
        }
    }
    
    
}
