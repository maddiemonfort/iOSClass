//
//  PageViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Madeleine Monfort on 10/18/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class InstaViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    
}

class PageViewController: UIViewController, UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var navBar: UINavigationItem!
    var currentUser = PFUser.currentUser()!
    var currentPage: PFUser!
    
    let reuseIdentifier = "ImageCell"
    var userImagesArr = [PFObject]()
    
    @IBOutlet var rightButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.title = currentPage.username
        
        //query for array of images
        let query = PFQuery(className: "imagePosts")
        query.whereKey("username", equalTo: currentPage.username!)
        do {
            userImagesArr = try query.findObjects()
        }
        catch {
            print("There was an error")
        }
        // Do any additional setup after loading the view.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userImagesArr.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! InstaViewCell
        cell.backgroundColor = UIColor.blackColor()
        //use image array for cell's image
        let usrImg = userImagesArr[indexPath.item]
        let img = usrImg["image"] as! PFFile
        do {
            let imageData = try img.getData()
            let finalImg = UIImage(data: imageData)
            cell.imageView.image = finalImg
        }
        catch {
            print("no image.")
        }
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addFriends(sender: AnyObject) {
        if rightButton.title == "Add Friends" {
            performSegueWithIdentifier("SeeUsers", sender: nil)
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "SeeUsers") {
            let query = PFQuery(className: "_User")
            do {
                let userArray = try query.findObjects()
                let UsersVC: UsersViewController = segue.destinationViewController as! UsersViewController
                UsersVC.users = userArray
            }
            catch {
                print("There was an error")
            }
        }
        else if(segue.identifier == "LogOut") {
            PFUser.logOut()
        }
        else if(segue.identifier == "SeeFriends") {
            let Cusername:String = currentUser.username!
            let friendPredicate = NSPredicate(format: "YourUsername = '\(Cusername)'")
            let query = PFQuery(className: "Friends", predicate: friendPredicate)
            //let query = PFQuery(className: "Friends")
            //query.wherekey()--- instead of predicates
            do {
                let friendArray = try query.findObjects()
                let FriendVC: FriendListViewController = segue.destinationViewController as! FriendListViewController
                FriendVC.friends = friendArray
            }
            catch {
                print("There was an error")
            }
        }
        else {
            print("uploading image!")
        }
    }

    /*
    Collection View Controller and function ideas used from http://www.raywenderlich.com/78550/beginning-ios-collection-views-swift-part-1
    */

}
