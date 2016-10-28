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
    func myVCDidFinish(_ controller:OneMWWorkoutViewController,indexCount:Int,nextWorkout:String)
}

class OneMWWorkoutViewController: UIViewController {
    
    var delegate:OneMWWorkoutViewControllerDelegate? = nil
    var exerciseTitle = ""
    var exerciseImage = UIImage(named: "")
    var navTitle = ""
    var exercisesCount = 0
    var nextWorkoutTime = ""
    
    var exerciseCountdownTimer = Timer()
    //var exerciseSecondsCount = 0
    var totalTime = 0
    
    @IBOutlet var startWorkoutBtn: UILabel!
    @IBOutlet var getReadyLabel: UILabel! // label for the actual get ready message
    @IBOutlet var getReadyCounterLabel: UILabel! // label that counts down from 5 to the workout
    @IBOutlet var getReadyView: UIVisualEffectView! // whole view container for get ready count down
    @IBOutlet var workoutCountdownLabel: UILabel! // label that counts down from 60 for the workout
    @IBOutlet var exerciseTypeTitle: UILabel!
    @IBOutlet var switchSidesSubTitle: UILabel!
    @IBOutlet var exerciseTypeImage: UIImageView!
    @IBOutlet var closeWorkoutBtnLabel: UIButton!
    
    @IBAction func closeWorkoutBtn(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
        
        exerciseCountdownTimer.invalidate()
        
        // increments the index variable to update to the next exercise
        changeExercise()
        
        // sets the next workout time
        changeNextWorkoutTime()
        print("next workout time is \(nextWorkoutTime)")
        
        // passes the incremented variable to the prior screen delegate
        if (delegate != nil) {
            delegate!.myVCDidFinish(self, indexCount: GlobalVars.exerciseIndexCount, nextWorkout: nextWorkoutTime)
        }
        
        // sets a workout notification an hour from the completion of this workout
        setNextWorkoutNotification()
    }
    
    @IBAction func startWorkoutBtn(_ sender: AnyObject) {// restart button
        getReadyView.isHidden = false
        workoutCountdownLabel.isHidden = false
        
        exerciseCountdownTimer.invalidate()
        setExerciseTimerGetReady(5, timerLabel: "5")
        
        // resets side planks back to starting view when restart button is hit
        if exerciseTitle == "Side Plank"{
            exerciseImage = UIImage(named: "side-plank-right") // sets the  side plank image back to starting image
            exerciseTypeImage.image = exerciseImage // switches the side plank image back
            switchSidesSubTitle.isHidden = false // shows the switch sides sub-title label
        }
    }
        
    func changeExercise(){
        if GlobalVars.exerciseIndexCount == 7{
            return GlobalVars.exerciseIndexCount = 0
        }else{
            var newCount = GlobalVars.exerciseIndexCount
            newCount += 1
            return GlobalVars.exerciseIndexCount = newCount
        }
    }

    func changeNextWorkoutTime(){
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        
        if hour == 11{ // it means it's 11am changing to 12pm (noon)
            if minute < 10{
                return nextWorkoutTime = "\(hour + 1):0\(minute)PM"
            }
            return nextWorkoutTime = "\(hour + 1):\(minute)PM"
        }
        if hour >= 12 && hour < 23{ // means it's at least 12pm
            if minute < 10{
                return nextWorkoutTime = "\(hour + 1 - 12):0\(minute)PM"
            }
            return nextWorkoutTime = "\(hour + 1 - 12):\(minute)PM"
        }
        if hour == 23{
            if minute < 10{
                return nextWorkoutTime = "\(hour + 1 - 12):0\(minute)AM"
            }
            return nextWorkoutTime = "\(hour + 1 - 12):\(minute)AM"
        }
        if hour == 24{ // means it's 12am
            if minute < 10{
                return nextWorkoutTime = "\(hour + 1):0\(minute)AM"
            }
            return nextWorkoutTime = "\(hour + 1):\(minute)AM"
        }else{
            if minute < 10{
                return nextWorkoutTime = "\(hour + 1):0\(minute)AM"
            }
            return nextWorkoutTime = "\(hour + 1):\(minute)AM"
        }
        
    }
    
