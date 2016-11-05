//
//  P2ViewController.swift
//  Tic-tac-toe
//
//  Created by Madeleine Monfort on 9/20/15.
//  Copyright © 2015 Madeleine Monfort. All rights reserved.
//

import UIKit

class P2ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var Player2: UITextField!
    var p1name = ""
    var p1Token = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func BeginGame(sender: AnyObject) {
        performSegueWithIdentifier("StartGame", sender: nil)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        Player2.resignFirstResponder()
        return false
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let gameVC: GamePanelViewController = segue.destinationViewController as! GamePanelViewController
        
        gameVC.p1name = p1name
        gameVC.p2name = Player2.text!
        gameVC.Tokenp1 = p1Token
    
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
