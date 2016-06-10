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
    var nextWorkoutTime = ""
    
    @IBOutlet var exerciseTypeTitle: UILabel!
    @IBOutlet var switchSidesSubTitle: UILabel!
    @IBOutlet var exerciseTypeImage: UIImageView!
    @IBOutlet var exerciseTypeInfoBtn: UIButton!
    @IBOutlet var nextWorkoutNotificationLabel: UILabel!
    
    @IBAction func workoutNowBtn(sender: AnyObject) {
        
    }    
    
    @IBAction func endDayBtn(sender: AnyObject) {
        let message:UIAlertController = UIAlertController(title: "End Day", message: "Ending the day will cancel all workout notifications for the rest of the day. \n \n" + "Are you sure you want to end the day?", preferredStyle: UIAlertControllerStyle.Alert)
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
        dateComp.day = day + 1      // sets to tomorrow
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
            }else{
                let message:UIAlertController = UIAlertController(title: "Weekday Notifications OFF", message: "You don't have Start Notifications on for week days. \n \n" + "To change this goto the in app Settings.", preferredStyle: UIAlertControllerStyle.Alert)
                message.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
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
                
            }else if GlobalVars.notificationSettingsWeekday == true && GlobalVars.notificationSettingsWeekend == false{
                let notification:UILocalNotification = UILocalNotification()
                notification.category = ""
                notification.alertBody = "Time for your first workout of the day!"
                notification.alertAction = "View App"
                notification.fireDate = dateSkipEnd
                notification.soundName = UILocalNotificationDefaultSoundName
                notification.repeatInterval = NSCalendarUnit.Day // sets when the notification repeats
                
                UIApplication.sharedApplication().scheduleLocalNotification(notification)
                
            }else if GlobalVars.notificationSettingsWeekday == false && GlobalVars.notificationSettingsWeekend == true{
                let notification:UILocalNotification = UILocalNotification()
                notification.category = ""
                notification.alertBody = "Time for your first workout of the day!"
                notification.alertAction = "View App"
                notification.fireDate = date
                notification.soundName = UILocalNotificationDefaultSoundName
                notification.repeatInterval = NSCalendarUnit.Day // sets when the notification repeats
                
                UIApplication.sharedApplication().scheduleLocalNotification(notification)
                
            }else{
                let message:UIAlertController = UIAlertController(title: "Weekend Notifications OFF", message: "You don't have Start Notifications on for weekends. \n \n" + "To change this goto the in app Settings.", preferredStyle: UIAlertControllerStyle.Alert)
                message.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
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
            }else{
                let message:UIAlertController = UIAlertController(title: "Weekend Notifications OFF", message: "You don't have Start Notifications on for weekends. \n \n" + "To change this goto the in app Settings.", preferredStyle: UIAlertControllerStyle.Alert)
                message.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
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
            }else{
                let notification:UILocalNotification = UILocalNotification()
                notification.category = ""
                notification.alertBody = "Time to start your day!"
                notification.alertAction = "View App"
                notification.fireDate = dateSkipWeek
                notification.soundName = UILocalNotificationDefaultSoundName
                notification.repeatInterval = NSCalendarUnit.Day // sets when the notification repeats
                
                UIApplication.sharedApplication().scheduleLocalNotification(notification)
            }
            
        default:
            break
        }
        
        // segue out of this view and back to home
        navigationController?.popToRootViewControllerAnimated(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hides switch sides sub-title by default
        switchSidesSubTitle.hidden = true
        
        //my modal transition style
        modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        
        navigationItem.title = navTitle
        exerciseTypeTitle.text = exerciseTitle
        exerciseTypeImage.image = exerciseImage
        
        // assumes this will be seen by the user on their first workout of the day. Should get updated with current time + 1 (e.g. next workout in an hour from now)
        nextWorkoutTime = "Right Now!"
        nextWorkoutNotificationLabel.text = nextWorkoutTime
        
        let settings = UIUserNotificationSettings(forTypes: [.Alert, .Badge], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
    }
    
    //    override func viewWillAppear(animated: Bool) {
    //        // assumes this will be seen by the user on their first workout of the day. Should get updated with current time + 1 (e.g. next workout in an hour from now)
    //        nextWorkoutTime = "Right Now!"
    //        nextWorkoutNotificationLabel.text = nextWorkoutTime
    //    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func myVCDidFinish(controller: OneMWWorkoutViewController, indexCount: Int, nextWorkout: String) {
        if navigationItem.title == "Upper Body + Core"{
            let image = UIImage(named: GlobalVars.exerciseUB[indexCount].filename)
            exerciseTypeImage.image = image
            exerciseTypeTitle.text = GlobalVars.exerciseUB[indexCount].name
            nextWorkoutNotificationLabel.text = nextWorkout
            
            //add switch sub-title to needed exercises
            if GlobalVars.exerciseIndexCount == 5{
                switchSidesSubTitle.hidden = false
                switchSidesSubTitle.text = "Switch Sides @ 30 Secs"
            }else{
                switchSidesSubTitle.hidden = true
            }
        }
        if navigationItem.title == "Lower Body + Core"{
            let image = UIImage(named: GlobalVars.exerciseLB[indexCount].filename)
            exerciseTypeImage.image = image
            exerciseTypeTitle.text = GlobalVars.exerciseLB[indexCount].name
            nextWorkoutNotificationLabel.text = nextWorkout
            
            //add switch sub-title to needed exercises
            if GlobalVars.exerciseIndexCount == 2 || GlobalVars.exerciseIndexCount == 6{
                switchSidesSubTitle.hidden = false
                switchSidesSubTitle.text = "Alternate Sides"
            }else{
                switchSidesSubTitle.hidden = true
            }
        }
        if navigationItem.title == "All Core"{
            let image = UIImage(named: GlobalVars.exerciseCore[indexCount].filename)
            exerciseTypeImage.image = image
            exerciseTypeTitle.text = GlobalVars.exerciseCore[indexCount].name
            nextWorkoutNotificationLabel.text = nextWorkout
            
            //add switch sub-title to needed exercises
            if GlobalVars.exerciseIndexCount == 1 || GlobalVars.exerciseIndexCount == 5{
                switchSidesSubTitle.hidden = false
                switchSidesSubTitle.text = "Switch Sides @ 30 Secs"
            }else{
                switchSidesSubTitle.hidden = true
            }
        }
        controller.navigationController?.popViewControllerAnimated(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueToExerciseNow"{
            
            // false = UB objects (default start)  true = LB objects
            if navigationItem.title == "Upper Body + Core"{
                // set up OneMWViewController to show Upper Body stuff
                GlobalVars.exerciseGroup = true
                
                let vc = segue.destinationViewController as! OneMWWorkoutViewController
                vc.navTitle = "Upper Body + Core"
                vc.exerciseTitle = GlobalVars.exerciseUB[GlobalVars.exerciseIndexCount].name
                vc.exerciseImage = UIImage(named: GlobalVars.exerciseUB[GlobalVars.exerciseIndexCount].filename)
                vc.nextWorkoutTime = "Right Now!"
                vc.delegate = self
            }
            if navigationItem.title == "Lower Body + Core"{
                // set up OneMWViewController to show Lower Body stuff
                GlobalVars.exerciseGroup = false
                
                let vc = segue.destinationViewController as! OneMWWorkoutViewController
                vc.navTitle = "Lower Body + Core"
                vc.exerciseTitle = GlobalVars.exerciseLB[GlobalVars.exerciseIndexCount].name
                vc.exerciseImage = UIImage(named: GlobalVars.exerciseLB[GlobalVars.exerciseIndexCount].filename)
                vc.nextWorkoutTime = "Right Now!"
                vc.delegate = self
            }
            if navigationItem.title == "All Core"{
                // set up OneMWViewController to show All Core stuff
                GlobalVars.exerciseGroup = false
                
                let vc = segue.destinationViewController as! OneMWWorkoutViewController
                vc.navTitle = "All Core"
                vc.exerciseTitle = GlobalVars.exerciseCore[GlobalVars.exerciseIndexCount].name
                vc.exerciseImage = UIImage(named: GlobalVars.exerciseCore[GlobalVars.exerciseIndexCount].filename)
                vc.nextWorkoutTime = "Right Now!"
                vc.delegate = self
            }
        }
        
        if segue.identifier == "segueToExerciseInfo"{
            
            // false = UB objects (default start)  true = LB objects
            if navigationItem.title == "Upper Body + Core"{
                // set up OneMWViewController to show Upper Body stuff
                GlobalVars.exerciseGroup = true
                
                let vc = segue.destinationViewController as! OneMWInfoViewController
                vc.exerciseTitle = GlobalVars.exerciseUB[GlobalVars.exerciseIndexCount].name
                vc.exerciseTips = GlobalVars.exerciseUB[GlobalVars.exerciseIndexCount].tips
            }
            if navigationItem.title == "Lower Body + Core"{
                // set up OneMWViewController to show Lower Body stuff
                GlobalVars.exerciseGroup = false
                
                let vc = segue.destinationViewController as! OneMWInfoViewController
                vc.exerciseTitle = GlobalVars.exerciseLB[GlobalVars.exerciseIndexCount].name
                vc.exerciseTips = GlobalVars.exerciseLB[GlobalVars.exerciseIndexCount].tips
            }
            if navigationItem.title == "All Core"{
                // set up OneMWViewController to show All Core stuff
                GlobalVars.exerciseGroup = false
                
                let vc = segue.destinationViewController as! OneMWInfoViewController
                vc.exerciseTitle = GlobalVars.exerciseCore[GlobalVars.exerciseIndexCount].name
                vc.exerciseTips = GlobalVars.exerciseCore[GlobalVars.exerciseIndexCount].tips
            }
        }
    }


}
