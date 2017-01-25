//
//  1MWViewController.swift
//  1MinWorkouts
//
//  Created by Justin on 12/29/14.
//  Copyright (c) 2014 Good Enough LLC. All rights reserved.
//

import UIKit
import UserNotifications


class OneMWViewController: UIViewController, OneMWWorkoutViewControllerDelegate {
    
    let whyNotificationsSettings = UserDefaults.standard // instantiates a user default holder for why notifications alert
    
    var exerciseTitle = ""
    var exerciseImage = UIImage(named: "")
    var navTitle = ""
    var nextWorkoutTime = ""
    
    @IBOutlet var exerciseTypeTitle: UILabel!
    @IBOutlet var switchSidesSubTitle: UILabel!
    @IBOutlet var exerciseTypeImage: UIImageView!
    @IBOutlet var exerciseTypeInfoBtn: UIButton!
    @IBOutlet var nextWorkoutNotificationLabel: UILabel!
    
//    @IBAction func workoutNowBtn(_ sender: AnyObject) {
//        
//    }    
    
    @IBAction func endDayBtn(_ sender: AnyObject) {
        let message:UIAlertController = UIAlertController(title: "End Day", message: "Ending the day will cancel all workout notifications for the rest of the day. \n \n" + "Are you sure you want to end the day?", preferredStyle: UIAlertControllerStyle.alert)
        message.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        message.addAction(UIAlertAction(title: "End Day", style: UIAlertActionStyle.default, handler: {(alert: UIAlertAction!) in self.endDay()}))
        
        self.present(message, animated: true, completion: nil)        
    }
    
