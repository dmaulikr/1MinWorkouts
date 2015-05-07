//
//  SettingsStartDayTableViewController.swift
//  1MinWorkouts
//
//  Created by Justin Spirent on 5/1/15.
//  Copyright (c) 2015 Good Enough LLC. All rights reserved.
//

import UIKit

protocol SettingsStartDayTableViewControllerDelegate{
    func myVCDidFinish(controller:SettingsStartDayTableViewController,text:String)
}


class SettingsStartDayTableViewController: UITableViewController {
    
    var delegate:SettingsStartDayTableViewControllerDelegate? = nil
    
    var hour = GlobalVars.workoutNotificationStartHour
    var min = GlobalVars.workoutNotificationStartMin
    var weekday = GlobalVars.notificationSettingsWeekday
    var weekend = GlobalVars.notificationSettingsWeekend
    
    var startTime = ""
    
    @IBOutlet var startDaySwitch: UISwitch!
    @IBAction func startDaySwitch(sender: AnyObject) {
        if startDaySwitch.on{
            datePickerCell.hidden = false
            monFriCell.hidden = false
            satSunCell.hidden = false
            weekday = true
            weekend = false
            mfCheckmark.image = UIImage(named: "checkmark-on")
            ssCheckmark.image = UIImage(named: "checkmark-off")
            
            if GlobalVars.workoutNotificationStartHour < 12{
                startTime = "\(GlobalVars.workoutNotificationStartHour):\(GlobalVars.workoutNotificationStartMin)AM"
            }else if GlobalVars.workoutNotificationStartHour >= 13{
                startTime = "\(GlobalVars.workoutNotificationStartHour - 12):\(GlobalVars.workoutNotificationStartMin)PM"
            }else if GlobalVars.workoutNotificationStartHour == 12{
                startTime = "\(GlobalVars.workoutNotificationStartHour):\(GlobalVars.workoutNotificationStartMin)PM"
            }
            
            if GlobalVars.workoutNotificationStartMin < 10{
                startTime = "\(GlobalVars.workoutNotificationStartHour):0\(GlobalVars.workoutNotificationStartMin)AM"
            }

            println("startDaySwitch is on, weekday is \(weekday) and weekend is \(weekend)")
        }else{
            datePickerCell.hidden = true
            monFriCell.hidden = true
            satSunCell.hidden = true
            startTime = "Off"
            println("startDaySwitch is off")
        }
    }
    
    @IBAction func saveSettingsBtn(sender: AnyObject) {
        
        if (delegate != nil) {
            delegate!.myVCDidFinish(self, text: startTime)
        }
        if startDaySwitch.on{
            // save the time, weekday/end settings
            let appUserSettings = NSUserDefaults.standardUserDefaults() // instantiates a user default holder
            
            appUserSettings.setInteger(hour, forKey: GlobalVars.startDayHour)
            appUserSettings.setInteger(min, forKey: GlobalVars.startDayMin)
            appUserSettings.setBool(weekday, forKey: GlobalVars.notificationWeekday)
            appUserSettings.setBool(weekend, forKey: GlobalVars.notificationWeekend)
            appUserSettings.setBool(true, forKey: GlobalVars.oobeStartDaySetup)
            appUserSettings.setBool(true, forKey: GlobalVars.oobeTute)
            
            println("startDaySwitch is on")
        }else{
            //save the weekday/end settings as false
            let appUserSettings = NSUserDefaults.standardUserDefaults() // instantiates a user default holder
            
            appUserSettings.setBool(false, forKey: GlobalVars.notificationWeekday)
            appUserSettings.setBool(false, forKey: GlobalVars.notificationWeekend)
            appUserSettings.setBool(true, forKey: GlobalVars.oobeStartDaySetup)
            appUserSettings.setBool(true, forKey: GlobalVars.oobeTute)
            
            weekday = false
            weekend = false
            
            println("startDaySwitch is off, weekday is saved as \(weekday) and weekend is saved as \(weekend)")
        }
        setNotifVars() // sets the notification default settings to the appropriate GlobalVars
        
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
        
        if hour < 12{
            startTime = "\(hour):\(min)AM"
            println("hour is less than 12")
        }else if hour >= 13{
            startTime = "\(hour - 12):\(min)PM"
            println("hour is >= 13")
        }else if hour == 12{
            startTime = "\(hour):\(min)PM"
            println("hour must be 12")
        }
        
        if min < 10{
            startTime = "\(hour):0\(min)AM"
        }
        
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
    
//    override func viewWillDisappear(animated: Bool) {
//        println("viewWillDisappear")
//        
//        if (delegate != nil) {
//            delegate!.myVCDidFinish(SettingsTableViewController(), hour: GlobalVars.workoutNotificationStartHour, min: GlobalVars.workoutNotificationStartMin)
//        }
//        
//        if startDaySwitch.on{
//            println("startDaySwitch is on")
//            
//            // save the time, weekday/end settings
//            let appUserSettings = NSUserDefaults.standardUserDefaults() // instantiates a user default holder
//            
//            appUserSettings.setInteger(hour, forKey: GlobalVars.startDayHour)
//            appUserSettings.setInteger(min, forKey: GlobalVars.startDayMin)
//            appUserSettings.setBool(weekday, forKey: GlobalVars.notificationWeekday)
//            appUserSettings.setBool(weekend, forKey: GlobalVars.notificationWeekend)
//            appUserSettings.setBool(true, forKey: GlobalVars.oobeStartDaySetup)            
//            appUserSettings.setBool(true, forKey: GlobalVars.oobeTute)
//            
//        }else{
//            println("startDaySwitch is off")
//            
//            //save the weekday/end settings as false
//            let appUserSettings = NSUserDefaults.standardUserDefaults() // instantiates a user default holder
//            
//            appUserSettings.setBool(false, forKey: GlobalVars.notificationWeekday)
//            appUserSettings.setBool(false, forKey: GlobalVars.notificationWeekend)
//            appUserSettings.setBool(true, forKey: GlobalVars.oobeStartDaySetup)
//            appUserSettings.setBool(true, forKey: GlobalVars.oobeTute)//            
//        }        
//        setNotifVars() // sets the notification default settings to the appropriate GlobalVars
//        
//    }
    
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
    
}