    //------------------------------------ Notification Function ----------------------------------------------------//
    func workoutNotification(_ fHour: Int, fMin: Int, fCategory: String ,fAlertBody: String, fRepeat: NSCalendar.Unit){
        
        let today = Date()
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components([.year, .month, .day, .hour, .minute, .second], from: today)
//        let hour = components.hour
//        let minute = components.minute
        let month = components.month
        let year = components.year
        let day = components.day
//        let weekday = components.weekday
        
        //NSNotificationCenter.defaultCenter().addObserver(self, selector:"snoozeWorkout:", name: "snoozePressed", object: nil)
        //NSNotificationCenter.defaultCenter().addObserver(self, selector:"skippedWorkout:", name: "skipWorkout", object: nil)
        
        var dateComp:DateComponents = DateComponents()
        dateComp.year = year    // sets to current year
        dateComp.month = month  // sets to current month
        dateComp.day = day      // sets to current day
        dateComp.hour = fHour
        dateComp.minute = fMin
        dateComp.second = 0
        (dateComp as NSDateComponents).timeZone = TimeZone.current
        
        let calender:Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let date:Date = calender.date(from: dateComp)!
        
        let notification:UILocalNotification = UILocalNotification()
        notification.category = fCategory
        notification.alertBody = fAlertBody
        notification.alertAction = "View App"
        notification.fireDate = date
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.repeatInterval = fRepeat // sets when the notification repeats
        
        UIApplication.shared.scheduleLocalNotification(notification)
    }
    //------------------------------------ /Notification Function ---------------------------------------------------//
    
    func setNextWorkoutNotification(){
        
        // clears out all set notifications, just in case
        UIApplication.shared.cancelAllLocalNotifications()
        
        let today = Date()
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components([.year, .month, .day, .hour, .minute, .second], from: today)
        //let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitMonth | .CalendarUnitYear | .CalendarUnitDay, fromDate: today)
        let hour = components.hour
        let minute = components.minute
        
        var dateComp:DateComponents = DateComponents()
        dateComp.hour = hour
        dateComp.minute = minute
        // sets workout for an hour from current time
        workoutNotification(hour! + 1, fMin: minute!, fCategory: GlobalVars.workoutNotificationCategory ,fAlertBody: "It's time for a 1 Minute Workout!", fRepeat: NSCalendar.Unit.hour)
    }
    
    //----------------------------------------- 60 seconds workout timer -----------------------------------------//
    func exerciseTimerRun(){
        GlobalVars.exerciseSecondsCount -= 1 // decreases the count down by 1
        var minutes = (GlobalVars.exerciseSecondsCount / 60) // converts the seconds into minute format
        var seconds = (GlobalVars.exerciseSecondsCount - (minutes * 60)) // converts the seconds back to seconds
        
        let timerOutput = String(format:"%.2d", seconds) // defines the output that is placed on the label
        workoutCountdownLabel.text = timerOutput
        
        // what happens when the timer has 10 seconds left
        if exerciseTitle != "Side Plank"{ // if Side Plank doesn't do the 10 sec reminder vibrate since you switch at 30 sec
            if (GlobalVars.exerciseSecondsCount == 10) {
                AudioServicesPlaySystemSound(1360) // plays double vibrate when there's 10 secs left in workout
            }
        }
        
        // shows switch sides countdown for Side Plank
        if exerciseTitle == "Side Plank" && GlobalVars.exerciseSecondsCount == 30{
            exerciseImage = UIImage(named: "side-plank-left") // sets the new side plank image to the var
            exerciseTypeImage.image = exerciseImage // switches the side plank image
            exerciseCountdownTimer.invalidate() // stops all timers
            AudioServicesPlaySystemSound(1360) // plays double vibrate
            getReadyView.isHidden = false // shows the get ready view
            getReadyCounterLabel.isHidden = false // shows the get ready count down label
            getReadyLabel.text = "Switch Sides" // changes the get rady note
            setExerciseTimerGetReady(5, timerLabel: "5") // sets the geat ready time/countdown
            switchSidesSubTitle.isHidden = true // hides the switch sides sub-title label
        }
        
        // what happens when the timer ends
        if (GlobalVars.exerciseSecondsCount == 0) {
            exerciseCountdownTimer.invalidate() // stops the countdown
            
            
            // increments the index index variable to update to the next exercise
            changeExercise()
            
            // passes the incremented variable to the prior screen delegate
            if (delegate != nil) {
                delegate!.myVCDidFinish(self, indexCount: GlobalVars.exerciseIndexCount, nextWorkout: nextWorkoutTime)
            }
            
            // sends an alert when timer is up
            func gotoWorkoutVC(){
                let vc = OneMWWorkoutViewController(nibName: "OneMWWorkoutViewController", bundle: nil)
                navigationController?.pushViewController(vc, animated: true)
            }
            
            let alert = UIAlertController(title: "Nice Job!", message: "\n\n\nTake an hour break!", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
                (action: UIAlertAction!) in
                
                // sets the next workout time
                self.changeNextWorkoutTime()
                
                // passes the incremented variable to the prior screen delegate
                if (self.delegate != nil) {
                    self.delegate!.myVCDidFinish(self, indexCount: GlobalVars.exerciseIndexCount, nextWorkout: self.nextWorkoutTime)
                }
                
                // sets a workout notification an hour from the completion of this workout
                self.setNextWorkoutNotification()
                
                self.dismiss(animated: true, completion: nil)
            }))
            
