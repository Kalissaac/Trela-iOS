//
//  ProfilesViewController.swift
//  Trela
//
//  Created by Kian on 7/14/16.
//  Copyright © 2016 Kalissaac Corp. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

struct profile {
    
    let title : String!
}

class ProfilesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var dataProfilesAdd = ["Add New Profile..."]
    @IBOutlet weak var profilesTableView: UITableView!
    
    @IBOutlet var profileImageView: ContactImageView!
    
    var profiles = [profile]()
    
     override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        newProfile()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let databaseRef = Database.database().reference()
        databaseRef.child("Profile").queryOrderedByKey().observe(.childAdded, with: {
            snapshot in
            
            let value = snapshot.value as? NSDictionary

            let title = value?["title"] as! String
            
            self.profiles.insert(profile(title: title), at: 0)
            self.profilesTableView.reloadData()
        })
        
        profileImageView.setImageText((Auth.auth().currentUser?.email)!, backgroundImage: UIImage(named: "Person"), username: true, textColor: UIColor.white, fillColor: UIColor.black, circle: true)
    }

     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func newProfile() {
        
        let title = "Example Profile"
        let identifier = "Trela.example.com"
        let verificationCode = "123456"
        
        let profile: [String: AnyObject] = ["title" : title as AnyObject, "identifier" : identifier as AnyObject, "verificationCode" : verificationCode as AnyObject]
        let databaseRef = Database.database().reference()
        databaseRef.child("Profiles").childByAutoId().setValue(profile)
    }
    
    // MARK: - Table view data source
    
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return profiles.count
        } else {
            return dataProfilesAdd.count
        }
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellProfileAbout", for: indexPath)
            //cell.imageView.setImageText(text: (FIRAuth.auth()?.currentUser?.email)!, backgroundImage: UIImage(named: "Person"), username: true, textColor: UIColor.whiteColor(), fillColor: UIColor.blackColor(), circle: true)
            cell.textLabel?.text = Auth.auth().currentUser?.email
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellProfile", for: indexPath)
            cell.textLabel?.text = profiles[indexPath.row].title
            cell.textLabel?.font = UIFont(name: "Raleway-Regular", size: 16)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellProfileAdd", for: indexPath)
            cell.textLabel?.text = dataProfilesAdd[indexPath.row]
            cell.textLabel?.font = UIFont(name: "Raleway-Regular", size: 16)
            return cell
        }
    }
    
    
    //  to support conditional editing of the table view.
     func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        if indexPath.section == 0 {
            return true
        } else {
            return false
        }
    }
    
    //  to support editing the table view.
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.profilesTableView.deselectRow(at: indexPath, animated: true)
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
