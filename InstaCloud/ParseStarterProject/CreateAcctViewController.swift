//
//  CreateAcctViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Madeleine Monfort on 10/17/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class CreateAcctViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var errorMess: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        username.delegate = self
        password.delegate = self
        email.delegate = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func SignUp(sender: AnyObject) {
        //check to see if data is there
        if(username.text != "" && password.text != "" && email.text != "") {
            let user = PFUser()
            user.username = username.text
            user.password = password.text
            user.email = email.text
        
            user.signUpInBackgroundWithBlock {
                (succeeded: Bool, error:NSError?) -> Void in
            
                if error == nil {
                    //User added
                    //self.errorMess.text = "Account added"
                    self.performSegueWithIdentifier("AcctCreated", sender: nil)
                }
                else {
                    self.errorMess.text = error?.description
                }
            }
        }
        else {
            self.errorMess.text = "Please fill in all fields."
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "AcctCreated") {
            let PageVC: PageViewController = segue.destinationViewController as! PageViewController
            PageVC.currentPage = PFUser.currentUser()
        }
    }
    
//------------------------

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
