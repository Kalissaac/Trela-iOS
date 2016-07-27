//
//  ProfilesViewController.swift
//  Trela
//
//  Created by Kian on 7/14/16.
//  Copyright © 2016 Kalissaac Corp. All rights reserved.
//

import UIKit
import Firebase

class ProfilesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var barFrame:CGRect?
    var dataProfiles = ["Trela Profile 1", "Trela Profile 2", "Trela Profile 3", "Trela Profile 4", "Trela Profile 5"]
    var dataProfilesAdd = ["Add New Profile..."]
    @IBOutlet weak var profilesTableView: UITableView!
    @IBOutlet weak var profileImageView: ContactImageView!
    
    
     override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        /*profileImageView.setImageText(text: (FIRAuth.auth()?.currentUser?.email)!, backgroundImage: UIImage(named: "Person"), username: true, textColor: UIColor.whiteColor(), fillColor: UIColor.blackColor(), circle: true)
        */
    }

     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return dataProfiles.count
        } else {
            return dataProfilesAdd.count
        }
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("cellProfileAbout", forIndexPath: indexPath)
            //cell.imageView.setImageText(text: (FIRAuth.auth()?.currentUser?.email)!, backgroundImage: UIImage(named: "Person"), username: true, textColor: UIColor.whiteColor(), fillColor: UIColor.blackColor(), circle: true)
            cell.textLabel?.text = FIRAuth.auth()?.currentUser?.email
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("cellProfile", forIndexPath: indexPath)
            cell.textLabel?.text = dataProfiles[indexPath.row]
            cell.textLabel?.font = UIFont(name: "Raleway-Regular", size: 16)
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("cellProfileAdd", forIndexPath: indexPath)
            cell.textLabel?.text = dataProfilesAdd[indexPath.row]
            cell.textLabel?.font = UIFont(name: "Raleway-Regular", size: 16)
            return cell
        }
    }
    
    
    //  to support conditional editing of the table view.
     func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        if indexPath.section == 0 {
            return true
        } else {
            return false
        }
    }
    
    //  to support editing the table view.
     func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
     func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.profilesTableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    /*
    //  to support rearranging the table view.
     func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    //  to support conditional rearranging of the table view.
     func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
     func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
