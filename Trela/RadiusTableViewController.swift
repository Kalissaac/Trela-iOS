//
//  RadiusTableViewController.swift
//  Trela
//
//  Created by Kalissaac on 6/4/16.
//  Copyright © 2016 Kalissaac Corp. All rights reserved.
//

import UIKit

class RadiusTableViewController: UITableViewController {
    
    var lastSelection: IndexPath!
    let userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCell = self.tableView!.cellForRow(at: indexPath)
        let selectedRadiusName = selectedCell!.textLabel!.text!
        
        userDefaults.set(indexPath.row, forKey: "radius")
        userDefaults.synchronize()
        
        print("\(selectedRadiusName) is the chosen radius.")
        
        if self.lastSelection != nil {
            self.tableView.cellForRow(at: self.lastSelection)?.accessoryType = .none
        }
        self.tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        self.lastSelection = indexPath
        
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return radiusIDs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "cellRadius", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = radiusIDs[indexPath.row]
        
        if userDefaults.string(forKey: "radius") == "\(indexPath.row)" {
            cell.accessoryType = .checkmark
            self.lastSelection = indexPath
        }
        cell.textLabel?.font = UIFont(name: "Raleway-Regular", size: 16)

        return cell
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
        let DestViewController:SettingsViewController = segue.destinationViewController as! SettingsViewController
        DestViewController.radiusIdSettings! = radiusId!
    }
    */

}
