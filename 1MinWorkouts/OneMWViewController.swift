//
//  1MWViewController.swift
//  1MinWorkouts
//
//  Created by Justin on 12/29/14.
//  Copyright (c) 2014 Good Enough LLC. All rights reserved.
//

import UIKit
import UserNotifications
import AudioToolbox


class OneMWViewController: UIViewController, OneMWWorkoutViewControllerDelegate {
    
    let whyNotificationsSettings = UserDefaults.standard // instantiates a user default holder for why notifications alert
    let shownTipsSettings = UserDefaults.standard // instantiates a user defaultholder for keeping track of the tips shown or not
    
    var exerciseTitle = ""
    var exerciseImage = UIImage(named: "")
    var navTitle = ""
    var nextWorkoutTime = ""
    var exerciseCountdownTimer = Timer()
    var totalTime = 0
    var nextWorkoutTimeSettings = UserDefaults.standard
    var waitTimer = 60
    
    @IBOutlet var exerciseTypeTitle: UILabel!
    @IBOutlet var switchSidesSubTitle: UILabel!
    @IBOutlet var exerciseTypeImage: UIImageView!
    @IBOutlet var exerciseTypeInfoBtn: UIButton!
    @IBOutlet var nextWorkoutIsLabel: UILabel!
    @IBOutlet var nextWorkoutNotificationLabel: UILabel!
    @IBOutlet var nextWorkoutView: UIVisualEffectView!
    @IBOutlet var nextWorkoutCountdownLabel: UILabel!
    @IBOutlet var workoutNowBtn: UIButton!
    @IBOutlet var workoutControls: UIView!
    @IBOutlet var TipLInkButtonView: UIView!
    @IBAction func CloseLinkTipBtn(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {self.TipLInkButtonView.alpha = 0.0})
        shownTipsSettings.set(true, forKey: "1MWLinkTip")
        
