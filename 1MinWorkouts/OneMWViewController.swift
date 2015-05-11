//
//  1MWViewController.swift
//  1MinWorkouts
//
//  Created by Justin on 12/29/14.
//  Copyright (c) 2014 Good Enough LLC. All rights reserved.
//

import UIKit


class OneMWViewController: UIViewController, OneMWWorkoutViewControllerDelegate {
    
    var exerciseTitle = ""
    var exerciseImage = UIImage(named: "")
    var navTitle = ""
    
    @IBOutlet var exerciseTypeTitle: UILabel!
    @IBOutlet var exerciseTypeImage: UIImageView!
    @IBOutlet var exerciseTypeInfoBtn: UIButton!
    @IBOutlet var nextWorkoutNotificationLabel: UILabel!
    
    @IBAction func workoutNowBtn(sender: AnyObject) {
        
    }    
    
    @IBAction func endDayBtn(sender: AnyObject) {
        var message:UIAlertController = UIAlertController(title: "End Day", message: "Ending the day will cancel all workout notifications for the rest of the day. \n \n" + "Are you sure you want to end the day?", preferredStyle: UIAlertControllerStyle.Alert)
        message.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        message.addAction(UIAlertAction(title: "End Day", style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in self.endDay()}))
        
        self.presentViewController(message, animated: true, completion: nil)        
    }
    
    func endDay(){
        
        // clears out all set notifications
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        
        // reset workout counter to 0
        GlobalVars.exerciseIndexCount = 0
        
        // need to reset next days start notification
        let today = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitMonth | .CalendarUnitYear | .CalendarUnitDay, fromDate: today)
        let hour = components.hour
        let minutes = components.minute
        let month = components.month
        let year = components.year
        let day = components.day
        
        var dateComp:NSDateComponents = NSDateComponents()
        dateComp.year = year    // sets to current year
        dateComp.month = month  // sets to current month
        dateComp.day = day + 1      // sets to tomorrow
        dateComp.hour = GlobalVars.workoutNotificationStartHour     // sets to current hour
        dateComp.minute = GlobalVars.workoutNotificationStartMin    // sets to users work start time
        dateComp.second = 0
        dateComp.timeZone = NSTimeZone.systemTimeZone()
        
        var dateCompSkipEnd:NSDateComponents = NSDateComponents()
        dateCompSkipEnd.year = year    // sets to current year
        dateCompSkipEnd.month = month  // sets to current month
        dateCompSkipEnd.day = day + 3      // sets to tomorrow
        dateCompSkipEnd.hour = GlobalVars.workoutNotificationStartHour     // sets to current hour
        dateCompSkipEnd.minute = GlobalVars.workoutNotificationStartMin    // sets to users work start time
        dateCompSkipEnd.second = 0
        dateCompSkipEnd.timeZone = NSTimeZone.systemTimeZone()
        
        var dateCompSkipWeek:NSDateComponents = NSDateComponents()
        dateCompSkipWeek.year = year    // sets to current year
        dateCompSkipWeek.month = month  // sets to current month
        dateCompSkipWeek.day = day + 6      // sets to tomorrow
        dateCompSkipWeek.hour = GlobalVars.workoutNotificationStartHour     // sets to current hour
        dateCompSkipWeek.minute = GlobalVars.workoutNotificationStartMin    // sets to users work start time
        dateCompSkipWeek.second = 0
        dateCompSkipWeek.timeZone = NSTimeZone.systemTimeZone()
        
        var calender:NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        var date:NSDate = calender.dateFromComponents(dateComp)!
        var dateSkipEnd:NSDate = calender.dateFromComponents(dateCompSkipEnd)!
        var dateSkipWeek:NSDate = calender.dateFromComponents(dateCompSkipWeek)!
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "e"
        var dayOfWeek = dateFormatter.stringFromDate(today)
        
        switch dayOfWeek{
        case "2"..."5": // if it's a weekday and weekdays are ON
            if GlobalVars.notificationSettingsWeekday == true{
                var notification:UILocalNotification = UILocalNotification()
                notification.category = ""
                notification.alertBody = "Time to start your day!"
                notification.alertAction = "View App"
                notification.fireDate = date
                notification.soundName = UILocalNotificationDefaultSoundName
                notification.repeatInterval = NSCalendarUnit.CalendarUnitDay // sets when the notification repeats
                
                UIApplication.sharedApplication().scheduleLocalNotification(notification)
                
                println("You'll get a notification every day during the week")
            }else{
                var message:UIAlertController = UIAlertController(title: "Weekday Notifications OFF", message: "You don't have Start Notifications on for week days. \n \n" + "To change this goto the in app Settings.", preferredStyle: UIAlertControllerStyle.Alert)
                message.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
                
                println("Notifications are off so no start notifcations set")
            }
            
        case "6":
            if GlobalVars.notificationSettingsWeekend == true{
                var notification:UILocalNotification = UILocalNotification()
                notification.category = ""
                notification.alertBody = "Time to start your day!"
                notification.alertAction = "View App"
                notification.fireDate = date
                notification.soundName = UILocalNotificationDefaultSoundName
                notification.repeatInterval = NSCalendarUnit.CalendarUnitDay // sets when the notification repeats
                
                UIApplication.sharedApplication().scheduleLocalNotification(notification)
                
                println("You'll get a notification tomorrow (sat)")
                
            }else if GlobalVars.notificationSettingsWeekday == true && GlobalVars.notificationSettingsWeekend == false{
                var notification:UILocalNotification = UILocalNotification()
                notification.category = ""
                notification.alertBody = "Time to start your day!"
                notification.alertAction = "View App"
                notification.fireDate = dateSkipEnd
                notification.soundName = UILocalNotificationDefaultSoundName
                notification.repeatInterval = NSCalendarUnit.CalendarUnitDay // sets when the notification repeats
                
                UIApplication.sharedApplication().scheduleLocalNotification(notification)
                
                println("You'll get a notification on Monday")
                
            }else if GlobalVars.notificationSettingsWeekday == false && GlobalVars.notificationSettingsWeekend == true{
                var notification:UILocalNotification = UILocalNotification()
                notification.category = ""
                notification.alertBody = "Time to start your day!"
                notification.alertAction = "View App"
                notification.fireDate = date
                notification.soundName = UILocalNotificationDefaultSoundName
                notification.repeatInterval = NSCalendarUnit.CalendarUnitDay // sets when the notification repeats
                
                UIApplication.sharedApplication().scheduleLocalNotification(notification)
                
                println("You'll get a notification tomorrow (sat)")
                
            }else{
                var message:UIAlertController = UIAlertController(title: "Weekend Notifications OFF", message: "You don't have Start Notifications on for weekends. \n \n" + "To change this goto the in app Settings.", preferredStyle: UIAlertControllerStyle.Alert)
                message.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
                
                println("Notifications are off so no start notifcations set")
            }
            
        case "1": // if it's a weekend and weekdays are ON
            if GlobalVars.notificationSettingsWeekend == true{
                var notification:UILocalNotification = UILocalNotification()
                notification.category = ""
                notification.alertBody = "Time to start your day!"
                notification.alertAction = "View App"
                notification.fireDate = date
                notification.soundName = UILocalNotificationDefaultSoundName
                notification.repeatInterval = NSCalendarUnit.CalendarUnitDay // sets when the notification repeats
                
                UIApplication.sharedApplication().scheduleLocalNotification(notification)
                
                println("You'll get a notification tomorrow")
            }else{
                var message:UIAlertController = UIAlertController(title: "Weekend Notifications OFF", message: "You don't have Start Notifications on for weekends. \n \n" + "To change this goto the in app Settings.", preferredStyle: UIAlertControllerStyle.Alert)
                message.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
                
                println("Notifications are off so no start notifcations set")
            }
            
        case "7":
            if GlobalVars.notificationSettingsWeekday == true{
                var notification:UILocalNotification = UILocalNotification()
                notification.category = ""
                notification.alertBody = "Time to start your day!"
                notification.alertAction = "View App"
                notification.fireDate = date
                notification.soundName = UILocalNotificationDefaultSoundName
                notification.repeatInterval = NSCalendarUnit.CalendarUnitDay // sets when the notification repeats
                
                UIApplication.sharedApplication().scheduleLocalNotification(notification)
                
                println("You'll get a notification tomorrow")
            }else{
                var notification:UILocalNotification = UILocalNotification()
                notification.category = ""
                notification.alertBody = "Time to start your day!"
                notification.alertAction = "View App"
                notification.fireDate = dateSkipWeek
                notification.soundName = UILocalNotificationDefaultSoundName
                notification.repeatInterval = NSCalendarUnit.CalendarUnitDay // sets when the notification repeats
                
                UIApplication.sharedApplication().scheduleLocalNotification(notification)
                
                println("You'll get a notification on Sunday")
            }
            
        default:
            break
        }
        
        // segue out of this view and back to home
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func setNotificationTime(){
        
        let today = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitMonth | .CalendarUnitYear | .CalendarUnitDay, fromDate: today)
        let hour = components.hour
        let minutes = components.minute
        let seconds = components.second
        let month = components.month
        let year = components.year
        let day = components.day
        let weekday = components.weekday
    
                // at 3:00 label shows 16:50AM?
                if seconds > 0 && minutes < 50{
                    if GlobalVars.workoutNotificationStartMin >= 30 && hour == GlobalVars.workoutNotificationStartHour{
                        nextWorkoutNotificationLabel.text = "\(hour + 1):50 AM"
                        println("hour < 12 < 50 - 1st")
                    }else if hour < 12 {
                        nextWorkoutNotificationLabel.text = "\(hour):50 AM"
                        println("it's the morning - 1st")
                    }else if hour > 12 && minutes < 50{
                        nextWorkoutNotificationLabel.text = "\(hour - 12):50 PM"
                        println("it's afternoon and not too late in the hour - 1st")
                    }else {
                        nextWorkoutNotificationLabel.text = "\(hour):50 PM"
                        println("It's noon - 1st")
                    }
                }else
                    if hour < 12 {
                        nextWorkoutNotificationLabel.text = "\(hour + 1):50 AM"
                        println("it's the morning - 2nd")
                    }else {
                        nextWorkoutNotificationLabel.text = "\(hour - 11 ):50 PM"
                        println("it's afternoon - 2nd")
                }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //my modal transition style
        modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        
        navigationItem.title = navTitle
        exerciseTypeTitle.text = exerciseTitle
        exerciseTypeImage.image = exerciseImage        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        // sets the notification time based on start time and current time
        setNotificationTime()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func myVCDidFinish(controller: OneMWWorkoutViewController, indexCount: Int) {
        if navigationItem.title == "Upper Body"{
            var image = UIImage(named: GlobalVars.exerciseUB[indexCount].filename)
            exerciseTypeImage.image = image
            exerciseTypeTitle.text = GlobalVars.exerciseUB[indexCount].name
        }else{
            var image = UIImage(named: GlobalVars.exerciseLB[indexCount].filename)
            exerciseTypeImage.image = image
            exerciseTypeTitle.text = GlobalVars.exerciseLB[indexCount].name
        }
        controller.navigationController?.popViewControllerAnimated(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueToExerciseNow"{
            
            // false = UB objects (default start)  true = LB objects
            if navigationItem.title == "Upper Body"{
                // set up OneMWViewController to show Upper Body stuff
                GlobalVars.exerciseGroup = true
                
                let vc = segue.destinationViewController as! OneMWWorkoutViewController
                vc.navTitle = "Upper Body"
                vc.exerciseTitle = GlobalVars.exerciseUB[GlobalVars.exerciseIndexCount].name
                vc.exerciseImage = UIImage(named: GlobalVars.exerciseUB[GlobalVars.exerciseIndexCount].filename)
                vc.delegate = self
            }else{
                // set up OneMWViewController to show Lower Body stuff
                GlobalVars.exerciseGroup = false
                
                let vc = segue.destinationViewController as! OneMWWorkoutViewController
                vc.navTitle = "Lower Body"
                vc.exerciseTitle = GlobalVars.exerciseLB[GlobalVars.exerciseIndexCount].name
                vc.exerciseImage = UIImage(named: GlobalVars.exerciseLB[GlobalVars.exerciseIndexCount].filename)
                vc.delegate = self
            }
        }
        
        if segue.identifier == "segueToExerciseInfo"{
            
            // false = UB objects (default start)  true = LB objects
            if navigationItem.title == "Upper Body"{
                // set up OneMWViewController to show Upper Body stuff
                GlobalVars.exerciseGroup = true
                
                let vc = segue.destinationViewController as! OneMWInfoViewController
                vc.exerciseTitle = GlobalVars.exerciseUB[GlobalVars.exerciseIndexCount].name
                vc.exerciseTips = GlobalVars.exerciseUB[GlobalVars.exerciseIndexCount].tips
            }else{
                // set up OneMWViewController to show Lower Body stuff
                GlobalVars.exerciseGroup = false
                
                let vc = segue.destinationViewController as! OneMWInfoViewController
                vc.exerciseTitle = GlobalVars.exerciseLB[GlobalVars.exerciseIndexCount].name
                vc.exerciseTips = GlobalVars.exerciseLB[GlobalVars.exerciseIndexCount].tips
            }
        }
    }


}
