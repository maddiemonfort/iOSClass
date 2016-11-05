//
//  FriendProfileViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Madeleine Monfort on 10/23/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class FriendCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    
}

class FriendProfileViewController: UIViewController, UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet var navBar: UINavigationItem!
    let reuseIdentifier = "FriendImageCell"
    var friendUser: PFUser!
    var userImagesArr = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBar.title = friendUser.username
        let query = PFQuery(className: "imagePosts")
        query.whereKey("username", equalTo: friendUser.username!)
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
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! FriendCell
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //deal with each segue
        if(segue.identifier == "FriendToProfile") {
            let PageVC: PageViewController = segue.destinationViewController as! PageViewController
            PageVC.currentPage = PFUser.currentUser()
        }
        else if(segue.identifier == "LOFriendProf") {
            PFUser.logOut()
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
