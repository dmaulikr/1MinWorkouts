//
//  OneMWWorkoutViewController.swift
//  1MinWorkouts
//
//  Created by Justin on 1/6/15.
//  Copyright (c) 2015 Good Enough LLC. All rights reserved.
//

import UIKit
import AudioToolbox

protocol OneMWWorkoutViewControllerDelegate{
    func myVCDidFinish(controller:OneMWWorkoutViewController,indexCount:Int)
}

class OneMWWorkoutViewController: UIViewController {
    
    var delegate:OneMWWorkoutViewControllerDelegate? = nil
    var exerciseTitle = ""
    var exerciseImage = UIImage(named: "")
    var navTitle = ""
    var exercisesCount = 0
    
    var exerciseCountdownTimer = NSTimer()
    //var exerciseSecondsCount = 0
    var totalTime = 0
    
    @IBOutlet var startWorkoutBtn: UILabel!
    @IBOutlet var getReadyCounterLabel: UILabel! // label that counts down from 5 to the workout
    @IBOutlet var getReadyView: UIVisualEffectView!
    @IBOutlet var workoutCountdownLabel: UILabel! // label that counts down from 60 for the workout
    @IBOutlet var exerciseTypeTitle: UILabel!
    @IBOutlet var exerciseTypeImage: UIImageView!
    @IBOutlet var closeWorkoutBtnLabel: UIButton!
    
    @IBAction func closeWorkoutBtn(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
        exerciseCountdownTimer.invalidate()
        
        // increments the index variable to update to the next exercise
        changeExercise()
        
        // passes the incremented variable to the prior screen delegate
        if (delegate != nil) {
            delegate!.myVCDidFinish(self, indexCount: GlobalVars.exerciseIndexCount)
        }
        
        // sets a workout notification an hour from the completion of this workout
        setNextWorkoutNotification()
    }
    
    @IBAction func startWorkoutBtn(sender: AnyObject) {
        startWorkoutBtn.hidden = true
        getReadyView.hidden = false
        workoutCountdownLabel.hidden = false
        
        exerciseCountdownTimer.invalidate()
        setExerciseTimerGetReady(5, timerLabel: "5")
    }
        
    func changeExercise(){
        if GlobalVars.exerciseIndexCount == 7{
            return GlobalVars.exerciseIndexCount = 0
        }else{
            var newCount = GlobalVars.exerciseIndexCount
            newCount++
            return GlobalVars.exerciseIndexCount = newCount
        }
    }

    //------------------------------------ Notification Function ----------------------------------------------------//
    func workoutNotification(fHour: Int, fMin: Int, fCategory: String ,fAlertBody: String, fRepeat: NSCalendarUnit){
        
        let today = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitMonth | .CalendarUnitYear | .CalendarUnitDay, fromDate: today)
        let hour = components.hour
        let minutes = components.minute
        let month = components.month
        let year = components.year
        let day = components.day
        let weekday = components.weekday
        
        //NSNotificationCenter.defaultCenter().addObserver(self, selector:"snoozeWorkout:", name: "snoozePressed", object: nil)
        //NSNotificationCenter.defaultCenter().addObserver(self, selector:"skippedWorkout:", name: "skipWorkout", object: nil)
        
        var dateComp:NSDateComponents = NSDateComponents()
        dateComp.year = year    // sets to current year
        dateComp.month = month  // sets to current month
        dateComp.day = day      // sets to current day
        dateComp.hour = fHour
        dateComp.minute = fMin
        dateComp.second = 0
        dateComp.timeZone = NSTimeZone.systemTimeZone()
        
        var calender:NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        var date:NSDate = calender.dateFromComponents(dateComp)!
        
        var notification:UILocalNotification = UILocalNotification()
        notification.category = fCategory
        notification.alertBody = fAlertBody
        notification.alertAction = "View App"
        notification.fireDate = date
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.repeatInterval = fRepeat // sets when the notification repeats
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    //------------------------------------ /Notification Function ---------------------------------------------------//
    
    func setNextWorkoutNotification(){
        
        // clears out all set notifications, just in case
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        
        let today = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitMonth | .CalendarUnitYear | .CalendarUnitDay, fromDate: today)
        let hour = components.hour
        let minute = components.minute
        
