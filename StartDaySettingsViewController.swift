//
//  StartDaySettingsViewController.swift
//  1MinWorkouts
//
//  Created by Justin Spirent on 4/6/15.
//  Copyright (c) 2015 Good Enough LLC. All rights reserved.
//

import UIKit

class StartDaySettingsViewController: UITableViewController{

    @IBOutlet var startDaySwitch: UISwitch!
    @IBAction func startDaySwitch(sender: AnyObject) {
        if startDaySwitch.on{
            datePickerCell.hidden = false
            monFriCell.hidden = false
            satSunCell.hidden = false
            println("startDaySwitch is on")
        }else{
            datePickerCell.hidden = true
            monFriCell.hidden = true
            satSunCell.hidden = true
            println("startDaySwitch is off")
        }
    }
    
    @IBOutlet var datePickerCell: UITableViewCell!
    @IBOutlet var monFriCell: UITableViewCell!
    @IBOutlet var satSunCell: UITableViewCell!
    @IBOutlet var mfCheckmark: UIImageView!
    @IBOutlet var ssCheckmark: UIImageView!
    
    @IBAction func saveSettingsButton(sender: AnyObject) {
        println("saveSettingsButton tapped")
    }
    @IBOutlet var startDayPicker: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == 3 {
            monFriCell.selected = false
            
            if mfCheckmark.image == UIImage(named: "checkmark-on"){
                mfCheckmark.image = UIImage(named: "checkmark-off")
            }else{
                mfCheckmark.image = UIImage(named: "checkmark-on")
            }
            
            println("Monday-Friday was tapped \(indexPath.row)")
        }
        if indexPath.row == 4 {
            satSunCell.selected = false
            
            if ssCheckmark.image == UIImage(named: "checkmark-on"){
                ssCheckmark.image = UIImage(named: "checkmark-off")
            }else{
                ssCheckmark.image = UIImage(named: "checkmark-on")
            }
            
            println("Saturday and Sunday was tapped \(indexPath.row)")
        }
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
