/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var ErrMess: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        username.delegate = self
        password.delegate = self
    }
    
    @IBAction func SignIn(sender: AnyObject) {
        if username.text != "" && password.text != "" {
            PFUser.logInWithUsernameInBackground (username.text!, password: password.text!) {
                (user: PFUser?, error: NSError?) -> Void in
                if user != nil {
                    //Do stuff after successful login.
                    //print("You logged in!!")
                    self.performSegueWithIdentifier("SignIn", sender: nil)
                }
                else {
                    self.ErrMess.text = error?.description
                }
            }
            
        }
        else {
            ErrMess.text = "Please fill in all text fields."
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SignIn" {
            let PageVC: PageViewController = segue.destinationViewController as! PageViewController
            PageVC.currentPage = PFUser.currentUser()
        }
        //for other segue, do nothing
    }

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
}