    func endDay(){
        
        // reset workout counter index to 0
        GlobalVars.exerciseIndexCount = 0
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests() //  removes/clears all pending notification request
        
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
            var notifContent = "It's time for your first workout of the day!"
            for _ in 1...maxLoop { // iterates based on var maxLoop setting
                addDay += 1  // sets the notification date to next day and then increments the added day by one for each iteration of the Loop
                
                if addDay == findSatSkipCount{ // checks to find when Saturday is within the 7 iterations
                    addDay = skipWeekendCount  // skips the weekend and adds two more notifications for 7 total set
                    notifContent = "It's been several days since your last workout. Might be a good time to start up again before you get to saggy 😁"
                }
                
                let center = UNUserNotificationCenter.current()
                
                let content = UNMutableNotificationContent()
                content.body = notifContent
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
        }
        
        switch dayOfWeek{
        case "1": // Sunday
            if GlobalVars.notificationSettingsWeekday == true && GlobalVars.notificationSettingsWeekend == false{
                
                notificationStart(dayCountStart: 0, maxLoop: 7, findSatSkipCount: 6, skipWeekendCount: 8)
                
            }
            if GlobalVars.notificationSettingsWeekday == false && GlobalVars.notificationSettingsWeekend == true{
                
                notificationStart(dayCountStart: 5, maxLoop: 4, findSatSkipCount: 8, skipWeekendCount: 8)
                
            }
            if GlobalVars.notificationSettingsWeekday == true && GlobalVars.notificationSettingsWeekend == true{
                
                notificationStart(dayCountStart: 0, maxLoop: 7, findSatSkipCount: 999, skipWeekendCount: 999)
                
            }
            
        case "2": // Monday
            if GlobalVars.notificationSettingsWeekday == true && GlobalVars.notificationSettingsWeekend == false{
                
                notificationStart(dayCountStart: 0, maxLoop: 7, findSatSkipCount: 5, skipWeekendCount: 7)
                
            }
            if GlobalVars.notificationSettingsWeekday == false && GlobalVars.notificationSettingsWeekend == true{
                
                notificationStart(dayCountStart: 4, maxLoop: 4, findSatSkipCount: 7, skipWeekendCount: 12)
                
            }
            if GlobalVars.notificationSettingsWeekday == true && GlobalVars.notificationSettingsWeekend == true{
                
                notificationStart(dayCountStart: 0, maxLoop: 7, findSatSkipCount: 999, skipWeekendCount: 999)
                
            }
            
        case "3": // Tuesday
            if GlobalVars.notificationSettingsWeekday == true && GlobalVars.notificationSettingsWeekend == false{
                
                notificationStart(dayCountStart: 0, maxLoop: 7, findSatSkipCount: 4, skipWeekendCount: 6)
                
            }
            if GlobalVars.notificationSettingsWeekday == false && GlobalVars.notificationSettingsWeekend == true{
                
                notificationStart(dayCountStart: 3, maxLoop: 4, findSatSkipCount: 6, skipWeekendCount: 11)
                
            }
            if GlobalVars.notificationSettingsWeekday == true && GlobalVars.notificationSettingsWeekend == true{
                
                notificationStart(dayCountStart: 0, maxLoop: 7, findSatSkipCount: 999, skipWeekendCount: 999)
                
            }

            
        case "4": // Wednesday
            if GlobalVars.notificationSettingsWeekday == true && GlobalVars.notificationSettingsWeekend == false{
                
                notificationStart(dayCountStart: 0, maxLoop: 7, findSatSkipCount: 3, skipWeekendCount: 5)
                
            }
            if GlobalVars.notificationSettingsWeekday == false && GlobalVars.notificationSettingsWeekend == true{
                
                notificationStart(dayCountStart: 2, maxLoop: 4, findSatSkipCount: 5, skipWeekendCount: 10)
                
            }
            if GlobalVars.notificationSettingsWeekday == true && GlobalVars.notificationSettingsWeekend == true{
                
                notificationStart(dayCountStart: 0, maxLoop: 7, findSatSkipCount: 999, skipWeekendCount: 999)
                
            }

            
        case "5": // Thrusday
            if GlobalVars.notificationSettingsWeekday == true && GlobalVars.notificationSettingsWeekend == false{
                
                notificationStart(dayCountStart: 0, maxLoop: 7, findSatSkipCount: 2, skipWeekendCount: 4)
                
            }
            if GlobalVars.notificationSettingsWeekday == false && GlobalVars.notificationSettingsWeekend == true{
                
                notificationStart(dayCountStart: 1, maxLoop: 4, findSatSkipCount: 4, skipWeekendCount: 9)
                
            }
            if GlobalVars.notificationSettingsWeekday == true && GlobalVars.notificationSettingsWeekend == true{
                
                notificationStart(dayCountStart: 0, maxLoop: 7, findSatSkipCount: 999, skipWeekendCount: 999)
                
            }

            
        case "6": // Friday
            if GlobalVars.notificationSettingsWeekday == true && GlobalVars.notificationSettingsWeekend == false{
                
                notificationStart(dayCountStart: 2, maxLoop: 7, findSatSkipCount: 8, skipWeekendCount: 10)
                
            }
            if GlobalVars.notificationSettingsWeekday == false && GlobalVars.notificationSettingsWeekend == true{
                
                notificationStart(dayCountStart: 0, maxLoop: 4, findSatSkipCount: 3, skipWeekendCount: 8)
                
            }
            if GlobalVars.notificationSettingsWeekday == true && GlobalVars.notificationSettingsWeekend == true{
                
                notificationStart(dayCountStart: 0, maxLoop: 7, findSatSkipCount: 999, skipWeekendCount: 999)
                
            }
            
        case "7": // Saturday
            if GlobalVars.notificationSettingsWeekday == true && GlobalVars.notificationSettingsWeekend == false{
                
                notificationStart(dayCountStart: 1, maxLoop: 7, findSatSkipCount: 7, skipWeekendCount: 9)
                
            }
            if GlobalVars.notificationSettingsWeekday == false && GlobalVars.notificationSettingsWeekend == true{
                
                notificationStart(dayCountStart: 0, maxLoop: 3, findSatSkipCount: 2, skipWeekendCount: 7)
                
            }
            if GlobalVars.notificationSettingsWeekday == true && GlobalVars.notificationSettingsWeekend == true{
                
                notificationStart(dayCountStart: 0, maxLoop: 7, findSatSkipCount: 999, skipWeekendCount: 999)
                
            }

            
        default:
            break
        }
        
        // segue out of this view and back to home
        navigationController!.popToRootViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hides switch sides sub-title by default
        switchSidesSubTitle.isHidden = true
        
        //my modal transition style
        modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        
        navigationItem.title = navTitle
        exerciseTypeTitle.text = exerciseTitle
        exerciseTypeImage.image = exerciseImage
        
        // assumes this will be seen by the user on their first workout of the day. Should get updated with current time + 1 (e.g. next workout in an hour from now)
        nextWorkoutTime = "Right Now!"
        nextWorkoutNotificationLabel.text = nextWorkoutTime
        
        // Checks to see if why notification alert has been shown already
        GlobalVars.whyNotificationsAlert = whyNotificationsSettings.bool(forKey: "whyNotificationsAlert") // sets the whyNotificationsAlert userDeafault to GlobalVars
        
        if GlobalVars.whyNotificationsAlert == false{
            // create the alert
            let alert = UIAlertController(title: "Please Allow Notifications", message: "\n\n\nTo get the most out of 1MinuteWorkouts please ALLOW notifications on the next screen.\n\nThis will allow us to notify you when you have a workout to do.", preferredStyle: UIAlertControllerStyle.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {
                (action: UIAlertAction!) in
                
                self.whyNotificationsSettings.set(true, forKey: "whyNotificationsAlert") // sets the whyNotificationsAlert userDeafaults and then set that to GlobalVars
                GlobalVars.whyNotificationsAlert = self.whyNotificationsSettings.bool(forKey: "whyNotificationsAlert") // sets the whyNotificationsAlert userDeafault to GlobalVars
                print("whyNotificationsAlert is: \(GlobalVars.whyNotificationsAlert)")
                
                // asks user if they will allow notifications
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) {(accepted, error) in
                    if !accepted {
                        print("Notification access denied.")
                    }
                }
            }))
            
