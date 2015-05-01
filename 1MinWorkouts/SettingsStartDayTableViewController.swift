//
//  SettingsStartDayTableViewController.swift
//  1MinWorkouts
//
//  Created by Justin Spirent on 5/1/15.
//  Copyright (c) 2015 Good Enough LLC. All rights reserved.
//

import UIKit

class SettingsStartDayTableViewController: UITableViewController {
    var hour = GlobalVars.workoutNotificationStartHour
    var min = GlobalVars.workoutNotificationStartMin
    var weekday = GlobalVars.notificationSettingsWeekday
    var weekend = GlobalVars.notificationSettingsWeekend
    
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
    @IBOutlet var startDayPicker: UIDatePicker!
    
    @IBAction func startDayPIcker(sender: AnyObject) {
        // sets the hour and min vars to whatever was changed on the startDayPIcker
        hour = sender.hour
        min = sender.minute
        println("startDayPicker was touched. The Hour is \(sender.hour)" + " The Min is \(sender.minute)")
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        if GlobalVars.notificationSettingsWeekday == false && GlobalVars.notificationSettingsWeekend == false{
            startDaySwitch.on = false
            datePickerCell.hidden = true
            monFriCell.hidden = true
            satSunCell.hidden = true
        }else {
            startDaySwitch.on = true
        }
        
        // sets the date picker to show the current setting
        var calendar:NSCalendar = NSCalendar.currentCalendar()
        let components = calendar.components(NSCalendarUnit.CalendarUnitHour | NSCalendarUnit.CalendarUnitMinute, fromDate: NSDate())
        components.hour = GlobalVars.workoutNotificationStartHour
        components.minute = GlobalVars.workoutNotificationStartMin
        startDayPicker.setDate(calendar.dateFromComponents(components)!, animated: true)
        
        // sets the look of the weekend checkmark to off, which matches the starting var value
        if GlobalVars.notificationSettingsWeekday == true{
            mfCheckmark.image = UIImage(named: "checkmark-on")
        }else{
            mfCheckmark.image = UIImage(named: "checkmark-off")
        }
        
        if GlobalVars.notificationSettingsWeekend == true{
            ssCheckmark.image = UIImage(named: "checkmark-on")
        }else{
            ssCheckmark.image = UIImage(named: "checkmark-off")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        println("viewWillDisappear")
        if startDaySwitch.on{
            println("startDaySwitch is on")
            
            // save the time, weekday/end settings
            let appUserSettings = NSUserDefaults.standardUserDefaults() // instantiates a user default holder
            
            appUserSettings.setInteger(hour, forKey: GlobalVars.startDayHour)
            
            appUserSettings.setInteger(min, forKey: GlobalVars.startDayMin)
            
            appUserSettings.setBool(weekday, forKey: GlobalVars.notificationWeekday)
            
            appUserSettings.setBool(weekend, forKey: GlobalVars.notificationWeekend)
            
            appUserSettings.setBool(true, forKey: GlobalVars.oobeStartDaySetup)
            
            appUserSettings.setBool(true, forKey: GlobalVars.oobeTute)
            
        }else{
            println("startDaySwitch is off")
            
            //save the weekday/end settings as false
            let appUserSettings = NSUserDefaults.standardUserDefaults() // instantiates a user default holder
            
            appUserSettings.setBool(false, forKey: GlobalVars.notificationWeekday)
            
            appUserSettings.setBool(false, forKey: GlobalVars.notificationWeekend)
            
            appUserSettings.setBool(true, forKey: GlobalVars.oobeStartDaySetup)
            
            appUserSettings.setBool(true, forKey: GlobalVars.oobeTute)
            
        }
        
        let appUserSettings = NSUserDefaults.standardUserDefaults() // instantiates a user default holder
        GlobalVars.workoutNotificationStartHour = appUserSettings.integerForKey("startDayHour") as Int!
        GlobalVars.workoutNotificationStartMin = appUserSettings.integerForKey("startDayMin") as Int!
        GlobalVars.notificationSettingsWeekday = appUserSettings.boolForKey("notificationWeekday") as Bool!
        GlobalVars.notificationSettingsWeekend = appUserSettings.boolForKey("notificationWeekend") as Bool!
        println("sets GlobalVars to: \(GlobalVars.workoutNotificationStartHour) | \(GlobalVars.workoutNotificationStartMin) | \(GlobalVars.notificationSettingsWeekday) | \(GlobalVars.notificationSettingsWeekend)")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == 3 {
            monFriCell.selected = false
            
            if mfCheckmark.image == UIImage(named: "checkmark-on") && ssCheckmark.image == UIImage(named: "checkmark-on"){
                mfCheckmark.image = UIImage(named: "checkmark-off")
                weekday = false
                println("Mon-Fri is set to \(weekday)")
            }else if mfCheckmark.image == UIImage(named: "checkmark-off") && ssCheckmark.image == UIImage(named: "checkmark-on"){
                mfCheckmark.image = UIImage(named: "checkmark-on")
                weekday = true
                println("Mon-Fri is set to \(weekday)")
            }else if mfCheckmark.image == UIImage(named: "checkmark-on") && ssCheckmark.image == UIImage(named: "checkmark-off"){
                mfCheckmark.image = UIImage(named: "checkmark-off")
                weekday = false
                ssCheckmark.image = UIImage(named: "checkmark-on")
                weekend = true
                println("Mon-Fri is set to \(weekday) and Sat/Sun is set to \(weekend)") 
            }
        }
        if indexPath.row == 4 {
            satSunCell.selected = false
            
            if ssCheckmark.image == UIImage(named: "checkmark-on") && mfCheckmark.image == UIImage(named: "checkmark-on"){
                ssCheckmark.image = UIImage(named: "checkmark-off")
                weekend = false
                println("Sat-Sun is set to \(weekend)")
            }else if ssCheckmark.image == UIImage(named: "checkmark-off") && mfCheckmark.image == UIImage(named: "checkmark-on"){
                ssCheckmark.image = UIImage(named: "checkmark-on")
                weekend = true
                println("Sat-Sun is set to \(weekend)")
            }else if ssCheckmark.image == UIImage(named: "checkmark-on") && mfCheckmark.image == UIImage(named: "checkmark-off"){
                ssCheckmark.image = UIImage(named: "checkmark-off")
                weekend = false
                mfCheckmark.image = UIImage(named: "checkmark-on")
                weekday = true
                println("Sat-Sun is set to \(weekend) and Mon-Fri is set to \(weekday)")
            }
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