            let thumbsImage = UIImage(named: "thumbs-up")
            let imageView = UIImageView(frame: CGRect(x: 117, y: 47, width: 40, height: 40))
            imageView.image = thumbsImage
            
            alert.view.addSubview(imageView)
            
            self.present(alert, animated: true, completion: nil)
            
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate)) // sends vibrate when workout is done
        }
    }
    
    // method that defines the actual timer for minute exercise timer
    func setExerciseTimer(_ timerTime : Int, timerLabel : String){
        
        totalTime = timerTime // sets the timer to starting time desired
        
        workoutCountdownLabel.text = timerLabel // sets timer label to starting time desired
        
        GlobalVars.exerciseSecondsCount = totalTime; // sets timer to an hour
        exerciseCountdownTimer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: #selector(OneMWWorkoutViewController.exerciseTimerRun), userInfo: nil, repeats: true) // sets the timer interval to 1.0 seconds and uses the timerRun method as the countdown
    }
    
    //----------------------------------------- 5 seconds countdown get ready timer -----------------------------------------//
    func exerciseTimerGetReady(){
        GlobalVars.exerciseSecondsCount -= 1 // decreases the count down by 1
        let minutes = (GlobalVars.exerciseSecondsCount / 60) // converts the seconds into minute format
        let seconds = (GlobalVars.exerciseSecondsCount - (minutes * 60)) // converts the seconds back to seconds
        let timerOutput = String(format:"%.d", seconds) // defines the output that is placed on the label
        getReadyCounterLabel.text = timerOutput
        
        // what happens when the timer ends
        if (GlobalVars.exerciseSecondsCount == 0) {
            // sets workout timer to 30 seconds remaining after switch sides view for Side Plank
            if switchSidesSubTitle.isHidden == true && exerciseTitle == "Side Plank"{
                exerciseCountdownTimer.invalidate() // stops all timers
                workoutCountdownLabel.text = "30"
                setExerciseTimer(30, timerLabel: "30")
                getReadyLabel.text = "Get ready to workout!"
                getReadyView.isHidden = true
                print("switched sides timer reset was triggered")
            }else {// regular 5 sec countdown get ready 
                exerciseCountdownTimer.invalidate() // stops the countdown
            
                getReadyView.isHidden = true
                setExerciseTimer(60, timerLabel: "60")
            
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate)) // sends vibrate when 5 sec countdown is done
                print("get ready triggered else")
            }
        }
    }
    
    // method that defines the actual timer for hour exercise timer
    func setExerciseTimerGetReady(_ timerTime : Int, timerLabel : String){
        
        totalTime = timerTime // sets the timer to starting time desired
        
        getReadyCounterLabel.text = timerLabel // sets timer label to starting time desired
        
        GlobalVars.exerciseSecondsCount = totalTime; // sets timer to an hour
        exerciseCountdownTimer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: #selector(OneMWWorkoutViewController.exerciseTimerGetReady), userInfo: nil, repeats: true) // sets the timer interval to 1.0 seconds and uses the timerRun method as the countdown
        
    }
    
    // this fucntion doesn't appear to be used delete if anything strange is noticed while testing beta 0.0.9