            let thumbsImage = UIImage(named: "thumbs-up")
            let imageView = UIImageView(frame: CGRect(x: 117, y: 47, width: 40, height: 40))
            imageView.image = thumbsImage
            
            alert.view.addSubview(imageView)
            
            // show the alert
            self.present(alert, animated: true, completion: nil)        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func myVCDidFinish(_ controller: OneMWWorkoutViewController, indexCount: Int, nextWorkout: String) {
        if navigationItem.title == "Upper Body + Core"{
            let image = UIImage(named: GlobalVars.exerciseUB[indexCount].filename)
            exerciseTypeImage.image = image
            exerciseTypeTitle.text = GlobalVars.exerciseUB[indexCount].name
            nextWorkoutNotificationLabel.text = nextWorkout
            
            //add switch sub-title to needed exercises
            if exerciseTypeTitle.text == "Side Plank"{
                switchSidesSubTitle.isHidden = false
                switchSidesSubTitle.text = "Switch Sides @ 30 Secs"
            }else{
                switchSidesSubTitle.isHidden = true
            }
        }
        if navigationItem.title == "Lower Body + Core"{
            let image = UIImage(named: GlobalVars.exerciseLB[indexCount].filename)
            exerciseTypeImage.image = image
            exerciseTypeTitle.text = GlobalVars.exerciseLB[indexCount].name
            nextWorkoutNotificationLabel.text = nextWorkout
            
            //add switch sub-title to needed exercises
            if exerciseTypeTitle.text == "Lunges"{
                switchSidesSubTitle.isHidden = false
                switchSidesSubTitle.text = "Alternate Sides"
            }else{
                switchSidesSubTitle.isHidden = true
            }
        }
        if navigationItem.title == "All Core"{
            let image = UIImage(named: GlobalVars.exerciseCore[indexCount].filename)
            exerciseTypeImage.image = image
            exerciseTypeTitle.text = GlobalVars.exerciseCore[indexCount].name
            nextWorkoutNotificationLabel.text = nextWorkout
            
            //add switch sub-title to needed exercises
            if exerciseTypeTitle.text == "Side Plank"{
                switchSidesSubTitle.isHidden = false
                switchSidesSubTitle.text = "Switch Sides @ 30 Secs"
            }else{
                switchSidesSubTitle.isHidden = true
            }

        }
        controller.navigationController!.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToExerciseNow"{
            
            // false = UB objects (default start)  true = LB objects
            if navigationItem.title == "Upper Body + Core"{
                // set up OneMWViewController to show Upper Body stuff
                GlobalVars.exerciseGroup = true
                
                let vc = segue.destination as! OneMWWorkoutViewController
                vc.navTitle = "Upper Body + Core"
                vc.exerciseTitle = GlobalVars.exerciseUB[GlobalVars.exerciseIndexCount].name
                vc.exerciseImage = UIImage(named: GlobalVars.exerciseUB[GlobalVars.exerciseIndexCount].filename)
                vc.nextWorkoutTime = "Right Now!"
                vc.delegate = self
            }
            if navigationItem.title == "Lower Body + Core"{
                // set up OneMWViewController to show Lower Body stuff
                GlobalVars.exerciseGroup = false
                
                let vc = segue.destination as! OneMWWorkoutViewController
                vc.navTitle = "Lower Body + Core"
                vc.exerciseTitle = GlobalVars.exerciseLB[GlobalVars.exerciseIndexCount].name
                vc.exerciseImage = UIImage(named: GlobalVars.exerciseLB[GlobalVars.exerciseIndexCount].filename)
                vc.nextWorkoutTime = "Right Now!"
                vc.delegate = self
            }
            if navigationItem.title == "All Core"{
                // set up OneMWViewController to show All Core stuff
                GlobalVars.exerciseGroup = false
                
                let vc = segue.destination as! OneMWWorkoutViewController
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
                // set up OneMWViewController to show All Core stuff
                GlobalVars.exerciseGroup = false
                
                let vc = segue.destination as! OneMWInfoViewController
                vc.exerciseTitle = GlobalVars.exerciseCore[GlobalVars.exerciseIndexCount].name
                vc.exerciseTips = GlobalVars.exerciseCore[GlobalVars.exerciseIndexCount].tips
            }
        }
    }


}
