//
//  SettingsStartDayTableViewController.swift
//  1MinWorkouts
//
//  Created by Justin on 5/1/15.
//  Copyright (c) 2015 Good Enough LLC. All rights reserved.
//

import UIKit
import UserNotifications

protocol SettingsStartDayTableViewControllerDelegate{
    func myVCDidFinish(_ controller:SettingsStartDayTableViewController,text:String)
}


class SettingsStartDayTableViewController: UITableViewController {
    
    var delegate:SettingsStartDayTableViewControllerDelegate? = nil
    
    var hour = GlobalVars.workoutNotificationStartHour
    var min = GlobalVars.workoutNotificationStartMin
    var weekday = GlobalVars.notificationSettingsWeekday
    var weekend = GlobalVars.notificationSettingsWeekend
    
    var startTime = ""
    
    @IBOutlet var startDaySwitch: UISwitch!
    @IBAction func startDaySwitch(_ sender: AnyObject) {
        if startDaySwitch.isOn{
            datePickerCell.isHidden = false
            monFriCell.isHidden = false
            satSunCell.isHidden = false
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
            datePickerCell.isHidden = true
            monFriCell.isHidden = true
            satSunCell.isHidden = true
            startTime = "Off"
            print("startDaySwitch is off")
        }
    }
    
