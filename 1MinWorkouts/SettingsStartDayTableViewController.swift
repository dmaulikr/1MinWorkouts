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

            print("startDaySwitch is on, weekday is \(weekday) and weekend is \(weekend)")
        }else{
            datePickerCell.hidden = true
            monFriCell.hidden = true
            satSunCell.hidden = true
            startTime = "Off"
            print("startDaySwitch is off")
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
            
            setStartNotification()
            
            print("startDaySwitch is on")
        }else{
            //save the weekday/end settings as false
            let appUserSettings = NSUserDefaults.standardUserDefaults() // instantiates a user default holder
            
            appUserSettings.setBool(false, forKey: GlobalVars.notificationWeekday)
            appUserSettings.setBool(false, forKey: GlobalVars.notificationWeekend)
            appUserSettings.setBool(true, forKey: GlobalVars.oobeStartDaySetup)
            appUserSettings.setBool(true, forKey: GlobalVars.oobeTute)
            
            weekday = false
            weekend = false
            
            setStartNotification()
            
            print("startDaySwitch is off, weekday is saved as \(weekday) and weekend is saved as \(weekend)")
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
            print("hour is less than 12")
        }else if hour >= 13{
            startTime = "\(hour - 12):\(min)PM"
            print("hour is >= 13")
        }else if hour == 12{
            startTime = "\(hour):\(min)PM"
            print("hour must be 12")
        }
        
        if min < 10{
            startTime = "\(hour):0\(min)AM"
        }
        
        print("startDayPicker was touched. The Hour is \(sender.hour)" + " The Min is \(sender.minute)")
        
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
        let calendar:NSCalendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Year, .Month, .Day, .Hour, .Minute, .Second], fromDate: NSDate())
        //let components = calendar.components(NSCalendarUnit.Hour | NSCalendarUnit.Minute, fromDate: NSDate())
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
                print("Mon-Fri is set to \(weekday)")
            }else if mfCheckmark.image == UIImage(named: "checkmark-off") && ssCheckmark.image == UIImage(named: "checkmark-on"){
                mfCheckmark.image = UIImage(named: "checkmark-on")
                weekday = true
                print("Mon-Fri is set to \(weekday)")
            }else if mfCheckmark.image == UIImage(named: "checkmark-on") && ssCheckmark.image == UIImage(named: "checkmark-off"){
                mfCheckmark.image = UIImage(named: "checkmark-off")
                weekday = false
                ssCheckmark.image = UIImage(named: "checkmark-on")
                weekend = true
                print("Mon-Fri is set to \(weekday) and Sat/Sun is set to \(weekend)")
            }
        }
        if indexPath.row == 4 {
            satSunCell.selected = false
            
            if ssCheckmark.image == UIImage(named: "checkmark-on") && mfCheckmark.image == UIImage(named: "checkmark-on"){
                ssCheckmark.image = UIImage(named: "checkmark-off")
                weekend = false
                print("Sat-Sun is set to \(weekend)")
            }else if ssCheckmark.image == UIImage(named: "checkmark-off") && mfCheckmark.image == UIImage(named: "checkmark-on"){
                ssCheckmark.image = UIImage(named: "checkmark-on")
                weekend = true
                print("Sat-Sun is set to \(weekend)")
            }else if ssCheckmark.image == UIImage(named: "checkmark-on") && mfCheckmark.image == UIImage(named: "checkmark-off"){
                ssCheckmark.image = UIImage(named: "checkmark-off")
                weekend = false
                mfCheckmark.image = UIImage(named: "checkmark-on")
                weekday = true
                print("Sat-Sun is set to \(weekend) and Mon-Fri is set to \(weekday)")
            }
        }
    }
    
    func setStartNotification(){
        
        // clears out all set notifications
//        UIApplication.sharedApplication().cancelAllLocalNotifications()
        
        setNotifVars()
        print("setStartNotification was run")
        
        // need to reset next days start notification
        let today = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Year, .Month, .Day, .Hour, .Minute, .Second], fromDate: today)
        //let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitMonth | .CalendarUnitYear | .CalendarUnitDay, fromDate: today)
        let hour = components.hour
        let minutes = components.minute
        let month = components.month
        let year = components.year
        let day = components.day
        
        let dateComp:NSDateComponents = NSDateComponents()
        dateComp.year = year    // sets to current year
        dateComp.month = month  // sets to current month
        dateComp.day = day      // sets to today
        dateComp.hour = GlobalVars.workoutNotificationStartHour     // sets to current hour
        dateComp.minute = GlobalVars.workoutNotificationStartMin    // sets to users work start time
        dateComp.second = 0
        dateComp.timeZone = NSTimeZone.systemTimeZone()
        
        let dateCompSkipEnd:NSDateComponents = NSDateComponents()
        dateCompSkipEnd.year = year    // sets to current year
        dateCompSkipEnd.month = month  // sets to current month
        dateCompSkipEnd.day = day + 3      // sets to tomorrow
        dateCompSkipEnd.hour = GlobalVars.workoutNotificationStartHour     // sets to current hour
        dateCompSkipEnd.minute = GlobalVars.workoutNotificationStartMin    // sets to users work start time
        dateCompSkipEnd.second = 0
        dateCompSkipEnd.timeZone = NSTimeZone.systemTimeZone()
        
        let dateCompSkipWeek:NSDateComponents = NSDateComponents()
        dateCompSkipWeek.year = year    // sets to current year
        dateCompSkipWeek.month = month  // sets to current month
        dateCompSkipWeek.day = day + 6      // sets to tomorrow
        dateCompSkipWeek.hour = GlobalVars.workoutNotificationStartHour     // sets to current hour
        dateCompSkipWeek.minute = GlobalVars.workoutNotificationStartMin    // sets to users work start time
        dateCompSkipWeek.second = 0
        dateCompSkipWeek.timeZone = NSTimeZone.systemTimeZone()
        
        let calender:NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let date:NSDate = calender.dateFromComponents(dateComp)!
        let dateSkipEnd:NSDate = calender.dateFromComponents(dateCompSkipEnd)!
        let dateSkipWeek:NSDate = calender.dateFromComponents(dateCompSkipWeek)!
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "e"
        let dayOfWeek = dateFormatter.stringFromDate(today)
        
        switch dayOfWeek{
        case "2"..."5": // if it's a weekday and weekdays are ON
            if GlobalVars.notificationSettingsWeekday == true{
                let notification:UILocalNotification = UILocalNotification()
                notification.category = ""
                notification.alertBody = "Time for your first workout of the day!"
                notification.alertAction = "View App"
                notification.fireDate = date
                notification.soundName = UILocalNotificationDefaultSoundName
                notification.repeatInterval = NSCalendarUnit.Day // sets when the notification repeats
                
                UIApplication.sharedApplication().scheduleLocalNotification(notification)
                
                print("You'll get a notification every day during the week")
            }else{
                let message:UIAlertController = UIAlertController(title: "Weekday Notifications OFF", message: "You don't have Start Notifications on for week days. \n \n" + "To change this goto the in app Settings.", preferredStyle: UIAlertControllerStyle.Alert)
                message.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
                
                print("Notifications are off so no start notifcations set")
            }
            
        case "6":
            if GlobalVars.notificationSettingsWeekend == true{
                let notification:UILocalNotification = UILocalNotification()
                notification.category = ""
                notification.alertBody = "Time for your first workout of the day!"
                notification.alertAction = "View App"
                notification.fireDate = date
                notification.soundName = UILocalNotificationDefaultSoundName
                notification.repeatInterval = NSCalendarUnit.Day // sets when the notification repeats
                
                UIApplication.sharedApplication().scheduleLocalNotification(notification)
                
                print("You'll get a notification tomorrow (sat)")
                
            }else if GlobalVars.notificationSettingsWeekday == true && GlobalVars.notificationSettingsWeekend == false{
                let notification:UILocalNotification = UILocalNotification()
                notification.category = ""
                notification.alertBody = "Time for your first workout of the day!"
                notification.alertAction = "View App"
                notification.fireDate = dateSkipEnd
                notification.soundName = UILocalNotificationDefaultSoundName
                notification.repeatInterval = NSCalendarUnit.Day // sets when the notification repeats
                
                UIApplication.sharedApplication().scheduleLocalNotification(notification)
                
                print("You'll get a notification on Monday")
                
            }else if GlobalVars.notificationSettingsWeekday == false && GlobalVars.notificationSettingsWeekend == true{
                let notification:UILocalNotification = UILocalNotification()
                notification.category = ""
                notification.alertBody = "Time for your first workout of the day!"
                notification.alertAction = "View App"
                notification.fireDate = date
                notification.soundName = UILocalNotificationDefaultSoundName
                notification.repeatInterval = NSCalendarUnit.Day // sets when the notification repeats
                
                UIApplication.sharedApplication().scheduleLocalNotification(notification)
                
                print("You'll get a notification tomorrow (sat)")
                
            }else{
                let message:UIAlertController = UIAlertController(title: "Weekend Notifications OFF", message: "You don't have Start Notifications on for weekends. \n \n" + "To change this goto the in app Settings.", preferredStyle: UIAlertControllerStyle.Alert)
                message.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
                
                print("Notifications are off so no start notifcations set")
            }
            
        case "1": // if it's a weekend and weekdays are ON
            if GlobalVars.notificationSettingsWeekend == true{
                let notification:UILocalNotification = UILocalNotification()
                notification.category = ""
                notification.alertBody = "Time for your first workout of the day!"
                notification.alertAction = "View App"
                notification.fireDate = date
                notification.soundName = UILocalNotificationDefaultSoundName
                notification.repeatInterval = NSCalendarUnit.Day // sets when the notification repeats
                
                UIApplication.sharedApplication().scheduleLocalNotification(notification)
                
                print("You'll get a notification tomorrow")
            }else{
                let message:UIAlertController = UIAlertController(title: "Weekend Notifications OFF", message: "You don't have Start Notifications on for weekends. \n \n" + "To change this goto the in app Settings.", preferredStyle: UIAlertControllerStyle.Alert)
                message.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
                
                print("Notifications are off so no start notifcations set")
            }
            
        case "7":
            if GlobalVars.notificationSettingsWeekday == true{
                let notification:UILocalNotification = UILocalNotification()
                notification.category = ""
                notification.alertBody = "Time for your first workout of the day!"
                notification.alertAction = "View App"
                notification.fireDate = date
                notification.soundName = UILocalNotificationDefaultSoundName
                notification.repeatInterval = NSCalendarUnit.Day // sets when the notification repeats
                
                UIApplication.sharedApplication().scheduleLocalNotification(notification)
                
                print("You'll get a notification tomorrow")
            }else{
                let notification:UILocalNotification = UILocalNotification()
                notification.category = ""
                notification.alertBody = "Time for your first workout of the day!"
                notification.alertAction = "View App"
                notification.fireDate = dateSkipWeek
                notification.soundName = UILocalNotificationDefaultSoundName
                notification.repeatInterval = NSCalendarUnit.Day // sets when the notification repeats
                
                UIApplication.sharedApplication().scheduleLocalNotification(notification)
                
                print("You'll get a notification on Sunday")
            }
            
        default:
            break
        }
    }
    
}
