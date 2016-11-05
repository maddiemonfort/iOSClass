//
//  ImageViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Madeleine Monfort on 10/21/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class ImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var imageView: UIImageView!
    var picker = UIImagePickerController()
    var selectedImage = UIImage()
    @IBOutlet var SaveMsg: UILabel!
    
    @IBAction func UploadImage(sender: AnyObject) {
        picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        picker.allowsEditing = true
        self.presentViewController(picker, animated: true, completion: nil)
    }
    @IBAction func addImage(sender: AnyObject) {
        let imagePosts = PFObject(className: "imagePosts")
        //imagePosts["imageName"] = image.description
        //print(image.description)
        let imageData = UIImagePNGRepresentation(selectedImage)
        let file = PFFile(data: imageData!)
        imagePosts["image"] = file
        imagePosts["username"] = PFUser.currentUser()?.username
        
        imagePosts.saveInBackgroundWithBlock {
            (success: Bool, error:NSError?) ->Void in
            
            if(success) {
                //we saved our information
                self.SaveMsg.text = "Image uploaded successfully"
            }
            else {
                //there was a problem
                self.SaveMsg.text = "Error: \(error?.description)"
            }
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.dismissViewControllerAnimated(true, completion: nil)
        imageView.image = image
        selectedImage = image
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "ImageToProfile") {
            let PageVC: PageViewController = segue.destinationViewController as! PageViewController
            PageVC.currentPage = PFUser.currentUser()
        }
        else if(segue.identifier == "LOImages") {
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