    @IBAction func saveSettingsBtn(_ sender: AnyObject) {
        
        if (delegate != nil) {
            delegate!.myVCDidFinish(self, text: startTime)
        }
        if startDaySwitch.isOn{
            // save the time, weekday/end settings
            let appUserSettings = UserDefaults.standard // instantiates a user default holder
            
            appUserSettings.set(hour, forKey: GlobalVars.startDayHour)
            appUserSettings.set(min, forKey: GlobalVars.startDayMin)
            appUserSettings.set(weekday, forKey: GlobalVars.notificationWeekday)
            appUserSettings.set(weekend, forKey: GlobalVars.notificationWeekend)
            appUserSettings.set(true, forKey: GlobalVars.oobeStartDaySetup)
            appUserSettings.set(true, forKey: GlobalVars.oobeTute)
            
            setStartNotifications()
            
            print("startDaySwitch is on")
        }else{
            //save the weekday/end settings as false
            let appUserSettings = UserDefaults.standard // instantiates a user default holder
            
            appUserSettings.set(false, forKey: GlobalVars.notificationWeekday)
            appUserSettings.set(false, forKey: GlobalVars.notificationWeekend)
            appUserSettings.set(true, forKey: GlobalVars.oobeStartDaySetup)
            appUserSettings.set(true, forKey: GlobalVars.oobeTute)
            
            weekday = false
            weekend = false
            
            setStartNotifications()
            
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
    
    @IBAction func startDayPIcker(_ sender: AnyObject) {
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

    override func viewWillAppear(_ animated: Bool) {
        
        if GlobalVars.notificationSettingsWeekday == false && GlobalVars.notificationSettingsWeekend == false{
            startDaySwitch.isOn = false
            datePickerCell.isHidden = true
            monFriCell.isHidden = true
            satSunCell.isHidden = true
        }else {
            startDaySwitch.isOn = true
        }
        
        // sets the date picker to show the current setting
        let calendar:Calendar = Calendar.current
        var components = (calendar as NSCalendar).components([.year, .month, .day, .hour, .minute, .second], from: Date())
        //let components = calendar.components(NSCalendarUnit.Hour | NSCalendarUnit.Minute, fromDate: NSDate())
        components.hour = GlobalVars.workoutNotificationStartHour
        components.minute = GlobalVars.workoutNotificationStartMin
        startDayPicker.setDate(calendar.date(from: components)!, animated: true)
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (indexPath as NSIndexPath).row == 3 {
            monFriCell.isSelected = false
            
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
        if (indexPath as NSIndexPath).row == 4 {
            satSunCell.isSelected = false
            
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
    
    func setStartNotifications(){
        
        setNotifVars()
        
        // resets next days start notification
        let today = Date()
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components([.year, .month, .day, .hour, .minute, .second], from: today)
        let hour = components.hour
        let minute = components.minute
        let month = components.month
        let year = components.year
        let day = components.day
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "e" // sets the day of the week to a single digit // Sunday = 1 // Monday = 2 // Tuesday = 3 // Wednesday = 4 // Thrusday = 5 // Friday = 6 // Saturday = 7
        let dayOfWeek = dateFormatter.string(from: today) // sets the day of week to be used as a variable
        
        func notificationStart(dayCountStart: Int, maxLoop: Int, findSatSkipCount: Int, skipWeekendCount: Int){
            var addDay = dayCountStart
            for _ in 1...maxLoop { // iterates based on var maxLoop setting
                addDay += 1  // sets the notification date to next day and then increments the added day by one for each iteration of the Loop
                
                if addDay == findSatSkipCount{ // checks to find when Saturday is within the 7 iterations
                    addDay = skipWeekendCount  // skips the weekend and adds two more notifications for 7 total set
                }
                
                let center = UNUserNotificationCenter.current()
                
                let content = UNMutableNotificationContent()
                content.body = "It's time for your first workout of the day!"
                content.sound = UNNotificationSound.default()
                
                var dateComponents = DateComponents()
                dateComponents.year = year
                dateComponents.month = month
                dateComponents.day = day! + addDay
                dateComponents.hour = GlobalVars.workoutNotificationStartHour
                dateComponents.minute = GlobalVars.workoutNotificationStartMin
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
                
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                center.add(request)
                
                print("notification set for \(dateComponents.month!)/\(dateComponents.day!)/\(dateComponents.year!) - \(dateComponents.hour!):\(dateComponents.minute!)")
            }
            navigationController!.popToRootViewController(animated: true)
        }
        
        switch dayOfWeek{
        case "1": // Sunday
            if hour! > GlobalVars.workoutNotificationStartHour && minute! > GlobalVars.workoutNotificationStartMin{// checks when the settings is being made so we can set a notofication for today or tomorrow
                if GlobalVars.notificationSettingsWeekday == true && GlobalVars.notificationSettingsWeekend == false{
                    
                    // clears out all set notifications
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                    
                    notificationStart(dayCountStart: 0, maxLoop: 7, findSatSkipCount: 6, skipWeekendCount: 8)
                
                }
                if GlobalVars.notificationSettingsWeekday == false && GlobalVars.notificationSettingsWeekend == true{
                    
                    // clears out all set notifications
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                
                    notificationStart(dayCountStart: 5, maxLoop: 4, findSatSkipCount: 8, skipWeekendCount: 13)
                
                }
                if GlobalVars.notificationSettingsWeekday == true && GlobalVars.notificationSettingsWeekend == true{
                    
                    // clears out all set notifications
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                
                    notificationStart(dayCountStart: 0, maxLoop: 7, findSatSkipCount: 999, skipWeekendCount: 999)
                
                }
                print("greater than current time - \(hour!):\(minute!)")
            }else{
                if GlobalVars.notificationSettingsWeekday == true && GlobalVars.notificationSettingsWeekend == false{
                    
                    // clears out all set notifications
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                    
                    notificationStart(dayCountStart: 0, maxLoop: 7, findSatSkipCount: 6, skipWeekendCount: 8)
                    
                }
                if GlobalVars.notificationSettingsWeekday == false && GlobalVars.notificationSettingsWeekend == true{
                    
                    // clears out all set notifications
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                    
                    notificationStart(dayCountStart: -1, maxLoop: 4, findSatSkipCount: 5, skipWeekendCount: 6)
                    
                }
                if GlobalVars.notificationSettingsWeekday == true && GlobalVars.notificationSettingsWeekend == true{
                    
                    // clears out all set notifications
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                    
                    notificationStart(dayCountStart: -1, maxLoop: 7, findSatSkipCount: 999, skipWeekendCount: 999)
                    
                }
                print("less than current time - \(hour!):\(minute!)")
            }
        case "2": // Monday
            if hour! > GlobalVars.workoutNotificationStartHour && minute! > GlobalVars.workoutNotificationStartMin{
                if GlobalVars.notificationSettingsWeekday == true && GlobalVars.notificationSettingsWeekend == false{
                    
                    // clears out all set notifications
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                
                    notificationStart(dayCountStart: 0, maxLoop: 7, findSatSkipCount: 5, skipWeekendCount: 7)
                
                }
                if GlobalVars.notificationSettingsWeekday == false && GlobalVars.notificationSettingsWeekend == true{
                    
                    // clears out all set notifications
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                
                    notificationStart(dayCountStart: 4, maxLoop: 4, findSatSkipCount: 7, skipWeekendCount: 12)
                
                }
                if GlobalVars.notificationSettingsWeekday == true && GlobalVars.notificationSettingsWeekend == true{
                    
                    // clears out all set notifications
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                
                    notificationStart(dayCountStart: 0, maxLoop: 7, findSatSkipCount: 999, skipWeekendCount: 999)
                
                }
                print("greater than current time - \(hour!):\(minute!)")
            }else{
                if GlobalVars.notificationSettingsWeekday == true && GlobalVars.notificationSettingsWeekend == false{
                    
                    // clears out all set notifications
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                    
                    notificationStart(dayCountStart: -1, maxLoop: 7, findSatSkipCount: 5, skipWeekendCount: 7)
                    
                }
                if GlobalVars.notificationSettingsWeekday == false && GlobalVars.notificationSettingsWeekend == true{
                    
                    // clears out all set notifications
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                    
                    notificationStart(dayCountStart: 4, maxLoop: 4, findSatSkipCount: 7, skipWeekendCount: 12)
                    
                }
                if GlobalVars.notificationSettingsWeekday == true && GlobalVars.notificationSettingsWeekend == true{
                    
                    // clears out all set notifications
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                    
                    notificationStart(dayCountStart: -1, maxLoop: 7, findSatSkipCount: 999, skipWeekendCount: 999)
                    
                }
                print("less than current time - \(hour!):\(minute!)")
            }
            
        case "3": // Tuesday
            if hour! > GlobalVars.workoutNotificationStartHour && minute! > GlobalVars.workoutNotificationStartMin{
                if GlobalVars.notificationSettingsWeekday == true && GlobalVars.notificationSettingsWeekend == false{
                    
                    // clears out all set notifications
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                
                notificationStart(dayCountStart: 0, maxLoop: 7, findSatSkipCount: 4, skipWeekendCount: 6)
                
                }
                if GlobalVars.notificationSettingsWeekday == false && GlobalVars.notificationSettingsWeekend == true{
                    
                    // clears out all set notifications
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()

                
                    notificationStart(dayCountStart: 3, maxLoop: 4, findSatSkipCount: 6, skipWeekendCount: 11)
                }
                if GlobalVars.notificationSettingsWeekday == true && GlobalVars.notificationSettingsWeekend == true{
                    
                    // clears out all set notifications
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                
                    notificationStart(dayCountStart: 0, maxLoop: 7, findSatSkipCount: 999, skipWeekendCount: 999)
                
                }
                print("greater than current time - \(hour!):\(minute!)")
            }else{
                if GlobalVars.notificationSettingsWeekday == true && GlobalVars.notificationSettingsWeekend == false{
                    
                    // clears out all set notifications
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                    
                    notificationStart(dayCountStart: -1, maxLoop: 7, findSatSkipCount: 4, skipWeekendCount: 6)
                    
                }
                if GlobalVars.notificationSettingsWeekday == false && GlobalVars.notificationSettingsWeekend == true{
                    
                    // clears out all set notifications
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                    
                    notificationStart(dayCountStart: 3, maxLoop: 4, findSatSkipCount: 6, skipWeekendCount: 11)
                    
                }
                if GlobalVars.notificationSettingsWeekday == true && GlobalVars.notificationSettingsWeekend == true{
                    
                    // clears out all set notifications
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                    
                    notificationStart(dayCountStart: -1, maxLoop: 7, findSatSkipCount: 999, skipWeekendCount: 999)
                    
                }
                print("less than current time - \(hour!):\(minute!)")
            }
            
            
        case "4": // Wednesday
            if hour! > GlobalVars.workoutNotificationStartHour && minute! > GlobalVars.workoutNotificationStartMin{
                if GlobalVars.notificationSettingsWeekday == true && GlobalVars.notificationSettingsWeekend == false{
                    
                    // clears out all set notifications
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                
                    notificationStart(dayCountStart: 0, maxLoop: 7, findSatSkipCount: 3, skipWeekendCount: 5)
                
                }
                if GlobalVars.notificationSettingsWeekday == false && GlobalVars.notificationSettingsWeekend == true{
                    
                    // clears out all set notifications
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                
                    notificationStart(dayCountStart: 2, maxLoop: 4, findSatSkipCount: 5, skipWeekendCount: 10)
                
                }
                if GlobalVars.notificationSettingsWeekday == true && GlobalVars.notificationSettingsWeekend == true{
                    
                    // clears out all set notifications
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                
                    notificationStart(dayCountStart: 0, maxLoop: 7, findSatSkipCount: 999, skipWeekendCount: 999)
                
                }
                print("greater than current time - \(hour!):\(minute!)")
            }else{
                if GlobalVars.notificationSettingsWeekday == true && GlobalVars.notificationSettingsWeekend == false{
                    
                    // clears out all set notifications
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                    
                    notificationStart(dayCountStart: -1, maxLoop: 7, findSatSkipCount: 3, skipWeekendCount: 5)
                    
                }
                if GlobalVars.notificationSettingsWeekday == false && GlobalVars.notificationSettingsWeekend == true{
                    
                    // clears out all set notifications
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                    
                    notificationStart(dayCountStart: 2, maxLoop: 4, findSatSkipCount: 5, skipWeekendCount: 10)
                    
                }
                if GlobalVars.notificationSettingsWeekday == true && GlobalVars.notificationSettingsWeekend == true{
                    
                    // clears out all set notifications
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                    
                    notificationStart(dayCountStart: -1, maxLoop: 7, findSatSkipCount: 999, skipWeekendCount: 999)
                    
                }
                print("less than current time - \(hour!):\(minute!)")
            }
            
        case "5": // Thrusday
            if hour! > GlobalVars.workoutNotificationStartHour && minute! > GlobalVars.workoutNotificationStartMin{
                if GlobalVars.notificationSettingsWeekday == true && GlobalVars.notificationSettingsWeekend == false{
                    
                    // clears out all set notifications
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                
                    notificationStart(dayCountStart: 0, maxLoop: 7, findSatSkipCount: 2, skipWeekendCount: 4)
                
                }
                if GlobalVars.notificationSettingsWeekday == false && GlobalVars.notificationSettingsWeekend == true{
                    
                    // clears out all set notifications
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                
                    notificationStart(dayCountStart: 1, maxLoop: 4, findSatSkipCount: 4, skipWeekendCount: 9)
                
                }
                if GlobalVars.notificationSettingsWeekday == true && GlobalVars.notificationSettingsWeekend == true{
                    
                    // clears out all set notifications
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                
                    notificationStart(dayCountStart: 0, maxLoop: 7, findSatSkipCount: 999, skipWeekendCount: 999)
                
                }
                print("greater than current time - \(hour!):\(minute!)")
             }else{
                if GlobalVars.notificationSettingsWeekday == true && GlobalVars.notificationSettingsWeekend == false{
                    
                    // clears out all set notifications
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                    
                    notificationStart(dayCountStart: -1, maxLoop: 7, findSatSkipCount: 2, skipWeekendCount: 4)
                    
                }
                if GlobalVars.notificationSettingsWeekday == false && GlobalVars.notificationSettingsWeekend == true{
                    
                    // clears out all set notifications
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                    
                    notificationStart(dayCountStart: 1, maxLoop: 4, findSatSkipCount: 4, skipWeekendCount: 9)
                    
                }
                if GlobalVars.notificationSettingsWeekday == true && GlobalVars.notificationSettingsWeekend == true{
                    
                    // clears out all set notifications
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                    
                    notificationStart(dayCountStart: -1, maxLoop: 7, findSatSkipCount: 999, skipWeekendCount: 999)
                    
                }
                print("less than current time - \(hour!):\(minute!)")
            }
            
        case "6": // Friday            
            if hour! > GlobalVars.workoutNotificationStartHour && minute! > GlobalVars.workoutNotificationStartMin{
                if GlobalVars.notificationSettingsWeekday == true && GlobalVars.notificationSettingsWeekend == false{
                    
                    // clears out all set notifications
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                
                    notificationStart(dayCountStart: 2, maxLoop: 7, findSatSkipCount: 8, skipWeekendCount: 10)
                
                }
                if GlobalVars.notificationSettingsWeekday == false && GlobalVars.notificationSettingsWeekend == true{
                    
                    // clears out all set notifications
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                
                    notificationStart(dayCountStart: 0, maxLoop: 4, findSatSkipCount: 3, skipWeekendCount: 8)
                
                }
                if GlobalVars.notificationSettingsWeekday == true && GlobalVars.notificationSettingsWeekend == true{
                    
                    // clears out all set notifications
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                
                    notificationStart(dayCountStart: 0, maxLoop: 7, findSatSkipCount: 999, skipWeekendCount: 999)
                
                }
                print("greater than current time - \(hour!):\(minute!)")
            }else{
                if GlobalVars.notificationSettingsWeekday == true && GlobalVars.notificationSettingsWeekend == false{
                    
                    // clears out all set notifications
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                    
                    notificationStart(dayCountStart: -1, maxLoop: 7, findSatSkipCount: 1, skipWeekendCount: 3)
                    
                }
                if GlobalVars.notificationSettingsWeekday == false && GlobalVars.notificationSettingsWeekend == true{
                    
                    // clears out all set notifications
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                    
                    notificationStart(dayCountStart: 0, maxLoop: 4, findSatSkipCount: 3, skipWeekendCount: 8)
                    
                }
                if GlobalVars.notificationSettingsWeekday == true && GlobalVars.notificationSettingsWeekend == true{
                    
                    // clears out all set notifications
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                    
                    notificationStart(dayCountStart: -1, maxLoop: 7, findSatSkipCount: 999, skipWeekendCount: 999)
                    
                }
                print("less than current time - \(hour!):\(minute!)")
            }
            
            
        case "7": // Saturday
            if hour! > GlobalVars.workoutNotificationStartHour && minute! > GlobalVars.workoutNotificationStartMin{
                if GlobalVars.notificationSettingsWeekday == true && GlobalVars.notificationSettingsWeekend == false{
                    
                    // clears out all set notifications
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                
                    notificationStart(dayCountStart: 1, maxLoop: 7, findSatSkipCount: 7, skipWeekendCount: 9)
                
                }
                if GlobalVars.notificationSettingsWeekday == false && GlobalVars.notificationSettingsWeekend == true{
                    
                    // clears out all set notifications
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                
                    notificationStart(dayCountStart: 0, maxLoop: 3, findSatSkipCount: 2, skipWeekendCount: 7)
                
                }
                if GlobalVars.notificationSettingsWeekday == true && GlobalVars.notificationSettingsWeekend == true{
                    
                    // clears out all set notifications
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                
                    notificationStart(dayCountStart: 0, maxLoop: 7, findSatSkipCount: 999, skipWeekendCount: 999)
                
                }
                print("greater than current time - \(hour!):\(minute!)")
            }else{
                if GlobalVars.notificationSettingsWeekday == true && GlobalVars.notificationSettingsWeekend == false{
                    
                    // clears out all set notifications
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                    
                    notificationStart(dayCountStart: 1, maxLoop: 7, findSatSkipCount: 7, skipWeekendCount: 9)
                    
                }
                if GlobalVars.notificationSettingsWeekday == false && GlobalVars.notificationSettingsWeekend == true{
                    
                    // clears out all set notifications
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                    
                    notificationStart(dayCountStart: -1, maxLoop: 3, findSatSkipCount: 2, skipWeekendCount: 7)
                    
                }
                if GlobalVars.notificationSettingsWeekday == true && GlobalVars.notificationSettingsWeekend == true{
                    
                    // clears out all set notifications
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                    
                    notificationStart(dayCountStart: -1, maxLoop: 7, findSatSkipCount: 999, skipWeekendCount: 999)
                    
                }
                print("less than current time - \(hour!):\(minute!)")
            }
            
            
        default:
            break
        }
    }
    
}
