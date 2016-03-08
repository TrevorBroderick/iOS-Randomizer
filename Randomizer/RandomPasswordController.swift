//
//  RandomPasswordController.swift
//  Randomizer
//
//  Created by Trevor Broderick on 2016-02-05.
//  Copyright © 2016 Trevor Broderick. All rights reserved.
//

import UIKit

class RandomPasswordController: UIViewController {
    @IBOutlet weak var choice: UILabel!
    let letters : NSString = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
    let numbers : NSString = "1234567890"
    let specials : NSString = "!@#$%^&*()"
    var numeric = false
    var special = false
    var length = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        numeric = NSUserDefaults.standardUserDefaults().boolForKey("numericSwitch")
        special = NSUserDefaults.standardUserDefaults().boolForKey("specialSwitch")
        
        if (NSUserDefaults.standardUserDefaults().integerForKey("length") == 0) {
            length = 5
        } else {
            length = NSUserDefaults.standardUserDefaults().integerForKey("length")
        }
        
        setLabelToRandomPassword(choice)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func anotherRandomPassword(sender: AnyObject) {
        setLabelToRandomPassword(choice)
    }
    
    private func setLabelToRandomPassword(label: UILabel) {
        let letter = getRandomPassword(length, letters: true, digits: numeric, special: special)
        
        label.text = letter.description
    }
    
    private func getRandomPassword(password_length: Int, letters: Bool, digits: Bool, special: Bool) -> NSString {
        
        let characters: NSMutableString = ""
        
        if (letters == true) {
            for (var i = 0; i < self.letters.length; i++) {
                characters.appendFormat("%C", self.letters.characterAtIndex(i))
            }
        }
        
        if (digits == true) {
            for (var i = 0; i < self.numbers.length; i++) {
                characters.appendFormat("%C", self.numbers.characterAtIndex(i))
            }
        }
        
        if (special == true) {
            for (var i = 0; i < self.specials.length; i++) {
                characters.appendFormat("%C", self.specials.characterAtIndex(i))
            }
        }
        
        let randomString : NSMutableString = NSMutableString(capacity: password_length)
        
        for (var i: Int = 0; i < password_length; i++) {
            let length = UInt32 (characters.length)
            let rand = arc4random_uniform(length)
            
            randomString.appendFormat("%C", characters.characterAtIndex(Int(rand)))
        }
        
        return randomString
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