        // checks to see if End Day Tip has been shown yet
        let tipEndDayViewed = shownTipsSettings.bool(forKey: "1MWEndDayTip")
        if tipEndDayViewed == false{
            UIView.animate(withDuration: 0.5, animations: {self.TipEndDayButtonView.alpha = 1.0})
        }else{
            TipEndDayButtonView.alpha = 0.0
        }
    }
    @IBOutlet var TipEndDayButtonView: UIView!
    @IBAction func CloseEndDayTipBtn(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {self.TipEndDayButtonView.alpha = 0.0})
        shownTipsSettings.set(true, forKey: "1MWEndDayTip")
    }
    
    @IBOutlet var unlinkedBtn: UIButton!
    @IBOutlet var linkedBtn: UIButton!
    
    @IBOutlet var nextWorkoutBreakTimeSelector: UISegmentedControl!
    @IBAction func nextWorkoutBreakTimeSelector(_ sender: Any) {
        switch nextWorkoutBreakTimeSelector.selectedSegmentIndex
        {
        case 0:
            exerciseCountdownTimer.invalidate()
            nextWorkoutTimeSettings.set(30, forKey: "nextWorkoutBreakTimeSelector")
            waitTimer = nextWorkoutTimeSettings.integer(forKey: "nextWorkoutBreakTimeSelector")
            let waitTimerString = String(waitTimer)
            setExerciseTimer(waitTimer, timerLabel: "\(waitTimerString)")
            
            print("First Segment Selected and setting is \(nextWorkoutTimeSettings.integer(forKey: "nextWorkoutBreakTimeSelector"))")
        case 1:
            exerciseCountdownTimer.invalidate()
            nextWorkoutTimeSettings.set(60, forKey: "nextWorkoutBreakTimeSelector")
            waitTimer = nextWorkoutTimeSettings.integer(forKey: "nextWorkoutBreakTimeSelector")
            let waitTimerString = String(waitTimer)
            setExerciseTimer(waitTimer, timerLabel: "\(waitTimerString)")

            print("Second Segment Selected and setting is \(nextWorkoutTimeSettings.integer(forKey: "nextWorkoutBreakTimeSelector"))")
        case 2:
            exerciseCountdownTimer.invalidate()
            nextWorkoutTimeSettings.set(90, forKey: "nextWorkoutBreakTimeSelector")
            waitTimer = nextWorkoutTimeSettings.integer(forKey: "nextWorkoutBreakTimeSelector")
            let waitTimerString = String(waitTimer)
            setExerciseTimer(waitTimer, timerLabel: "\(waitTimerString)")

            print("Third Segment Selected and setting is \(nextWorkoutTimeSettings.integer(forKey: "nextWorkoutBreakTimeSelector"))")
        default:
            break
        }
    }
    @IBAction func unlinkedBtn(_ sender: Any) {
        unlinkedBtn.isHidden = true
        linkedBtn.isHidden = false
        
        // hides the tab bar control
        self.tabBarController?.tabBar.isHidden = true
        
        // moves the workout controls down
        UIView.animate(withDuration: 0.2, animations: {self.workoutControls.center.y = self.workoutControls.center.y + 50})
        
        nextWorkoutTimeSettings.set(true, forKey: "linkedWorkouts")
    }
    @IBAction func linkedBtn(_ sender: Any) {
        unlinkedBtn.isHidden = false
        linkedBtn.isHidden = true
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: {self.workoutControls.center.y = self.workoutControls.center.y - 50}) { (value:Bool) in
            // shows the tab bar control again
            self.tabBarController?.tabBar.isHidden = false
        }
        
        nextWorkoutTimeSettings.set(false, forKey: "linkedWorkouts")
    }
    @IBAction func cancelLinkedWorkoutsBtn(_ sender: Any) {
        UIView.animate(withDuration: 0.5, animations: {self.nextWorkoutView.alpha = 0.0}, completion: { (value:Bool) in
            // stops the countdown
            self.exerciseCountdownTimer.invalidate()
            self.nextWorkoutView.isHidden = true
            self.nextWorkoutView.alpha = 1.0
            
            // shows the tab bar when Next Workout Counter view is up and reset position of labels and buttons
            self.tabBarController?.tabBar.isHidden = false
        })
        self.exerciseCountdownTimer.invalidate()
        unlinkedBtn.isHidden = false
        linkedBtn.isHidden = true
        nextWorkoutTimeSettings.set(false, forKey: "linkedWorkouts")
    }
    
    @IBAction func workoutNowBtn(_ sender: AnyObject) {
    }    
    
    @IBAction func endDayBtn(_ sender: AnyObject) {
        let message:UIAlertController = UIAlertController(title: "End Day", message: "Ending the day will cancel all workout notifications for the rest of the day. \n \n" + "Are you sure you want to end the day?", preferredStyle: UIAlertControllerStyle.alert)
        message.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        message.addAction(UIAlertAction(title: "End Day", style: UIAlertActionStyle.default, handler: {(alert: UIAlertAction!) in self.endDay()}))
        
        self.present(message, animated: true, completion: nil)        
    }
    
    func endDay(){
        
        // stops any countdowns
        exerciseCountdownTimer.invalidate()
        
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

    override func viewWillAppear(_ animated: Bool) {
        TipLInkButtonView.alpha = 0.0
        // checks to see if Linked Tip has been shown yet
        let tipLinkedViewed = shownTipsSettings.bool(forKey: "1MWLinkTip")
        if tipLinkedViewed == false{
            UIView.animate(withDuration: 1.0, animations: {self.TipLInkButtonView.alpha = 1.0})
        }else{
            TipLInkButtonView.alpha = 0.0
        }
        
        // hides the End Day tip at first
        TipEndDayButtonView.alpha = 0.0
        
        
        if nextWorkoutNotificationLabel.text != "Right Now!"{
            //disables 1MW tab
            if  let arrayOfTabBarItems = tabBarController?.tabBar.items as AnyObject as? NSArray,let tabBarItem = arrayOfTabBarItems[0] as? UITabBarItem {
                tabBarItem.isEnabled = false
            }
            
            //hides the Back button when doing 1MW's
            navigationItem.hidesBackButton = true
        }
        
        if (nextWorkoutTimeSettings.object(forKey: "nextWorkoutBreakTimeSelector") != nil){
            waitTimer = nextWorkoutTimeSettings.object(forKey: "nextWorkoutBreakTimeSelector") as! Int
            nextWorkoutCountdownLabel.text = "\(waitTimer)"
        }else{
            print("viewWillAppear not set")
        }
        
        // adds 3D touch stuff to the app icon
        let shortcut = UIApplicationShortcutItem(type: "", localizedTitle: "Next workout:", localizedSubtitle: "\(exerciseTypeTitle.text!) @ \(nextWorkoutNotificationLabel.text!)", icon: nil, userInfo: nil)
        
        UIApplication.shared.shortcutItems = [shortcut]
        
        // defines when to show the next exercise wait timer after the first workout has been done
        if unlinkedBtn.isHidden == true && linkedBtn.isHidden == false && nextWorkoutView.isHidden == false{
            let currentTimerCount = nextWorkoutCountdownLabel
            let currentTimerCountInt:Int? = Int((currentTimerCount?.text)!)
            setExerciseTimer(currentTimerCountInt!, timerLabel: "\(String(describing: currentTimerCount))")
            print("------------ viewWillAppear reset time")
        }else if unlinkedBtn.isHidden == true && linkedBtn.isHidden == false{
            
            nextWorkoutView.isHidden = false
            
            // hides the tab bar when Next Workout Counter view is up
            self.tabBarController?.tabBar.isHidden = true
            
            UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
                self.nextWorkoutView.center.y = self.nextWorkoutView.center.y - 190 //-198
                print("------------ viewWillAppear animate")
            }) { (value:Bool) in
                // stops the countdown
                self.exerciseCountdownTimer.invalidate()
                // sets the linked workout default wait timer
                let waitTimerString = String(self.waitTimer)
                self.setExerciseTimer(self.waitTimer, timerLabel: "\(waitTimerString)")
            }
        }else{
            // hides the next workout view
            nextWorkoutView.isHidden = true
            
            print("------------ viewWillAppear hide view")
        }
    }
    
    //----------------------------------------- next exercise wait timer -----------------------------------------//
    func exerciseTimerGetReady(){
        GlobalVars.nextExerciseSecondsCount -= 1 // decreases the count down by 1
//        let minutes = (GlobalVars.nextExerciseSecondsCount / 60) // converts the seconds into minute format
//        let seconds = (GlobalVars.nextExerciseSecondsCount - (minutes * 60)) // converts the seconds back to seconds
        let seconds = (GlobalVars.nextExerciseSecondsCount) // converts the seconds back to seconds
        let timerOutput = String(format:"%.d", seconds) // defines the output that is placed on the label
        nextWorkoutCountdownLabel.text = timerOutput
        
        // what happens when the timer ends
        if (GlobalVars.nextExerciseSecondsCount == 5) {
            
            exerciseCountdownTimer.invalidate() // stops the countdown
            
            //setExerciseTimer(0, timerLabel: "0")
            
            nextWorkoutView.isHidden = true
            
            AudioServicesPlaySystemSound(1120) // plays vibrate and tone
            
            // segues to the next workout
            performSegue(withIdentifier: "segueToExerciseNow", sender: self)
            
        }
    }
    
    // method that defines the timer for next workout timer
    func setExerciseTimer(_ timerTime : Int, timerLabel : String){
        
        totalTime = timerTime // sets the timer to starting time desired
        
        nextWorkoutCountdownLabel.text = timerLabel // sets timer label to starting time desired
        
        GlobalVars.nextExerciseSecondsCount = totalTime; // sets timer to an hour
        exerciseCountdownTimer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: #selector(ExercisesViewController.exerciseTimerGetReady), userInfo: nil, repeats: true) // sets the timer interval to 1.0 seconds and uses the timerRun method as the countdown
    }
    
