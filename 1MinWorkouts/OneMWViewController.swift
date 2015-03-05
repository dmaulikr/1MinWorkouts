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
        
        var calender:NSCalendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)!
        var date:NSDate = calender.dateFromComponents(dateComp)!
        
        var notification:UILocalNotification = UILocalNotification()
        notification.category = ""
        notification.alertBody = "Time to start your day!"
        notification.alertAction = "View App"
        notification.fireDate = date
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.repeatInterval = NSCalendarUnit.CalendarUnitDay // sets when the notification repeats
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)        
        
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
    
        // sets the label for when next workout notification will be sent
        //GlobalVars.workoutNotificationStartMin >= 30
        /*
        1) Check if start time morning or night
        2) Check if the hour is the same as start time
        3) Check if the start time's minute is >= 30 we need to add an hour
        4) Check if it's noon
        */
        
//        if seconds > 0 && minutes < 50 || seconds > 0 && minutes > 50{
//            if hour < 12 && hour == GlobalVars.workoutNotificationStartHour && GlobalVars.workoutNotificationStartMin >= 30{
//                nextWorkoutNotificationLabel.text = "\(hour + 1):50 AM"
//                println("handles start time for when min is 30 or more and it's morning - 1st")
//            }else if hour < 12 && hour == GlobalVars.workoutNotificationStartHour && GlobalVars.workoutNotificationStartMin < 30{
//                nextWorkoutNotificationLabel.text = "\(hour):50 AM"
//                println("handles start time for when min is less than 30 and it's morning - 1st")
//            }else if hour == 12 && hour == GlobalVars.workoutNotificationStartHour && GlobalVars.workoutNotificationStartMin >= 30{
//                nextWorkoutNotificationLabel.text = "\(hour - 11):50 PM"
//                println("handles start time for when min is 30 or more and it's noon - 1st")
//            }else if hour == 12 && hour == GlobalVars.workoutNotificationStartHour && GlobalVars.workoutNotificationStartMin < 30{
//                nextWorkoutNotificationLabel.text = "\(hour):50 PM"
//                println("handles start time for when min is less than 30 and it's noon - 1st")
//            }else if hour > 12 && hour == GlobalVars.workoutNotificationStartHour && GlobalVars.workoutNotificationStartMin >= 30{
//                nextWorkoutNotificationLabel.text = "\(hour - 11):50 PM"
//                println("handles start time for when min is 30 or more and it's afternoon - 1st")
//            }else if hour > 12 && hour == GlobalVars.workoutNotificationStartHour && GlobalVars.workoutNotificationStartMin < 30{
//                nextWorkoutNotificationLabel.text = "\(hour - 12):50 PM"
//                println("handles start time for when min is less than 30 and it's afternoon - 1st")
//            }else if hour < 12 && hour != GlobalVars.workoutNotificationStartHour{
//                nextWorkoutNotificationLabel.text = "\(hour):50 AM"
//                println("handles time for when it's not the start time and it's morning - 1st")
//            }else if hour > 12 && hour != GlobalVars.workoutNotificationStartHour{
//                nextWorkoutNotificationLabel.text = "\(hour - 12):50 PM"
//                println("handles time for when it's not the start time and it's afternoon - 1st")
//            }else if hour == 12 && hour != GlobalVars.workoutNotificationStartHour{
//                nextWorkoutNotificationLabel.text = "\(hour):50 PM"
//                println("handles time for when it's not the start time and it's noon - 1st")
//            }
//        }else if seconds > 0 && minutes == 50{ // deals with notification label time after users has done exercise
//            if hour < 12 && hour == GlobalVars.workoutNotificationStartHour && GlobalVars.workoutNotificationStartMin >= 30{
//                nextWorkoutNotificationLabel.text = "\(hour + 2):50 AM"
//                println("handles start time for when min is 30 or more and it's morning - 2nd")
//            }else if hour < 12 && hour == GlobalVars.workoutNotificationStartHour && GlobalVars.workoutNotificationStartMin < 30{
//                nextWorkoutNotificationLabel.text = "\(hour + 1):50 AM"
//                println("handles start time for when min is less than 30 and it's morning - 2nd")
//            }else if hour == 12 && hour == GlobalVars.workoutNotificationStartHour && GlobalVars.workoutNotificationStartMin >= 30{
//                nextWorkoutNotificationLabel.text = "\(hour - 10):50 PM"
//                println("handles start time for when min is 30 or more and it's noon - 2nd")
//            }else if hour == 12 && hour == GlobalVars.workoutNotificationStartHour && GlobalVars.workoutNotificationStartMin < 30{
//                nextWorkoutNotificationLabel.text = "\(hour + 1):50 PM"
//                println("handles start time for when min is less than 30 and it's noon - 2nd")
//            }else if hour > 12 && hour == GlobalVars.workoutNotificationStartHour && GlobalVars.workoutNotificationStartMin >= 30{
//                nextWorkoutNotificationLabel.text = "\(hour - 10):50 PM"
//                println("handles start time for when min is 30 or more and it's afternoon - 2nd")
//            }else if hour > 12 && hour == GlobalVars.workoutNotificationStartHour && GlobalVars.workoutNotificationStartMin < 30{
//                nextWorkoutNotificationLabel.text = "\(hour - 11):50 PM"
//                println("handles start time for when min is less than 30 and it's afternoon - 2nd")
//            }else if hour < 12 && hour != GlobalVars.workoutNotificationStartHour{
//                nextWorkoutNotificationLabel.text = "\(hour + 1):50 AM"
//                println("handles time for when it's not the start time and it's morning - 2nd")
//            }else if hour > 12 && hour != GlobalVars.workoutNotificationStartHour{
//                nextWorkoutNotificationLabel.text = "\(hour - 12):50 PM"
//                println("handles time for when it's not the start time and it's afternoon - 2nd")
//            }else{
//                nextWorkoutNotificationLabel.text = "\(hour - 11):50 PM"
//                println("handles time for when it's not the start time and it's noon - 2nd")
//            }
//        }
        
                if seconds > 0 && minutes < 50{
                    if hour < 12 {
                        nextWorkoutNotificationLabel.text = "\(hour):50 AM"
                        println("hour < 12 < 50")
                    }else if hour > 12 && minutes < 50{
                        nextWorkoutNotificationLabel.text = "\(hour - 12):50 PM"
                        println("else hour > 12 < 50")
                    }else {
                        nextWorkoutNotificationLabel.text = "\(hour):50 PM"
                        println("else 12")
                    }
                }else
                    if hour < 12 {
                        nextWorkoutNotificationLabel.text = "\(hour + 1):50 AM"
                        println("hour < 12 and > 50")
                    }else {
                        nextWorkoutNotificationLabel.text = "\(hour - 11 ):50 PM"
                        println("else hour > 12 and > 50")
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
        
//        if seconds > 0 && minutes < 50{
//            if hour < 12 {
//                nextWorkoutNotificationLabel.text = "\(hour):50 AM"
//                println("hour < 12 < 50")
//            }else if hour > 12 && minutes < 50{
//                nextWorkoutNotificationLabel.text = "\(hour - 12):50 PM"
//                println("else hour > 12 < 50")
//            }else {
//                nextWorkoutNotificationLabel.text = "\(hour):50 PM"
//                println("else 12")
//            }
//        }else
//            if hour < 12 {
//                nextWorkoutNotificationLabel.text = "\(hour + 1):50 AM"
//                println("hour < 12 and > 50")
//            }else {
//                nextWorkoutNotificationLabel.text = "\(hour - 11 ):50 PM"
//                println("else hour > 12 and > 50")
//        }
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
                
                let vc = segue.destinationViewController as OneMWWorkoutViewController
                vc.navTitle = "Upper Body"
                vc.exerciseTitle = GlobalVars.exerciseUB[GlobalVars.exerciseIndexCount].name
                vc.exerciseImage = UIImage(named: GlobalVars.exerciseUB[GlobalVars.exerciseIndexCount].filename)
                vc.delegate = self
            }else{
                // set up OneMWViewController to show Lower Body stuff
                GlobalVars.exerciseGroup = false
                
                let vc = segue.destinationViewController as OneMWWorkoutViewController
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
                
                let vc = segue.destinationViewController as OneMWInfoViewController
                vc.exerciseTitle = GlobalVars.exerciseUB[GlobalVars.exerciseIndexCount].name
                vc.exerciseTips = GlobalVars.exerciseUB[GlobalVars.exerciseIndexCount].tips
            }else{
                // set up OneMWViewController to show Lower Body stuff
                GlobalVars.exerciseGroup = false
                
                let vc = segue.destinationViewController as OneMWInfoViewController
                vc.exerciseTitle = GlobalVars.exerciseLB[GlobalVars.exerciseIndexCount].name
                vc.exerciseTips = GlobalVars.exerciseLB[GlobalVars.exerciseIndexCount].tips
            }
        }
    }


}
