//
//  OneMWStartViewController.swift
//  1MinWorkouts
//
//  Created by Justin on 12/31/14.
//  Copyright (c) 2014 Good Enough LLC. All rights reserved.
//

import UIKit
import UserNotifications

class OneMWStartViewController: UIViewController {
    
    let lastWorkoutLabelSettings = UserDefaults.standard // instantiates a user default holder for the next workout labels
    
    @IBOutlet var UBBtnLastWorkoutLabel: UILabel!
    @IBOutlet var LBBtnLastWorkoutLabel: UILabel!
    @IBOutlet var CoreBtnLastWorkoutLabel: UILabel!
    @IBAction func endDayBtn(_ sender: Any) {
        let message:UIAlertController = UIAlertController(title: "End Day", message: "Ending the day will cancel all workout notifications for the rest of the day. \n \n" + "Are you sure you want to end the day?", preferredStyle: UIAlertControllerStyle.alert)
        message.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        message.addAction(UIAlertAction(title: "End Day", style: UIAlertActionStyle.default, handler: {(alert: UIAlertAction!) in self.endDay()}))
        
        self.present(message, animated: true, completion: nil)
        print("you hit end day btn")
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
    }
  
    
    // function that sets todays current date to the selected muscle group
    func getTodaysDate(){
        let todaysDate = Date()
        
        let todaysDateFormatter = DateFormatter()
        todaysDateFormatter.dateStyle = .medium
        //todaysDateFormatter.timeStyle = .ShortStyle
        
        let todaysDateString = todaysDateFormatter.string(from: todaysDate)
//        print("Last Workout: \(GlobalVars.lastWorkoutDate)")
        print("todays date \(todaysDateString)")
        
        UBBtnLastWorkoutLabel.text = "Last Workout: \(todaysDateString)"
        LBBtnLastWorkoutLabel.text = "Last Workout: \(todaysDateString)"
        CoreBtnLastWorkoutLabel.text = "Last Workout: \(todaysDateString)"
        GlobalVars.lastWorkoutDate = todaysDateString
        lastWorkoutLabelSettings.set("Last Workout: \(todaysDateString)", forKey: "lastWorkoutDate") // sets the userDefaults to lastWorkoutDate
        print("Last Workout Date getTodaysDate: \(GlobalVars.lastWorkoutDate)")
        
    }
    
    @IBAction func upperBodyBtn(_ sender: AnyObject) {
        GlobalVars.exerciseGroup = false
        
        // get todays date and set it to the Last Workout label and show/hide correct labels
        getTodaysDate()
        
        lastWorkoutLabelSettings.set(false, forKey: "UBlabel")
        lastWorkoutLabelSettings.set(true, forKey: "LBlabel")
        lastWorkoutLabelSettings.set(true, forKey: "AClabel")
        
        // stores userDefault label settings in GlobalVars
        GlobalVars.UBLabel = lastWorkoutLabelSettings.bool(forKey: "UBlabel")
        GlobalVars.LBLabel = lastWorkoutLabelSettings.bool(forKey: "LBlabel")
        GlobalVars.ACLabel = lastWorkoutLabelSettings.bool(forKey: "AClabel")
        
        // hides all last workout date labels on start up based on userDefault settings
        UBBtnLastWorkoutLabel.isHidden = GlobalVars.UBLabel
        LBBtnLastWorkoutLabel.isHidden = GlobalVars.LBLabel
        CoreBtnLastWorkoutLabel.isHidden = GlobalVars.ACLabel
        
        print("UBLabel is: \(GlobalVars.UBLabel)")

    }
    
    @IBAction func lowerBodyBtn(_ sender: AnyObject) {
        GlobalVars.exerciseGroup = true
        
        // get todays date and set it to the Last Workout label and show/hide correct labels
        getTodaysDate()
        
        lastWorkoutLabelSettings.set(true, forKey: "UBlabel")
        lastWorkoutLabelSettings.set(false, forKey: "LBlabel")
        lastWorkoutLabelSettings.set(true, forKey: "AClabel")
        
        // stores userDefault label settings in GlobalVars
        GlobalVars.UBLabel = lastWorkoutLabelSettings.bool(forKey: "UBlabel")
        GlobalVars.LBLabel = lastWorkoutLabelSettings.bool(forKey: "LBlabel")
        GlobalVars.ACLabel = lastWorkoutLabelSettings.bool(forKey: "AClabel")
        
        // hides all last workout date labels on start up based on userDefault settings
        UBBtnLastWorkoutLabel.isHidden = GlobalVars.UBLabel
        LBBtnLastWorkoutLabel.isHidden = GlobalVars.LBLabel
        CoreBtnLastWorkoutLabel.isHidden = GlobalVars.ACLabel
        
        print("LBLabel is: \(GlobalVars.LBLabel)")

    }
    
