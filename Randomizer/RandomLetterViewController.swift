//
//  RandomLetterViewController.swift
//  Randomizer
//
//  Created by Trevor Broderick on 2016-02-02.
//  Copyright © 2016 Trevor Broderick. All rights reserved.
//

import UIKit

class RandomLetterViewController: UIViewController {
    @IBOutlet weak var choice: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLabelToRandomLetter(choice)

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setLabelToRandomLetter(label: UILabel) {
        let letter = getRandomLetter()
        
        label.text = letter.description
    }
    
    private func getRandomLetter() -> NSString {
        let letters : NSString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let length = UInt32 (letters.length)
        let rand = arc4random_uniform(length)
        
        let randomString : NSMutableString = NSMutableString(capacity: 1)
        
        randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
        
        return randomString
    }
    
    @IBAction func anotherRandomLetter(sender: AnyObject) {
        setLabelToRandomLetter(choice)
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