//    override func viewDidLayoutSubviews() {
//        // checks to make sure the next workout counter view is only shown when needed
//        if unlinkedBtn.isHidden == true && linkedBtn.isHidden == false{
//            nextWorkoutView.center.y = nextWorkoutView.center.y - 198
//        }else {
//            nextWorkoutView.center.y = nextWorkoutView.center.y
//        }
//        
//        // makes sure the next workout countdown value is set prior to showing it
//        self.nextWorkoutCountdownLabel.text = "30"
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // sets the linked workouts settings to off by default
        nextWorkoutTimeSettings.set(false, forKey: "linkedWorkouts")
        
        //checks to see which chained workout wait time is set
        if (nextWorkoutTimeSettings.object(forKey: "nextWorkoutBreakTimeSelector") != nil) {
            if nextWorkoutTimeSettings.integer(forKey: "nextWorkoutBreakTimeSelector") == 30{                nextWorkoutBreakTimeSelector.selectedSegmentIndex = 0
                waitTimer = 30
                
                print("First Segment set to \(nextWorkoutTimeSettings.integer(forKey: "nextWorkoutBreakTimeSelector"))")
            }else if nextWorkoutTimeSettings.integer(forKey: "nextWorkoutBreakTimeSelector") == 60{                nextWorkoutBreakTimeSelector.selectedSegmentIndex = 1
                waitTimer = 60
                
                print("Second Segment set to \(nextWorkoutTimeSettings.integer(forKey: "nextWorkoutBreakTimeSelector"))")
            }else if nextWorkoutTimeSettings.integer(forKey: "nextWorkoutBreakTimeSelector") == 90{                nextWorkoutBreakTimeSelector.selectedSegmentIndex = 2
                waitTimer = 90
                
                print("Third Segment set to \(nextWorkoutTimeSettings.integer(forKey: "nextWorkoutBreakTimeSelector"))")
            }else{
                //Nothing stored in NSUserDefaults yet. Set a value.
                nextWorkoutTimeSettings.set(60, forKey: "nextWorkoutBreakTimeSelector")
                waitTimer = nextWorkoutTimeSettings.integer(forKey: "nextWorkoutBreakTimeSelector")
                waitTimer = 60
                
                print("***** no settings")
            }
        }
        
        // defined the border color of the Unlinked button
        unlinkedBtn.layer.borderWidth = 1
        unlinkedBtn.layer.borderColor = UIColor(red:0.43, green:0.70, blue:0.85, alpha:1.00).cgColor
        
        // hides the linked button to start
        linkedBtn.isHidden = true
        
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
