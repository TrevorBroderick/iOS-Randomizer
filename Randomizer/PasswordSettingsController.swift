//
//  PasswordSettingsController.swift
//  Randomizer
//
//  Created by Trevor Broderick on 2016-02-19.
//  Copyright © 2016 Trevor Broderick. All rights reserved.
//

import UIKit

class PasswordSettingsController: UIViewController {
    @IBOutlet weak var numericSwitch: UISwitch!
    @IBOutlet weak var specialSwitch: UISwitch!
    @IBOutlet weak var lengthLabel: UILabel!
    @IBOutlet weak var lengthStepper: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        numericSwitch.on = NSUserDefaults.standardUserDefaults().boolForKey("numericSwitch")
        specialSwitch.on = NSUserDefaults.standardUserDefaults().boolForKey("specialSwitch")
        lengthStepper.value = Double(NSUserDefaults.standardUserDefaults().integerForKey("length"))
        
        if (NSUserDefaults.standardUserDefaults().integerForKey("length") == 0) {
            lengthLabel.text = 5.description
        } else {
            lengthLabel.text = NSUserDefaults.standardUserDefaults().integerForKey("length").description
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "passwordSettings") {
            let svc = segue.destinationViewController as! RandomPasswordController
            
            svc.numeric = numericSwitch.on
            svc.special = specialSwitch.on
            svc.length  = Int(lengthLabel.text!)!
            
        }
    }
    
    @IBAction func saveSwitchPressedNumeric(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setBool(numericSwitch.on, forKey: "numericSwitch")
    }
    
    @IBAction func saveSwitchPressedSpecial(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setBool(specialSwitch.on, forKey: "specialSwitch")
    }
    
    @IBAction func changeLength(sender: AnyObject) {
        self.lengthLabel.text = Int(lengthStepper.value).description
        NSUserDefaults.standardUserDefaults().setInteger(Int(lengthLabel.text!)!, forKey: "length")
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
