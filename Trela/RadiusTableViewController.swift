//
//  RadiusTableViewController.swift
//  SmaLert
//
//  Created by Kalissaac on 6/4/16.
//  Copyright © 2016 Kalissaac Corp. All rights reserved.
//

import UIKit

class RadiusTableViewController: UITableViewController {
    
    var barFrame:CGRect?
    @IBOutlet var radiusTableView: UITableView!
    var radiusId:Int!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            radiusId = 0
            print("1 mile is the chosen radius. (radiusId: \(radiusId))")
            self.radiusTableView.deselectRowAtIndexPath(indexPath, animated: true)
        } else if indexPath.row == 1 {
            radiusId = 1
            print("2 miles is the chosen radius. (radiusId: \(radiusId))")
            self.radiusTableView.deselectRowAtIndexPath(indexPath, animated: true)
        } else if indexPath.row == 2 {
            radiusId = 2
            print("5 miles is the chosen radius. (radiusId: \(radiusId))")
            self.radiusTableView.deselectRowAtIndexPath(indexPath, animated: true)
        } else if indexPath.row == 3 {
            radiusId = 3
            print("10 miles is the chosen radius. (radiusId: \(radiusId))")
            self.radiusTableView.deselectRowAtIndexPath(indexPath, animated: true)
        } else {
            radiusId = 4
            print("15 miles is the chosen radius. (radiusId: \(radiusId))")
            self.radiusTableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    // MARK: - Table view data source

    /* 
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    } 
    */

    /* 
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    } 
    */

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()

        // Configure the cell...
        cell.textLabel?.font = UIFont(name: "Raleway-Regular", size: 16)

        return cell
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let DestViewController:SettingsViewController = segue.destinationViewController as! SettingsViewController
        DestViewController.radiusIdSettings! = radiusId!
    }
    */

}
