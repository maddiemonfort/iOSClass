//
//  UsersViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Madeleine Monfort on 10/18/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class UsersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var users = [PFObject]()
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        let userInfo: PFObject = users[indexPath.row]
        cell.textLabel?.text = String(userInfo["username"])
        return cell
    }
    
    func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        let userInfo: PFObject = users[indexPath.row] as PFObject
        let friends = PFObject(className: "Friends")
        
        let cu = PFUser.currentUser()?.username
        let fru = String(userInfo["username"])
        //need to check if already exits. and make sure not to add self to list
        if(!friendDoesExist(fru)) {
            if(cu == fru) {
                //alert
                displayAlert("Cannot add yourself as friend", line2: "")
                return
            }
            friends["YourUsername"] = cu
            friends["FriendUsername"] = fru
        
            friends.pinInBackground()
            friends.saveInBackgroundWithBlock {
                (success: Bool, error:NSError?) -> Void in
                
                if(success) {
                    //we saved our information
                    print("Success")
                }
                else {
                    //there was a problem
                    print("Error: \(error?.localizedDescription)")
                }
            }
        }
        else {
            //show alert
            displayAlert("Friend already exists", line2: "")
        }
        
    }
    
    func friendDoesExist(friendName: String) -> Bool {
        let query = PFQuery(className: "Friends")
        query.whereKey("YourUsername", equalTo: PFUser.currentUser()!.username!)
        do {
            let friendArr = try query.findObjects()
            for i in friendArr {
                if( String(i["FriendUsername"]) == friendName) {
                    return true
                }
            }
        }
        catch {
            print("There was an error")
        }
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "DoneUsers") {
            let PageVC: PageViewController = segue.destinationViewController as! PageViewController
            PageVC.currentPage = PFUser.currentUser()
        }
        else if(segue.identifier == "LOUsers") {
            PFUser.logOut()
        }
    }
    
    func displayAlert(line1: String, line2: String) {
        if #available(iOS 8.0, *) {
            let alertController = UIAlertController(title: line1, message: line2, preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        } else {
            // Fallback on earlier versions
        }
        
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
