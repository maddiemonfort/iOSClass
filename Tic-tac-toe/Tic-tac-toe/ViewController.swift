//
//  ViewController.swift
//  Tic-tac-toe
//
//  Created by Madeleine Monfort on 9/11/15.
//  Copyright © 2015 Madeleine Monfort. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var Player1: UITextField!
    
    @IBOutlet var Os: UIImageView!
    @IBOutlet var Xs: UIImageView!
    @IBOutlet var button: UIButton!
    
    
    var p1Token = "X"; //default in case they dont choose
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        Player1.resignFirstResponder();
        return false;
    }
    
    @IBAction func EnterP1(sender: AnyObject) {
        //segues
        performSegueWithIdentifier("player2", sender: nil)
    }

    //pick X/O
    @IBAction func EnterX(sender: AnyObject) {
        //set p1 to X and p2 to O
        p1Token = "X";
        //grey out X
        self.Xs.hidden = true
        self.Os.hidden = false
    }
    
    @IBAction func EnterO(sender: AnyObject) {
        //set pi1 to O and p2 to X
        p1Token = "O"
        //grey out O
        Os.hidden = true;
        Xs.hidden = false
    }
    
    //prep to send info to Player2
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let p2VC: P2ViewController = segue.destinationViewController as! P2ViewController
        p2VC.p1name = Player1.text!
        p2VC.p1Token = p1Token
    }

}