        var dateComp:NSDateComponents = NSDateComponents()
        dateComp.hour = hour
        dateComp.minute = minute
        // sets workout for an hour from current time
        workoutNotification(hour + 1, fMin: minute, fCategory: GlobalVars.workoutNotificationCategory ,fAlertBody: "It's time for a 1 Minute Workout!", fRepeat: NSCalendarUnit.CalendarUnitHour)
    }
    
    /////////////////////// method that does the counting down for the 60 seconds timer ///////////////////////////////
    func exerciseTimerRun(){
        GlobalVars.exerciseSecondsCount-- // decreases the count down by 1
        var minutes = (GlobalVars.exerciseSecondsCount / 60) // converts the seconds into minute format
        var seconds = (GlobalVars.exerciseSecondsCount - (minutes * 60)) // converts the seconds back to seconds
        
        let timerOutput = String(format:"%.2d", seconds) // defines the output that is placed on the label
        workoutCountdownLabel.text = timerOutput
        
        // what happens when the timer ends
        if (GlobalVars.exerciseSecondsCount == 0) {
            exerciseCountdownTimer.invalidate() // stops the countdown
            
            
            // increments the index variable to update to the next exercise
            changeExercise()
            
            // passes the incremented variable to the prior screen delegate
            if (delegate != nil) {
                delegate!.myVCDidFinish(self, indexCount: GlobalVars.exerciseIndexCount)
            }
            
            // sends an alert when timer is up
            func gotoWorkoutVC(){
                let vc = OneMWWorkoutViewController(nibName: "OneMWWorkoutViewController", bundle: nil)
                navigationController?.pushViewController(vc, animated: true)
            }
            
            var alert = UIAlertController(title: "Nice Job!", message: "\n\n\nTake an hour break!", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: {
                (action: UIAlertAction!) in
                
                // passes the incremented variable to the prior screen delegate
                if (self.delegate != nil) {
                    self.delegate!.myVCDidFinish(self, indexCount: GlobalVars.exerciseIndexCount)
                    
                
                }
                
                // sets a workout notification an hour from the completion of this workout
                self.setNextWorkoutNotification()
                
                self.dismissViewControllerAnimated(true, completion: nil)
            }))
            
            let thumbsImage = UIImage(named: "thumbs-up")
            var imageView = UIImageView(frame: CGRectMake(117, 47, 40, 40))
            imageView.image = thumbsImage
            
            alert.view.addSubview(imageView)
            
            self.presentViewController(alert, animated: true, completion: nil)
            
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate)) // sends vibrate when workout is done
        }
    }
    
    // method that defines the actual timer for minute exercise timer
    func setExerciseTimer(timerTime : Int, timerLabel : String){
        
        totalTime = timerTime // sets the timer to starting time desired
        
        workoutCountdownLabel.text = timerLabel // sets timer label to starting time desired
        
        GlobalVars.exerciseSecondsCount = totalTime; // sets timer to an hour
        exerciseCountdownTimer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("exerciseTimerRun"), userInfo: nil, repeats: true) // sets the timer interval to 1.0 seconds and uses the timerRun method as the countdown
    }
    
    /////////////////////// method that does the counting down for the 5 seconds get ready timer ///////////////////////////////
    func exerciseTimerGetReady(){
        GlobalVars.exerciseSecondsCount-- // decreases the count down by 1
        var minutes = (GlobalVars.exerciseSecondsCount / 60) // converts the seconds into minute format
        var seconds = (GlobalVars.exerciseSecondsCount - (minutes * 60)) // converts the seconds back to seconds
        
        let timerOutput = String(format:"%.d", seconds) // defines the output that is placed on the label
        getReadyCounterLabel.text = timerOutput
        
        // what happens when the timer ends
        if (GlobalVars.exerciseSecondsCount == 0) {
            exerciseCountdownTimer.invalidate() // stops the countdown
            
            getReadyView.hidden = true
            setExerciseTimer(60, timerLabel: "60")
        }
    }
    
    // method that defines the actual timer for hour exercise timer
    func setExerciseTimerGetReady(timerTime : Int, timerLabel : String){
        
        totalTime = timerTime // sets the timer to starting time desired
        
        getReadyCounterLabel.text = timerLabel // sets timer label to starting time desired
        
        GlobalVars.exerciseSecondsCount = totalTime; // sets timer to an hour
        exerciseCountdownTimer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("exerciseTimerGetReady"), userInfo: nil, repeats: true) // sets the timer interval to 1.0 seconds and uses the timerRun method as the countdown
        
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
        
        var minutesFix = minutes
        
        if minutes < 10{
            var minutesFix = "/(minutes + 10)"
        }
        
        if hour < 11{
            //nextWorkoutNotificationLabel.text = "\(hour + 1):\(minutesFix)AM"
        }
        
        if hour == 11{
            //nextWorkoutNotificationLabel.text = "\(hour + 1):\(minutesFix)PM"
        }
        
        if hour == 12{
            //nextWorkoutNotificationLabel.text = "1:\(minutesFix)PM"
        }
        
        if hour > 12{
            //nextWorkoutNotificationLabel.text = "\((hour - 12) + 1):\(minutesFix)PM"
        }
        if hour == 23{
            //nextWorkoutNotificationLabel.text = "12:\(minutesFix)AM"
        }
        
        if hour == 24{
            //nextWorkoutNotificationLabel.text = "1:\(minutesFix)AM"
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exercisesCount = GlobalVars.exerciseUB.count
        navigationItem.title = navTitle
        exerciseTypeTitle.text = exerciseTitle
        exerciseTypeImage.image = exerciseImage
        
        startWorkoutBtn.hidden = true
        getReadyView.hidden = false
        workoutCountdownLabel.hidden = false
        
        setExerciseTimerGetReady(5, timerLabel: "5")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueToInfo"{
            
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
                // set up OneMWViewController to show Core stuff
                GlobalVars.exerciseGroup = false
                
                let vc = segue.destinationViewController as! OneMWInfoViewController
                vc.exerciseTitle = GlobalVars.exerciseCore[GlobalVars.exerciseIndexCount].name
                vc.exerciseTips = GlobalVars.exerciseCore[GlobalVars.exerciseIndexCount].tips
            }
        }

    }
    

}
