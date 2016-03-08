//
//  RandomNumberControllerViewController.swift
//  Randomizer
//
//  Created by Trevor Broderick on 2016-01-29.
//  Copyright © 2016 Trevor Broderick. All rights reserved.
//

import UIKit

class RandomNumberControllerViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var choice: UILabel!
    
    var minimumRangeTextField: UITextField?
    var maximumRangeTextField: UITextField?
    
    var minimumRange: UInt32 = 1
    var maximumRange: UInt32 = 100

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLabelToRandomNumber(choice)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setLabelToRandomNumber(label: UILabel) {
        let number = getRandomNumber()
        
        label.text = number.description
    }
    
    private func getRandomNumber() -> Int {
        let difference = (self.maximumRange - self.minimumRange + 1)
        
        return Int(arc4random_uniform(difference) + self.minimumRange);
    }
    
    @IBAction func anotherRandomNumber(sender: AnyObject) {
        setLabelToRandomNumber(choice)
    }

    @IBAction func changeRange(sender: AnyObject) {
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        // CUSTOM RANGE START
        
        let alertController = UIAlertController(title: "Select Range", message: "", preferredStyle: .Alert)
        
        alertController.addTextFieldWithConfigurationHandler {(textField: UITextField!) in
            self.minimumRangeTextField = textField
            textField.placeholder = "Enter the minimum range"
            self.minimumRangeTextField!.placeholder = "Enter the minimum range"
            self.minimumRangeTextField!.keyboardType = UIKeyboardType.NumberPad
        }
        
        alertController.addTextFieldWithConfigurationHandler {(textField: UITextField!) in
            self.maximumRangeTextField = textField
            self.maximumRangeTextField!.placeholder = "Enter the maximum range"
            self.maximumRangeTextField!.keyboardType = UIKeyboardType.NumberPad
        }
        
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: {
            action -> Void in
            if (self.minimumRangeTextField?.text == "" || self.maximumRangeTextField?.text == "" ) {
                self.showError("Invalid Range", msg: "Range cannot be empty.")
            }  else {
                let min = Int((self.minimumRangeTextField?.text)!)
                let max = Int((self.maximumRangeTextField?.text)!)
                
                if (min >= max) {
                    self.showError("Invalid Range", msg: "Minimum cannnot be greater than maximum.")
                } else if (min < 0 || max < 0) {
                    self.showError("Invalid Range", msg: "Ranges must be positive.")
                } else {
                    self.minimumRange = UInt32 (min!)
                    self.maximumRange = UInt32 (max!)
                }
            }
        })
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        // CUSTOM RANGE END
        
        let actionController = UIAlertController(title: "Ranges", message: "", preferredStyle: .ActionSheet)
        
        let customAction = UIAlertAction(title: "Custom Range", style: .Default, handler: {
            action -> Void in
            self.presentViewController(alertController, animated:true, completion:nil)
        })
        
        let die6Action = UIAlertAction(title: "6-Sided Die", style: .Default, handler: {
            action -> Void in
                self.minimumRange = 1
                self.maximumRange = 6
        })
        
        let coinAction = UIAlertAction(title: "Coin Flip", style: .Default, handler: {
            action -> Void in
            self.minimumRange = 1
            self.maximumRange = 2
        })
        
        actionController.addAction(customAction)
        actionController.addAction(die6Action)
        actionController.addAction(coinAction)
        actionController.addAction(cancelAction)
        
        self.presentViewController(actionController, animated:true, completion:nil)
    }
    
    private func showError(title: String, msg: String) -> Void {
        let errorController = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        
        let errorDismissAction = UIAlertAction(title: "Ok", style: .Cancel, handler: nil)
        
        errorController.addAction(errorDismissAction)
        
        self.presentViewController(errorController, animated:true, completion:nil)
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
