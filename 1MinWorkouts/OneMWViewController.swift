//
//  1MWViewController.swift
//  1MinWorkouts
//
//  Created by Justin on 12/29/14.
//  Copyright (c) 2014 Good Enough LLC. All rights reserved.
//

import UIKit

protocol NotificatinoTimeViewControllerDelegate{
    func myVCDidFinish2(controller:OneMWViewController, exerciseTime: String)
}

class OneMWViewController: UIViewController, OneMWWorkoutViewControllerDelegate {
    
    var delegate:NotificatinoTimeViewControllerDelegate? = nil
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
//        var message:UIAlertController = UIAlertController(title: "End Day", message: "Ending the day will cancel all workout notifications for the rest of the day. \n \n" + "Are you sure you want to end the day?", preferredStyle: UIAlertControllerStyle.Alert)
//        message.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
//        message.addAction(UIAlertAction(title: "End Day", style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in self.endDay()}))
//        
//        self.presentViewController(message, animated: true, completion: nil)        
    }
    
    func endDay(){
        UIApplication.sharedApplication().cancelAllLocalNotifications() // clears out all set notifications
        // need to reset next days start notification
        let today = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitMonth | .CalendarUnitYear | .CalendarUnitDay, fromDate: today)
        let hour = components.hour
        let minutes = components.minute
        let month = components.month
        let year = components.year
        let day = components.day
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"segueToWorkoutNow:", name: "workoutNowPressed", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"skippedWorkout:", name: "skipWorkout", object: nil)
        
        var dateComp:NSDateComponents = NSDateComponents()
        dateComp.year = year    // sets to current year
        dateComp.month = month  // sets to current month
        dateComp.day = day      // sets to current day
        dateComp.hour = GlobalVars.workoutNotificationStartHour    // sets to current hour
        dateComp.minute = 50
        dateComp.second = 0
        dateComp.timeZone = NSTimeZone.systemTimeZone()
        
        var calender:NSCalendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)!
        var date:NSDate = calender.dateFromComponents(dateComp)!
        
        var notification:UILocalNotification = UILocalNotification()
        notification.category = "WORKOUT-NOW_CATEGORY"
        notification.alertBody = "It's time for a 1 Minute Workout!"
        notification.alertAction = "View App"
        notification.fireDate = date
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.repeatInterval = NSCalendarUnit.CalendarUnitDay // sets when the notification repeats
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
        // need to segue out of this view and back to home
        navigationController?.popToRootViewControllerAnimated(true)
        
        // need to update the next workout notification label and pass it to home
        if (delegate != nil) {
            delegate!.myVCDidFinish2(self, exerciseTime: GlobalVars.endDayNotificationLabel)
            println("\(GlobalVars.endDayNotificationLabel)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let today = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitMonth | .CalendarUnitYear | .CalendarUnitDay, fromDate: today)
        let hour = components.hour
        let minutes = components.minute
        let month = components.month
        let year = components.year
        let day = components.day
        
        if hour == GlobalVars.workoutNotificationEndHour{
            nextWorkoutNotificationLabel.text = "\(GlobalVars.workoutNotificationStartHour):50 AM Tomorrow"
        }else if hour < 12{
            nextWorkoutNotificationLabel.text = "\(hour):50 AM"
        }else {
            nextWorkoutNotificationLabel.text = "\(hour - 12):50 PM"
        }
        
        //my modal transition style
        modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        
        navigationItem.title = navTitle
        exerciseTypeTitle.text = exerciseTitle
        exerciseTypeImage.image = exerciseImage
        
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