    @IBAction func allCoreBtn(_ sender: AnyObject) {
        GlobalVars.exerciseGroup = true
        
        // get todays date and set it to the Last Workout label and show/hide correct labels
        getTodaysDate()
        
        lastWorkoutLabelSettings.set(true, forKey: "UBlabel")
        lastWorkoutLabelSettings.set(true, forKey: "LBlabel")
        lastWorkoutLabelSettings.set(false, forKey: "AClabel")
        
        // stores userDefault label settings in GlobalVars
        GlobalVars.UBLabel = lastWorkoutLabelSettings.bool(forKey: "UBlabel")
        GlobalVars.LBLabel = lastWorkoutLabelSettings.bool(forKey: "LBlabel")
        GlobalVars.ACLabel = lastWorkoutLabelSettings.bool(forKey: "AClabel")
        
        // hides all last workout date labels on start up based on userDefault settings
        UBBtnLastWorkoutLabel.isHidden = GlobalVars.UBLabel
        LBBtnLastWorkoutLabel.isHidden = GlobalVars.LBLabel
        CoreBtnLastWorkoutLabel.isHidden = GlobalVars.ACLabel
        
        print("AClabel is: \(GlobalVars.ACLabel)")

    }
    
    // instantiates the walkthrough XIB
    let vc = TutorialXIBViewController(nibName: "TutorialXIBViewController", bundle: nil)
    
