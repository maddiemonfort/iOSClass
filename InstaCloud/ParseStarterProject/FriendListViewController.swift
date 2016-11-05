//
//  FriendListViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Madeleine Monfort on 10/19/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class FriendListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var friends = [PFObject]()
    var selected: PFUser!
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let friendInfo:PFObject = friends[indexPath.row] as PFObject
        cell.textLabel?.text = String(friendInfo["FriendUsername"])
        return cell
    }
    
    func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        let friendInfo:PFObject = friends[indexPath.row] as PFObject
        let query = PFQuery(className: "_User")
        query.whereKey("username", equalTo: friendInfo["FriendUsername"])
        do {
            var selectedUsers = try query.findObjects()
            selected = selectedUsers[0] as! PFUser
        }
        catch {
            print("Username couldn't be located")
        }
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
        if(segue.identifier == "FriendPage") { //goes to friend page
            let PageVC: FriendProfileViewController = segue.destinationViewController as! FriendProfileViewController
            PageVC.friendUser = selected
        }
        else if(segue.identifier == "LOFriends") {
            PFUser.logOut()
        }
        else if(segue.identifier == "FriendToProfile") {
            let PageVC: PageViewController = segue.destinationViewController as! PageViewController
            PageVC.currentPage = PFUser.currentUser()
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
