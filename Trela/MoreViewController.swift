//
//  MoreViewController.swift
//  Trela
//
//  Created by Kalissaac on 5/20/16.
//  Copyright © 2016 Kalissaac Corp. All rights reserved.
//

import UIKit
import Firebase

class MoreViewController: UITableViewController {
    
    @IBOutlet var MoreTableView: UITableView!
    @IBOutlet weak var chosenRadius: UILabel!
    @IBOutlet weak var chosenLanguage: UILabel!
    var lastSelection: NSIndexPath!
    var radiusIdMore:Int?
    var languageIdMore:Int?
    var mapIdMore:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()


    }
    
    /*
    override func viewWillAppear(animated: Bool) {
        
        if radiusIdMore == 0 {
            chosenRadius.text = "1 mile"
        } else if radiusIdMore == 1 {
            chosenRadius.text = "2 miles"
        } else if radiusIdMore == 2 {
            chosenRadius.text = "5 miles"
        } else if radiusIdMore == 3 {
            chosenRadius.text = "10 miles"
        } else if radiusIdMore == 4 {
            chosenRadius.text = "15 miles"
        } else {
            chosenRadius.text = ""
        }
        
        if languageIdMore == 0 {
            chosenLanguage.text = "English"
        } else if languageIdMore == 1 {
            chosenLanguage.text = "Español"
        } else if languageIdMore == 2 {
            chosenLanguage.text = "Français"
        } else {
            chosenLanguage.text = ""
        }
    }
    */

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 3 {
            if indexPath.row == 0 {
                self.MoreTableView.deselectRowAtIndexPath(indexPath, animated: true)
            } else if indexPath.row == 1 {
                UIApplication.sharedApplication().openURL(NSURL(string: "https://github.com/Kalissaac/Trela-iOS/issues")!)
                self.MoreTableView.deselectRowAtIndexPath(indexPath, animated: true)
            } else {
                return
            }
        } else {
            return
        }
        
    }
    
    /*override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.font = UIFont(name: "Raleway-Regular", size: 16)
        return cell
    }*/
    
    
    /*
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    */

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
}
