//
//  DetailAlertViewController.swift
//  Trela
//
//  Created by Kalissaac on 6/18/16.
//  Copyright © 2016 Kalissaac Corp. All rights reserved.
//

import UIKit

class DetailAlertViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    let dataDetailAlert = ["Alert Type", "Alert Location", "Alert Description", "Managing Team of Alert"]
    let dataDetailAlertDescription = ["", "", "", "Managing Team Organization of Alert"]

    var barFrame:CGRect?
    @IBOutlet weak var detailAlertTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // self.tabBarController?.tabBar.hidden=true
        if let tabBar=self.tabBarController?.tabBar {
            self.barFrame=tabBar.frame
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                let newBarFrame=CGRectMake(self.barFrame!.origin.x, self.view.frame.size.height, self.barFrame!.size.width, self.barFrame!.size.height)
                tabBar.frame=newBarFrame
                }, completion: { (Bool) -> Void in
                    tabBar.hidden=true
            })
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden=false;
        if self.barFrame != nil {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                let newBarFrame=CGRectMake(self.barFrame!.origin.x, self.view.frame.size.height-self.barFrame!.size.height, self.view.frame.size.width, self.barFrame!.size.height)
                self.tabBarController?.tabBar.frame=newBarFrame
            })
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("cellDetailAlertType", forIndexPath: indexPath)
            cell.textLabel?.text = dataDetailAlert[indexPath.row]
            cell.textLabel?.font = UIFont(name: "Raleway-Regular", size: 16)
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("cellDetailAlertLocation", forIndexPath: indexPath)
            cell.textLabel?.text = dataDetailAlert[indexPath.row]
            cell.textLabel?.font = UIFont(name: "Raleway-Regular", size: 16)
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCellWithIdentifier("cellDetailAlertDescription", forIndexPath: indexPath)
            cell.textLabel?.text = dataDetailAlert[indexPath.row]
            cell.textLabel?.font = UIFont(name: "Raleway-Regular", size: 16)
            return cell
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCellWithIdentifier("cellDetailAlertManagingTeam", forIndexPath: indexPath)
            cell.textLabel?.text = dataDetailAlert[indexPath.row]
            cell.textLabel?.font = UIFont(name: "Raleway-Regular", size: 16)
            cell.detailTextLabel?.text = dataDetailAlertDescription[indexPath.row]
            cell.detailTextLabel?.font = UIFont(name: "Raleway-Light", size: 11)
            return cell
        } else {
            let cell = UITableViewCell()
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.detailAlertTableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    /*func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 2 {
            
        } else if indexPath.row == 3 {
            
        } else {
            
        }
    }*/
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
