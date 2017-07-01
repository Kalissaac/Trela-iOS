//
//  LanguageTableViewController.swift
//  Trela
//
//  Created by Kalissaac on 6/4/16.
//  Copyright © 2016 Kalissaac Corp. All rights reserved.
//

import UIKit

class LanguageTableViewController: UITableViewController {

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
        let selectedLanguageName = selectedCell!.textLabel!.text!
        
        userDefaults.set(indexPath.row, forKey: "language")
        userDefaults.synchronize()
        
        print("\(selectedLanguageName) is the selected language.")
        
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
        
        return languageIDs.count
    }
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "cellLanguage", for: indexPath)
     
     // Configure the cell...
        
        cell.textLabel?.text = languageIDs[indexPath.row]
        
        if userDefaults.string(forKey: "language") == "\(indexPath.row)" {
            cell.accessoryType = .checkmark
            self.lastSelection = indexPath
        }
     
     return cell
     }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
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
        if segue.identifier == "languageSegue" {
            let DestViewController = segue.destinationViewController as! SettingsViewController
            DestViewController.languageIdSettings = languageId!
        }
    }
    */

}