    override func viewWillAppear(_ animated: Bool) {
        setNotifVars() // sets the notification default settings to the appropriate GlobalVars
        
        // checks to see if the user has seen the OOBE Tute/Disclaimer/Setup
        let appUserSettings = UserDefaults.standard // instantiates a user default holder
        
        if let oobeShown = appUserSettings.string(forKey: GlobalVars.oobeTute){
            // if there IS a value set this will happen
        }else{
            // there is NO value set so this will happen
            vc.modalTransitionStyle = UIModalTransitionStyle.coverVertical  // show disclaimer XIB which leads to walkthrough and initial setup
            present(vc, animated: true, completion: nil)
            
        }
        
//        if UBBtnLastWorkoutLabel.isHidden == false{
//            let shortcut = UIApplicationShortcutItem(type: "", localizedTitle: "Next workout: Lower Body + Core")
//            UIApplication.shared.shortcutItems = [shortcut]
//            print("1mw start viewWillAppear UB on")
//        }else if LBBtnLastWorkoutLabel.isHidden == false{
//            let shortcut = UIApplicationShortcutItem(type: "", localizedTitle: "Next workout:\nAll Core")
//            UIApplication.shared.shortcutItems = [shortcut]
//            print("1mw start viewWillAppear LB on")
//        }else if CoreBtnLastWorkoutLabel.isHidden == false{
//            let shortcut = UIApplicationShortcutItem(type: "", localizedTitle: "Next workout: Upper Body + Core")
//            UIApplication.shared.shortcutItems = [shortcut]
//            print("1mw start viewWillAppear core on")
//        }else {
//            let shortcut = UIApplicationShortcutItem(type: "", localizedTitle: "Sart With: Upper Body + Core")
//            UIApplication.shared.shortcutItems = [shortcut]
//            print("1mw start viewWillAppear all off")
//        }
        let shortcut = UIApplicationShortcutItem(type: "", localizedTitle: "Select a workout")
        UIApplication.shared.shortcutItems = [shortcut]
        print("1mw start viewWillAppear")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // stores userDefault label settings in GlobalVars
        GlobalVars.UBLabel = lastWorkoutLabelSettings.bool(forKey: "UBlabel")
        GlobalVars.LBLabel = lastWorkoutLabelSettings.bool(forKey: "LBlabel")
        GlobalVars.ACLabel = lastWorkoutLabelSettings.bool(forKey: "AClabel")
        GlobalVars.lastWorkoutDate = lastWorkoutLabelSettings.string(forKey: "lastWorkoutDate")!
        
        // hides all last workout date labels on start up based on userDefault settings
        UBBtnLastWorkoutLabel.isHidden = GlobalVars.UBLabel
        LBBtnLastWorkoutLabel.isHidden = GlobalVars.LBLabel
        CoreBtnLastWorkoutLabel.isHidden = GlobalVars.ACLabel
        UBBtnLastWorkoutLabel.text = GlobalVars.lastWorkoutDate
        LBBtnLastWorkoutLabel.text = GlobalVars.lastWorkoutDate
        CoreBtnLastWorkoutLabel.text = GlobalVars.lastWorkoutDate
        //print("UBLabel is: \(GlobalVars.UBLabel)")
        //print("Last Workout Date: \(GlobalVars.lastWorkoutDate)")
        
        GlobalVars.exerciseIndexCount = 0
        
        // instantiates the Upper Body array data        
        var newExercise = Exercise(name: "Push-Ups", filename: "push-ups", meterFilename: "", tips:
            "1. Lie on the floor face down and place your hands just about about shoulder width apart while holding your torso up at arms length. \n\n" +
            "2. Lower yourself down until your chest almost touches the floor as you inhale.\n\n" +
            "3. Press your upper body back up to the starting position, focussing on squeezing your chest while exhaling.\n\n" +
            "Do as many as you can in a minute, but take breaks as needed.") // 0
        GlobalVars.exerciseUB.append(newExercise)
        
        newExercise = Exercise(name: "Crunches", filename: "sit-ups", meterFilename: "", tips:
            "1. Lie down with your back flat to the floor. \n\n" +
                "2. Bend your knees at a 90-degree angle to your body. It may be easier to rest your feet under a chair to lock them in place. \n\n" +
                "3. Cross your hands in front of your chest. Make sure there is a fist's worth of space between your chin and chest. \n\n" +
                "4. Draw your belly button in to the base of your spine while you sit up. Your shoulder blades should just lift off the floor. \n\n" +
                "Exhale as you sit up. Inhale as you lie down. \n\n" +
                "Do as many as you can in a minute, but take breaks as needed. \n\n" +
            "") // 1 - seems to be a bug in rendering this note that gets fixed if I have this empty line at the end.
        GlobalVars.exerciseUB.append(newExercise)
        
        newExercise = Exercise(name: "Curls", filename: "curls", meterFilename: "", tips:
            "1. Choose a resistance band that allows you to do at least 15 repetitions in one set. \n\n" +
                "2. Stand up straight with your feet hip width apart. \n\n" +
                "3. Place the band under your feet and hold the handles down by your sides. Make sure each side is even. \n\n" +
                "4. Curl your arms up toward your shoulders. Exhale and make sure to keep your elbows tucked in at your sides - don't arch your back. \n\n" +
                "5. Return to the starting position in a slow and controlled manner while you inhale. \n\n" +
            "Do as many as you can in a minute, but take breaks as needed.\n\n") // 2
        GlobalVars.exerciseUB.append(newExercise)
        
        newExercise = Exercise(name: "Tricep Dips", filename: "dips", meterFilename: "", tips:
            "1. Position your hands shoulder-width apart on a secured table/desk or stable chair. \n\n" +
            "2. Slide your butt off the front of the chair with your legs extended out in front of you. \n\n" +
            "3. Straighten your arms, keeping a little bend in your elbows to keep tension on your triceps and off your elbow joints. \n\n" +
            "4. Slowly bend your elbows to lower your body toward the floor until your elbows are at about a 90-degree angle. Be sure to keep your back close to the chairs seat. \n\n" +
            "5. Once you reach the bottom of the movement, press down into the chair to straighten your elbows, returning to the starting position. This completes one rep. \n\n" +
            "6. Keep your shoulders down as you lower and raise your body. You can bend your legs to modify this exercise. \n\n" +
            "Do as many as you can, takeing breaks as needed.") // 3
        GlobalVars.exerciseUB.append(newExercise)
    

        // 2nd set
        newExercise = Exercise(name: "Wide Push-Ups", filename: "push-ups-wide", meterFilename: "", tips:
            "1. Lie on the floor face down and place your hands about a shoulder and half width apart (your elbows should be at 90 degree angles and parallel with the floor when in the down position) while holding your torso up at arms length. \n\n" +
            "2. Lower yourself down until your chest almost touches the floor as you inhale.\n\n" +
            "3. Press your upper body back up to the starting position, focussing on squeezing your chest while exhaling.\n\n" +
            "Do as many as you can in a minute, but take breaks as needed.") // 4
        GlobalVars.exerciseUB.append(newExercise)
        
        newExercise = Exercise(name: "Side Plank", filename: "side-plank-right", meterFilename: "", tips:
            "1. Lie on your side with your legs straight and your body in a straight line (shoulders and hips stacked one on top of the other; don’t lean forward or backwards).\n\n" +
            "2. Prop your body up so your hips are off the floor. Rest your weight on the elbow that’s touching the floor.\n\n" +
            "3. Only your forearm and feet should touch the floor.\n\n" +
            "4. Do not let your hips sag (this is the challenging part of this move). As you get tired, you’ll want to drop your hips, but focus on keeping them stationary. \n\n" +
            "Hold for 30 seconds then switch sides for the remainder of the minute, but take breaks as needed.") //5
        GlobalVars.exerciseUB.append(newExercise)
        
        newExercise = Exercise(name: "Curls", filename: "curls", meterFilename: "", tips:
            "1. Choose a resistance band that allows you to do at least 15 repetitions in one set. \n\n" +
                "2. Stand up straight with your feet hip width apart. \n\n" +
                "3. Place the band under your feet and hold the handles down by your sides. Make sure each side is even. \n\n" +
                "4. Curl your arms up toward your shoulders. Exhale and make sure to keep your elbows tucked in at your sides - don't arch your back. \n\n" +
                "5. Return to the starting position in a slow and controlled manner while you inhale. \n\n" +
            "Do as many as you can in a minute, but take breaks as needed.\n\n") // 6
        GlobalVars.exerciseUB.append(newExercise)
        
        
        newExercise = Exercise(name: "Tricep Dips", filename: "dips", meterFilename: "", tips:
            "1. Position your hands shoulder-width apart on a secured table/desk or stable chair. \n\n" +
            "2. Slide your butt off the front of the chair with your legs extended out in front of you. \n\n" +
            "3. Straighten your arms, keeping a little bend in your elbows to keep tension on your triceps and off your elbow joints. \n\n" +
            "4. Slowly bend your elbows to lower your body toward the floor until your elbows are at about a 90-degree angle. Be sure to keep your back close to the chairs seat. \n\n" +
            "5. Once you reach the bottom of the movement, press down into the chair to straighten your elbows, returning to the starting position. This completes one rep. \n\n" +
            "6. Keep your shoulders down as you lower and raise your body. You can bend your legs to modify this exercise. \n\n" +
            "Do as many as you can, takeing breaks as needed.")  // 7
        GlobalVars.exerciseUB.append(newExercise)
        
        // instantiates the Lower Body array data
        newExercise = Exercise(name: "Squats", filename: "squats", meterFilename: "", tips:
            "1. Stand with your spine in a straight line, and have your feet a little wider than hip-width apart. \n\n" +
            "2. Bend at the knees to lower your hips toward the ground and move them backwards, as though you're going to sit in a chair. Your shins should be perpendicular to the floor and your spine should stay straight. Keep your arms out in front of you for balance as needed while you inhale. \n\n" +
            "3. Straighten your legs back to the starting position while you exhale \n\n" +
            "If you can't do a full squat by bringing your hips close to the floor, do a half squat or squat down as far as you can until you improve and can go lower. \n\n" +
            "Do as many as you can in a minute, takeing breaks as needed.") // 0
        GlobalVars.exerciseLB.append(newExercise)
        
        newExercise = Exercise(name: "Plank", filename: "plank", meterFilename: "", tips:
            "1. Lie on your stomach, flat on the floor. Push up onto your forearms.\n\n" +
                "2. Bend your elbows and rest your weight on your forearms.\n\n" +
                "3. Keep your elbows under your shoulders.\n\n" +
                "4. Pull your belly button towards your spine.\n\n" +
                "5. Your body should form a flat line. Don’t let your hips sag, and don’t push your butt up—keep your body in a straight line.\n\n" +
                "6. You can do this plank on your hands instead of your elbows if you prefer (if you feel any pain or stiffness in your wrists, balance your weight on your elbows instead).\n\n" +
            "Hold this position for as long as you can, but take breaks as needed.") // 1
        GlobalVars.exerciseLB.append(newExercise)
        
        newExercise = Exercise(name: "Lunges", filename: "lunges", meterFilename: "", tips:
            "1. Stand up straight with your feet about a shoulder width apart. Put your hands on your hips, keep your back as straight as possible, relax your shoulders and keep your eyes facing directly ahead. \n\n" +
            "2. Take a large step forward with one leg. The length of your step will depend on your height, but it will usually be somewhere between 2 or 3 feet (0.6 or 0.9 m). \n\n" +
            "3. As you step forward, lower your hips and bend your knees until they both form 90 degree angles while inhaling. Your front knee should not extend over your toes and your back knee should not touch the ground. \n\n" +
            "4. Pause at the bottom of the lunge for a second then push off the heel of your front foot to return to the starting position while exhaling. \n\n" +
            "Alternate legs as you go. \n\n" +
            "Do as many as you can in a minute, but take breaks as needed.") // 2
        GlobalVars.exerciseLB.append(newExercise)
        
        newExercise = Exercise(name: "Calf Raises", filename: "calf-raises", meterFilename: "", tips:
            "1. Stand with your feet shoulder width apart. You can hold the back of a chair for balance if needed. \n\n" +
            "2. Lift your heels until you're standing on your tip toes while exhaling. Distribute most of your weight onto the balls of your feet, and keep your legs straight. \n\n" +
            "3. Stay on your tip toes for two seconds. Then, begin to lower your heels, and move your weight away from the balls of your feet until your heels are back on the ground while inhaling. \n\n" +
            "Do as many as you can in a minute, but take breaks as needed.") // 3
        GlobalVars.exerciseLB.append(newExercise)
        
        // 2nd set
        newExercise = Exercise(name: "Squats", filename: "squats", meterFilename: "", tips:
            "1. Stand with your spine in a straight line, and have your feet a little wider than hip-width apart. \n\n" +
            "2. Bend at the knees to lower your hips toward the ground and move them backwards, as though you're going to sit in a chair. Your shins should be perpendicular to the floor and your spine should stay straight. Keep your arms out in front of you for balance as needed while you inhale. \n\n" +
            "3. Straighten your legs back to the starting position while you exhale \n\n" +
            "If you can't do a full squat by bringing your hips close to the floor, do a half squat or squat down as far as you can until you improve and can go lower. \n\n" +
            "Do as many as you can in a minute, takeing breaks as needed.") // 4
        GlobalVars.exerciseLB.append(newExercise)
        
        newExercise = Exercise(name: "Leg Lifts", filename: "lower-abs", meterFilename: "", tips:
            "1. Lie flat on your back with your legs stretched out in front of you. Your legs should just be a toe's width apart. Make sure to keep your hands down flat on the ground near your sides, with your palms down. \n\n" +
            "2. Bend your knees and raise your legs. Your calves should be parallel to the ground, while your thighs are perpendicular. You should keep your toes pointed while you do this, drawing your abdominal muscles toward your spine. \n\n" +
            "3. Continue curling your knees towards your chest. Raise your legs as slowly as possible while exhaling. \n\n" +
            "4. Slowly lower your legs. Bring them down to about an inch off the floor. Don't just let gravity work for you, make sure you're in control. Hold your arms in the same place, but use them for balance and support as you lower your legs. \n\n" +
            "Do as many as you can in a minute, but take breaks as needed.") //5
        GlobalVars.exerciseLB.append(newExercise)
        
        newExercise = Exercise(name: "Lunges", filename: "lunges", meterFilename: "", tips:
            "1. Stand up straight with your feet about a shoulder width apart. Put your hands on your hips, keep your back as straight as possible, relax your shoulders and keep your eyes facing directly ahead. \n\n" +
            "2. Take a large step forward with one leg. The length of your step will depend on your height, but it will usually be somewhere between 2 or 3 feet (0.6 or 0.9 m). \n\n" +
            "3. As you step forward, lower your hips and bend your knees until they both form 90 degree angles while inhaling. Your front knee should not extend over your toes and your back knee should not touch the ground. \n\n" +
            "4. Pause at the bottom of the lunge for a second then push off the heel of your front foot to return to the starting position while exhaling. \n\n" +
            "Alternate legs as you go. \n\n" +
            "Do as many as you can in a minute, but take breaks as needed.") // 6
        GlobalVars.exerciseLB.append(newExercise)
        
        newExercise = Exercise(name: "Calf Raises", filename: "calf-raises", meterFilename: "", tips:
            "1. Stand with your feet shoulder width apart. You can hold the back of a chair for balance if needed. \n\n" +
            "2. Lift your heels until you're standing on your tip toes while exhaling. Distribute most of your weight onto the balls of your feet, and keep your legs straight. \n\n" +
            "3. Stay on your tip toes for two seconds. Then, begin to lower your heels, and move your weight away from the balls of your feet until your heels are back on the ground while inhaling. \n\n" +
            "Do as many as you can in a minute, but take breaks as needed.") // 7
        GlobalVars.exerciseLB.append(newExercise)
        
        // instantiates the Core array data
        newExercise = Exercise(name: "Plank", filename: "plank", meterFilename: "", tips:
            "1. Lie on your stomach, flat on the floor. Push up onto your forearms.\n\n" +
            "2. Bend your elbows and rest your weight on your forearms.\n\n" +
            "3. Keep your elbows under your shoulders.\n\n" +
            "4. Pull your belly button towards your spine.\n\n" +
            "5. Your body should form a flat line. Don’t let your hips sag, and don’t push your butt up—keep your body in a straight line.\n\n" +
            "6. You can do this plank on your hands instead of your elbows if you prefer (if you feel any pain or stiffness in your wrists, balance your weight on your elbows instead).\n\n" +
            "Hold this position for as long as you can, but take breaks as needed.") // 0
        GlobalVars.exerciseCore.append(newExercise)
        
        newExercise = Exercise(name: "Side Plank", filename: "side-plank-right", meterFilename: "", tips:
            "1. Lie on your side with your legs straight and your body in a straight line (shoulders and hips stacked one on top of the other; don’t lean forward or backwards).\n\n" +
            "2. Prop your body up so your hips are off the floor. Rest your weight on the elbow that’s touching the floor.\n\n" +
            "3. Only your forearm and feet should touch the floor.\n\n" +
            "4. Do not let your hips sag (this is the challenging part of this move). As you get tired, you’ll want to drop your hips, but focus on keeping them stationary. \n\n" +
            "Hold for 30 seconds then switch sides for the remainder of the minute, but take breaks as needed.") //1
        GlobalVars.exerciseCore.append(newExercise)
        
        newExercise = Exercise(name: "Crunches", filename: "sit-ups", meterFilename: "", tips:
            "1. Lie down with your back flat to the floor.\n\n" +
                "2. Bend your knees at a 90-degree angle to your body. It may be easier to rest your feet under a chair to lock them in place.\n\n" +
                "3. Cross your hands in front of your chest. Make sure there is a fist's worth of space between your chin and chest.\n\n" +
                "4. Draw your belly button in to the base of your spine while you sit up. Your shoulder blades should just lift off the floor.\n\n" +
                "Exhale as you sit up. Inhale as you lie down.\n\n" +
                "Do as many as you can in a minute, but take breaks as needed.\n\n") // 2
        GlobalVars.exerciseCore.append(newExercise)
        
        newExercise = Exercise(name: "Leg Lifts", filename: "lower-abs", meterFilename: "", tips:
            "1. Lie flat on your back with your legs stretched out in front of you. Your legs should just be a toe's width apart. Make sure to keep your hands down flat on the ground near your sides, with your palms down. \n\n" +
            "2. Bend your knees and raise your legs. Your calves should be parallel to the ground, while your thighs are perpendicular. You should keep your toes pointed while you do this, drawing your abdominal muscles toward your spine. \n\n" +
            "3. Continue curling your knees towards your chest. Raise your legs as slowly as possible while exhaling. \n\n" +
            "4. Slowly lower your legs. Bring them down to about an inch off the floor. Don't just let gravity work for you, make sure you're in control. Hold your arms in the same place, but use them for balance and support as you lower your legs. \n\n" +
            "Do as many as you can in a minute, but take breaks as needed.") //3
        GlobalVars.exerciseCore.append(newExercise)
        
        newExercise = Exercise(name: "Plank", filename: "plank", meterFilename: "", tips:
            "1. Lie on your stomach, flat on the floor. Push up onto your forearms.\n\n" +
            "2. Bend your elbows and rest your weight on your forearms.\n\n" +
            "3. Keep your elbows under your shoulders.\n\n" +
            "4. Pull your belly button towards your spine.\n\n" +
            "5. Your body should form a flat line. Don’t let your hips sag, and don’t push your butt up—keep your body in a straight line.\n\n" +
            "6. You can do this plank on your hands instead of your elbows if you prefer (if you feel any pain or stiffness in your wrists, balance your weight on your elbows instead).\n\n" +
            "Hold this position for as long as you can, but take breaks as needed.") // 4
        GlobalVars.exerciseCore.append(newExercise)
        
        newExercise = Exercise(name: "Side Plank", filename: "side-plank-right", meterFilename: "", tips:
            "1. Lie on your side with your legs straight and your body in a straight line (shoulders and hips stacked one on top of the other; don’t lean forward or backwards).\n\n" +
            "2. Prop your body up so your hips are off the floor. Rest your weight on the elbow that’s touching the floor.\n\n" +
            "3. Only your forearm and feet should touch the floor.\n\n" +
            "4. Do not let your hips sag (this is the challenging part of this move). As you get tired, you’ll want to drop your hips, but focus on keeping them stationary. \n\n" +
            "Hold for 30 seconds then switch sides for the remainder of the minute, but take breaks as needed.") // 5
        GlobalVars.exerciseCore.append(newExercise)
        
        newExercise = Exercise(name: "Crunches", filename: "sit-ups", meterFilename: "", tips:
            "1. Lie down with your back flat to the floor.\n\n" +
                "2. Bend your knees at a 90-degree angle to your body. It may be easier to rest your feet under a chair to lock them in place.\n\n" +
                "3. Cross your hands in front of your chest. Make sure there is a fist's worth of space between your chin and chest.\n\n" +
                "4. Draw your belly button in to the base of your spine while you sit up. Your shoulder blades should just lift off the floor.\n\n" +
                "Exhale as you sit up. Inhale as you lie down.\n\n" +
            "Do as many as you can in a minute, but take breaks as needed.\n\n") // 6
        GlobalVars.exerciseCore.append(newExercise)
        
        newExercise = Exercise(name: "Leg Lifts", filename: "lower-abs", meterFilename: "", tips:
            "1. Lie flat on your back with your legs stretched out in front of you. Your legs should just be a toe's width apart. Make sure to keep your hands down flat on the ground near your sides, with your palms down. \n\n" +
            "2. Bend your knees and raise your legs. Your calves should be parallel to the ground, while your thighs are perpendicular. You should keep your toes pointed while you do this, drawing your abdominal muscles toward your spine. \n\n" +
            "3. Continue curling your knees towards your chest. Raise your legs as slowly as possible while exhaling. \n\n" +
            "4. Slowly lower your legs. Bring them down to about an inch off the floor. Don't just let gravity work for you, make sure you're in control. Hold your arms in the same place, but use them for balance and support as you lower your legs. \n\n" +
            "Do as many as you can in a minute, but take breaks as needed.") // 7
        GlobalVars.exerciseCore.append(newExercise)
        
    }
    
