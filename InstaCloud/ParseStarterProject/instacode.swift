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