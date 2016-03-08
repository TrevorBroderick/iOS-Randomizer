//
//  RandomChoiceController.swift
//  Randomizer
//
//  Created by Trevor Broderick on 2016-03-01.
//  Copyright © 2016 Trevor Broderick. All rights reserved.
//

import UIKit

class RandomChoiceController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    @IBOutlet weak var choiceTable: UITableView!
    
    var choice: UITextField?
    
    let textCellIdentifier = "TextCell"
    var choices: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        choiceTable.delegate = self
        choiceTable.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return choices.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath)
        
        let row = indexPath.row
        cell.textLabel?.text = choices[row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            choices.removeAtIndex(indexPath.row)
            self.choiceTable.reloadData()
        }
    }
    
    @IBAction func addItem(sender: AnyObject) {
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        // CUSTOM RANGE START
        
        let alertController = UIAlertController(title: "Enter Item", message: "", preferredStyle: .Alert)
        
        alertController.addTextFieldWithConfigurationHandler {(textField: UITextField!) in
            self.choice = textField
            textField.placeholder = "Enter the choice"
        }
        
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: {
            action -> Void in
            if (self.choice?.text == "") {
                self.showMessage("Invalid Choice", msg: "Choice cannot be empty.")
            }  else {
                self.choices.append((self.choice?.text)!)
                self.choiceTable.reloadData()
            }
        })
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        // CUSTOM RANGE END
        
        self.presentViewController(alertController, animated:true, completion:nil)
        
    }
    
    @IBAction func getRandomChoice(sender: AnyObject) {
        let length = UInt32 (choices.count)
        
        if (length == 0) {
            self.showMessage("Error", msg: "You must have at least one choice")
            return
        }
        
        let rand = arc4random_uniform(length)
        
        let randomChoice = choices[Int(rand)]
        
        self.showMessage("Choice", msg: randomChoice)
    }
    
    private func showMessage(title: String, msg: String) -> Void {
        let messageController = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        
        let messageDismissAction = UIAlertAction(title: "Ok", style: .Cancel, handler: nil)
        
        messageController.addAction(messageDismissAction)
        
        self.presentViewController(messageController, animated:true, completion:nil)
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