    override func encodeRestorableState(with coder: NSCoder) {
        
        
        //super.encodeRestorableState(with: coder)
    }
    
    override func decodeRestorableState(with coder: NSCoder) {

        
        //super.decodeRestorableStateWithCoder(coder)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueToUBExerciseType"{
            let vc = segue.destination as! OneMWViewController
            vc.navTitle = "Upper Body + Core"
            vc.exerciseTitle = GlobalVars.exerciseUB[GlobalVars.exerciseIndexCount].name
            vc.exerciseImage = UIImage(named: GlobalVars.exerciseUB[GlobalVars.exerciseIndexCount].filename)
        }
        if segue.identifier == "segueToLBExerciseType"{
            let vc = segue.destination as! OneMWViewController
            vc.navTitle = "Lower Body + Core"
            vc.exerciseTitle = GlobalVars.exerciseLB[GlobalVars.exerciseIndexCount].name
            vc.exerciseImage = UIImage(named: GlobalVars.exerciseLB[GlobalVars.exerciseIndexCount].filename)
        }
        if segue.identifier == "segueToCoreExerciseType"{
            let vc = segue.destination as! OneMWViewController
            vc.navTitle = "All Core"
            vc.exerciseTitle = GlobalVars.exerciseCore[GlobalVars.exerciseIndexCount].name
            vc.exerciseImage = UIImage(named: GlobalVars.exerciseCore[GlobalVars.exerciseIndexCount].filename)
        }
    }

}