//    func setNotificationTime(){
//        
//        let today = Date()
//        let calendar = Calendar.current
//        let components = (calendar as NSCalendar).components([.year, .month, .day, .hour, .minute, .second], from: today)
//        //let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitMonth | .CalendarUnitYear | .CalendarUnitDay, fromDate: today)
//        let hour = components.hour
//        let minutes = components.minute
//        let seconds = components.second
//        let month = components.month
//        let year = components.year
//        let day = components.day
//        let weekday = components.weekday
//        
//        var minutesFix = minutes
//        
//        if minutes! < 10{
//            var minutesFix = "/(minutes + 10)"
//        }
//
//        if hour < 11{
//            //nextWorkoutNotificationLabel.text = "\(hour + 1):\(minutesFix)AM"
//        }
//        
//        if hour == 11{
//            //nextWorkoutNotificationLabel.text = "\(hour + 1):\(minutesFix)PM"
//        }
//        
//        if hour == 12{
//            //nextWorkoutNotificationLabel.text = "1:\(minutesFix)PM"
//        }
//        
//        if hour > 12{
//            //nextWorkoutNotificationLabel.text = "\((hour - 12) + 1):\(minutesFix)PM"
//        }
//        if hour == 23{
//            //nextWorkoutNotificationLabel.text = "12:\(minutesFix)AM"
//        }
//        
//        if hour == 24{
//            //nextWorkoutNotificationLabel.text = "1:\(minutesFix)AM"
//        }
//    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // sets up the initial view and points page vars at right vars
        exercisesCount = GlobalVars.exerciseUB.count
        navigationItem.title = navTitle
        exerciseTypeTitle.text = exerciseTitle
        exerciseTypeImage.image = exerciseImage
        
        startWorkoutBtn.isHidden = true
        
        // sets the get ready to workout countdown view
        getReadyView.isHidden = false
        workoutCountdownLabel.isHidden = false
        setExerciseTimerGetReady(5, timerLabel: "5")
        
        // sets the get ready to workout label for the initial workout start message
        getReadyLabel.text = "Get ready to workout!"
        
        //hide switch sides sub-title by default
        switchSidesSubTitle.isHidden = true
        
        //show switch sides sub-title for Side Plank
        if exerciseTitle == "Side Plank"{
            switchSidesSubTitle.isHidden = false
            switchSidesSubTitle.text = "Switch Sides @ 30 Secs"
        }else
        //show switch sides sub-title for Lunges
        if exerciseTitle == "Lunges"{
            switchSidesSubTitle.isHidden = false
            switchSidesSubTitle.text = "Alternate Sides"
        }else{
            switchSidesSubTitle.isHidden = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToInfo"{
            
            // false = UB objects (default start)  true = LB objects
            if navigationItem.title == "Upper Body + Core"{
                // set up OneMWViewController to show Upper Body stuff
                GlobalVars.exerciseGroup = true
                
                let vc = segue.destination as! OneMWInfoViewController
                vc.exerciseTitle = GlobalVars.exerciseUB[GlobalVars.exerciseIndexCount].name
                vc.exerciseTips = GlobalVars.exerciseUB[GlobalVars.exerciseIndexCount].tips
            }
            if navigationItem.title == "Lower Body + Core"{
                // set up OneMWViewController to show Lower Body stuff
                GlobalVars.exerciseGroup = false
                
                let vc = segue.destination as! OneMWInfoViewController
                vc.exerciseTitle = GlobalVars.exerciseLB[GlobalVars.exerciseIndexCount].name
                vc.exerciseTips = GlobalVars.exerciseLB[GlobalVars.exerciseIndexCount].tips
            }
            if navigationItem.title == "All Core"{
                // set up OneMWViewController to show Core stuff
                GlobalVars.exerciseGroup = false
                
                let vc = segue.destination as! OneMWInfoViewController
                vc.exerciseTitle = GlobalVars.exerciseCore[GlobalVars.exerciseIndexCount].name
                vc.exerciseTips = GlobalVars.exerciseCore[GlobalVars.exerciseIndexCount].tips
            }
        }

    }
    

}
