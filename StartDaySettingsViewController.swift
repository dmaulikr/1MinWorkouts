//
//  StartDaySettingsViewController.swift
//  1MinWorkouts
//
//  Created by Justin Spirent on 4/6/15.
//  Copyright (c) 2015 Good Enough LLC. All rights reserved.
//

import UIKit

class StartDaySettingsViewController: UITableViewController{

    var hour = 8
    var min = 30
    var weekday = true
    var weekend = false
    
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
    @IBOutlet var saveButtonCell: UITableViewCell!
    
    @IBAction func saveSettingsButton(sender: AnyObject) {
        println("saveSettingsButton tapped")
        if startDaySwitch.on{
            println("startDaySwitch is on")
            
            // save the time, weekday/end settings
            let appUserSettings = NSUserDefaults.standardUserDefaults() // instantiates a user default holder
            
            appUserSettings.setInteger(hour, forKey: GlobalVars.startDayHour)
            println("startDayHour was set to \(appUserSettings.valueForKey(GlobalVars.startDayHour))")
            
            appUserSettings.setInteger(min, forKey: GlobalVars.startDayMin)
            println("startDayMin was set to \(appUserSettings.valueForKey(GlobalVars.startDayMin))")
            
            appUserSettings.setBool(weekday, forKey: GlobalVars.notificationWeekday)
            println("notificationWeekday was set to \(appUserSettings.valueForKey(GlobalVars.notificationWeekday))")
            
            appUserSettings.setBool(weekend, forKey: GlobalVars.notificationWeekend)
            println("notificationWeekend was set to \(appUserSettings.valueForKey(GlobalVars.notificationWeekend))")
            
            appUserSettings.setBool(true, forKey: GlobalVars.oobeStartDaySetup)
            println("notificationWeekend was set to \(appUserSettings.valueForKey(GlobalVars.oobeStartDaySetup))")
            
            appUserSettings.setBool(true, forKey: GlobalVars.oobeTute)
            println("notificationWeekend was set to \(appUserSettings.valueForKey(GlobalVars.oobeTute))")
            
            // pops back to the root, prior to the disclaimer xib
            let stb = UIStoryboard(name: "Main", bundle: nil)
            let oneMWStart = stb.instantiateViewControllerWithIdentifier("TabControllerMain") as! MyTabBarController

            
            self.presentViewController(oneMWStart, animated: true, completion: nil)
        }else{
            println("startDaySwitch is off")
            
            //save the weekday/end settings as false
            let appUserSettings = NSUserDefaults.standardUserDefaults() // instantiates a user default holder
            
            appUserSettings.setBool(false, forKey: GlobalVars.notificationWeekday)
            println("notificationWeekday was set to \(appUserSettings.valueForKey(GlobalVars.notificationWeekday))")
            
            appUserSettings.setBool(false, forKey: GlobalVars.notificationWeekend)
            println("notificationWeekend was set to \(appUserSettings.valueForKey(GlobalVars.notificationWeekend))")
            
            appUserSettings.setBool(true, forKey: GlobalVars.oobeStartDaySetup)
            println("notificationWeekend was set to \(appUserSettings.valueForKey(GlobalVars.oobeStartDaySetup))")
            
            appUserSettings.setBool(true, forKey: GlobalVars.oobeTute)
            println("notificationWeekend was set to \(appUserSettings.valueForKey(GlobalVars.oobeTute))")
            
            // pops back to the root, prior to the disclaimer xib
            let stb = UIStoryboard(name: "Main", bundle: nil)
            let oneMWStart = stb.instantiateViewControllerWithIdentifier("TabControllerMain") as! MyTabBarController
            
            self.presentViewController(oneMWStart, animated: true, completion: nil)
        }
    }
    
    @IBOutlet var startDayPicker: UIDatePicker!
    
    @IBAction func startDayPIcker(sender: AnyObject) {
        // sets the hour and min vars to whatever was changed on the startDayPIcker
        hour = sender.hour
        min = sender.minute
        println("startDayPicker was touched. The Hour is \(sender.hour)" + " The Min is \(sender.minute)")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // sets the look of the weekend checkmark to off, which matches the starting var value
        ssCheckmark.image = UIImage(named: "checkmark-off")
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
                weekday = false
                println("Mon-Fri is set to \(weekday)")
            }else{
                mfCheckmark.image = UIImage(named: "checkmark-on")
                weekday = true
                println("Mon-Fri is set to \(weekday)")
            }
            
            println("Monday-Friday was tapped \(indexPath.row)")
        }
        if indexPath.row == 4 {
            satSunCell.selected = false
            
            if ssCheckmark.image == UIImage(named: "checkmark-on"){
                ssCheckmark.image = UIImage(named: "checkmark-off")
                weekend = false
                println("Sat-Sun is set to \(weekend)")
            }else{
                ssCheckmark.image = UIImage(named: "checkmark-on")
                weekend = true
                println("Sat-Sun is set to \(weekend)")
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
