//
//  ViewController.swift
//  Horoscope2
//
//  Created by Madeleine Monfort on 9/3/15.
//  Copyright © 2015 Madeleine Monfort. All rights reserved.
//

//used September 3rd date for horoscopes
import UIKit

class ViewController: UIViewController {

    @IBOutlet var month: UITextField!
    @IBOutlet var day: UITextField!
    
    @IBOutlet var sign: UILabel!
    @IBOutlet var horoscope: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //take month and day and get horoscope & sign
    @IBAction func pressButton(sender: AnyObject) {
        //validate entry
        if(month.text == "" && day.text == "") {
            month.text = "Please enter month of birth"
            day.text = "Please enter day of birth"
        }
        else {
           //validate it's an actual date
            if(isDate()) {
                //get horoscope and sign
                getsign()
                getHoroscope()
            }
            else {
                day.text = "Please enter a valid number"
            }
        }
    }
    //includes Leap Year
    func isDate() -> Bool {
        var monthEnd = 31
        
        if(isNotFullMonth()) {
            if(month.text == "Feb" || month.text == "February") {
                monthEnd = 29
            }
            else {
                monthEnd = 30
                
            }
        }
        else {
            monthEnd = 31
        }
        
        if (isNumber(day.text!)) {
            let num = Int(day.text!)
            if(num > 0 && num <= monthEnd) {
                return true
            }
            else {
                return false
            }
        }
        else {
            return false
        }
        
    }
    
    func isNumber(num: String) -> Bool {
        var isNum: Bool = false
        for character in num.characters {
            if(character >=  "0" && character <= "9") {
                isNum = true
            }
            else {
                isNum = false
            }
        }
        
        return isNum
    }
    
    func isNotFullMonth() -> Bool {
        var isTrue = false
        var nonFullMonths: [String] = ["Feb", "February", "April", "Apr", "Jun", "June", "Sep", "September", "Nov", "November"]
        for var i = 0; i < nonFullMonths.count; i++ {
            if(month.text == nonFullMonths[i]) {
                isTrue = true
            }
        }
        return isTrue
    }
    
    //validate and get sign
    func getsign() {
        let dayNum = Int(day.text!)
        switch month.text! {
        case "January", "Jan":
            if(dayNum > 19) {
                sign.text = "aquarius"
            }
            else {
                sign.text = "capricorn"
            }
            break
        case "February", "Feb":
            if(dayNum > 18) {
               sign.text = "pisces"
            }
            else {
               sign.text = "aquarius"
            }
            break
        case "March", "Mar":
            if(dayNum > 20) {
               sign.text = "aries"
            }
            else {
               sign.text = "pisces"
            }
            break
        case "April", "Apr":
            if(dayNum > 19) {
               sign.text = "taurus"
            }
            else {
               sign.text = "aries"
            }
            break
        case "May":
            if(dayNum > 20) {
               sign.text = "gemini"
            }
            else {
               sign.text = "taurus"
            }
            break
        case "June", "Jun":
            if(dayNum > 21) {
               sign.text = "cancer"
            }
            else {
               sign.text = "gemini"
            }
            break
        case "July", "Jul":
            if(dayNum > 22) {
               sign.text = "leo"
            }
            else {
               sign.text = "cancer"
            }
            break
        case "August", "Aug":
            if(dayNum > 22) {
               sign.text = "virgo"
            }
            else {
               sign.text = "leo"
            }
            break
        case "September", "Sep":
            if(dayNum > 22) {
               sign.text = "libra"
            }
            else {
               sign.text = "virgo"
            }
            break
        case "October", "Oct":
            if(dayNum > 23) {
               sign.text = "scorpio"
            }
            else {
                sign.text = "libra"
            }
            break
        case "November", "Nov":
            if(dayNum > 21) {
               sign.text = "sagittarius"
            }
            else {
               sign.text = "scorpio"
            }
            break
        case "December", "Dec":
            if(dayNum > 21) {
               sign.text = "capricorn"
            }
            else {
               sign.text = "sagittarius"
            }
            break
        default:
            sign.text = "ERROR"
            print( "ERROR: (\(month.text) , \(day.text)) is NOT a correct date.")
            break
        }
    }
    
    //get horoscope from sign
    func getHoroscope() {
        switch sign.text! {
        case "aries":
            horoscope.text = "Things do not always run smoothly for you, but today they run right. You’ll be glad about how it all shakes out. The important part is that you keep believing in the benevolent process of life."
            break
        case "taurus":
            horoscope.text = "You can’t plan your own delight it will happen by surprise. You can, however, put yourself in circumstances in which you are more likely to be surprised."
            break
        case "gemini":
            horoscope.text = "Once again, you’ve set your sights on a lofty destination. Too lofty? No. If your wings can take you there, then it’s not too high for you. You’ll handle this one wing-flap at a time."
            break
        case "cancer":
            horoscope.text = "In a sense, you feel that life is scolding you. It’s not. It’s just caring for you the way a good parent does, trying to correct you when you stray slightly from the path."
            break
        case "leo":
            horoscope.text = "Mostly the best things are made slowly and painfully. If that’s how you feel your “thing” is being made, count yourself among the fortunate. This is going to turn out well for you."
            break
        case "virgo":
            if(day.text == "3" || day.text == "03") {
                horoscope.text = "After you’ve said and done what you needed to say and do, you’ll do more. More matters. Your willingness to go the extra mile is what will form tighter bonds and forge new relationships. November and May are your best months to invest your time and energy in a new business. Wedding bells ring in July. Taurus and Cancer people adore you. Your lucky numbers are 45, 31, 21, 28 and 14."
            } else {
                horoscope.text = "Find a new model. The one you’re chasing isn’t worthy. Whether this is business or personal, the answer is the same. You’re bringing something unique, and a generic model is never going to encompass all you can do."
            }
            break
        case "libra":
            horoscope.text = "The good thing about connecting with people from your past is that they knew you before these trials and victories shaped you. They help you to meet yourself as you were, which will be interesting for you."
            break
        case "scorpio":
            horoscope.text = "Anyone who thinks it’s so easy to sell out isn’t in touch with sales in general. It’s rarely easy to make a sale. There’s work that goes into finding the right product for the market. You’ll do the work and win."
            break
        case "sagittarius":
            horoscope.text = "The person who dares to alter the power balance in relationships must be brave, indeed. People hate this. Maybe change is necessary, and if so, go carefully. A power balance is nothing to take lightly."
            break
        case "capricorn":
            horoscope.text = " It will feel like you don’t have any control over the flow of ideas today, and maybe you don’t. The quality of the idea will make itself known over time. For now, it’s enough just to keep track. Document your mind."
            break
        case "aquarius":
            horoscope.text = "Those who buy tickets to the circus should not be too surprised to find themselves interacting with clowns. This is the day to sit back and enjoy the entertainment."
            break
        case "pisces":
            horoscope.text = "Your tone will make or break your argument today. Strong messages are best sent with dulcet tones, and weak messages can be made more interesting with emphasis."
            break
        default:
            horoscope.text = "ERROR"
            print("Error: not a real sign")
            break
        }
    }
}

