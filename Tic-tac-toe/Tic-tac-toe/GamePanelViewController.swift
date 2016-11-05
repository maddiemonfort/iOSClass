//
//  GamePanelViewController.swift
//  Tic-tac-toe
//
//  Created by Madeleine Monfort on 9/20/15.
//  Copyright © 2015 Madeleine Monfort. All rights reserved.
//

import UIKit

class GamePanelViewController: UIViewController {

    @IBOutlet var PlayerTurn: UILabel!

    @IBOutlet var FinishButton: UIButton!
    
    @IBOutlet var I11: UIImageView!
    @IBOutlet var I12: UIImageView!
    @IBOutlet var I13: UIImageView!
    @IBOutlet var I21: UIImageView!
    @IBOutlet var I22: UIImageView!
    @IBOutlet var I23: UIImageView!
    @IBOutlet var I31: UIImageView!
    @IBOutlet var I32: UIImageView!
    @IBOutlet var I33: UIImageView!
    
    
    var p2name = ""
    var p1name = ""
    var Tokenp1 = ""
    var isP1Winner: Bool = false
    var isP2Winner: Bool = false
    
    var isTurnOne: Bool = true
    //keeping score
    var p1s: Int = 0
    var p2s: Int = 0
    
    //check tapped
    var tap11: Bool = false
    var tap12: Bool = false
    var tap13: Bool = false
    var tap21: Bool = false
    var tap22: Bool = false
    var tap23: Bool = false
    var tap31: Bool = false
    var tap32: Bool = false
    var tap33: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isTurnOne = true
        PlayerTurn.text = p1name
        
        if(Tokenp1 == "X") {
            //set image1 to X
            //set image2 to O
        }
        else {
            //set image1 to O
            //set image2 to X
        }
        FinishButton.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func T11(sender: AnyObject) {
        if(!tap11) {
            tap11 = true
            Tapping()
        }
    }
    
    @IBAction func T12(sender: AnyObject) {
        if(!tap12) {
            tap12 = true
            Tapping()
        }
    }
    
    @IBAction func T13(sender: AnyObject) {
        if(!tap13) {
            tap13 = true
            Tapping()
        }
    }
    
    @IBAction func T21(sender: AnyObject) {
        if(!tap21) {
            tap21 = true
            Tapping()
        }
    }
    
    @IBAction func T22(sender: AnyObject) {
        if(!tap22) {
            tap22 = true
            Tapping()
        }
    }
    
    @IBAction func T23(sender: AnyObject) {
        if(!tap23) {
            tap23 = true
            Tapping()
        }
    }
    
    @IBAction func T31(sender: AnyObject) {
        if(!tap31) {
            tap31 = true
            Tapping()
        }
    }
    
    @IBAction func T32(sender: AnyObject) {
        if(!tap32) {
            tap32 = true
            Tapping()
        }
    }
    
    @IBAction func T33(sender: AnyObject) {
        if(!tap33) {
            tap33 = true
            Tapping()
        }
    }
    
    func Tapping() {
        if(allTapped()) {
            FinishButton.hidden = false
        }
        if(isTurnOne) {
            //change image to Tokenp1
            PlayerTurn.text = p2name
        }
        else {
            //change image to Tokenp2
            PlayerTurn.text = p1name
        }
        isTurnOne = !isTurnOne
    }
    
    func allTapped() -> Bool{
        if(tap11 && tap12 && tap13 && tap21 && tap22 && tap23 && tap31 && tap32 && tap33) {
            return true
        }
        else {
           return false
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let scoreVC: ScoreSheet = segue.destinationViewController as! ScoreSheet
        scoreVC.p1name = p1name
        scoreVC.p2name = p2name
        scoreVC.p1score = 0
        scoreVC.p2score = 0
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
