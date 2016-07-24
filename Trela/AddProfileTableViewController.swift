//
//  AddProfileTableViewController.swift
//  SmaLert
//
//  Created by Kalissaac on 6/24/16.
//  Copyright © 2016 Kalissaac Corp. All rights reserved.
//

import UIKit

class AddProfileTableViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet var addProfileTableView: UITableView!
    @IBOutlet weak var idField: UITextField!
    @IBOutlet weak var codeField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBAction func cancelButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func didTapSave(sender: AnyObject) {
        // TODO: - Add new profile here
        if idField.text == "" && codeField.text == "" {
            self.dismissViewControllerAnimated(true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "Oops!", message: "The profile identifier and/or verification code you entered were not reconized!", preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "Try again", style: .Cancel) { (action) in
            }
            alertController.addAction(cancelAction)
            self.presentViewController(alertController, animated: true) {
            }
        }
    }

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
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == idField { // Switch focus to other text field
            codeField.becomeFirstResponder()
        }
        return true
    }

    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 1 {
            self.addProfileTableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }

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
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

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
    }
    */

}
