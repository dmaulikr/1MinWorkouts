//
//  OneMWStartViewController.swift
//  1MinWorkouts
//
//  Created by Justin on 12/31/14.
//  Copyright (c) 2014 Good Enough LLC. All rights reserved.
//

import UIKit

class OneMWStartViewController: UIViewController {
    
    @IBAction func upperBodyBtn(sender: AnyObject) {
        GlobalVars.exerciseGroup = false
        
        // sets workout notifications for the day
        if GlobalVars.workoutNotificationStartMin >= 30{
            // clears out all set notifications, just in case
            UIApplication.sharedApplication().cancelAllLocalNotifications()
            
            workoutNotification(GlobalVars.workoutNotificationStartHour + 1, fMin: 50, fCategory: GlobalVars.workoutNotificationCategory ,fAlertBody: "It's time for a 1 Minute Workout!", fRepeat: NSCalendarUnit.CalendarUnitHour)
            println("notification set for upper body >= 30")
        }else {
            // clears out all set notifications, just in case
            UIApplication.sharedApplication().cancelAllLocalNotifications()
            
            workoutNotification(GlobalVars.workoutNotificationStartHour, fMin: 50, fCategory: GlobalVars.workoutNotificationCategory, fAlertBody: "It's time for a 1 Minute Workout!", fRepeat: NSCalendarUnit.CalendarUnitHour)
            println("notification set for upper body < 30")
        }
    }
    
    @IBAction func lowerBodyBtn(sender: AnyObject) {
        GlobalVars.exerciseGroup = true
        
        // sets workout notifications
        if GlobalVars.workoutNotificationStartMin >= 30{
            // clears out all set notifications, just in case
            UIApplication.sharedApplication().cancelAllLocalNotifications()

            workoutNotification(GlobalVars.workoutNotificationStartHour + 1, fMin: 50, fCategory: GlobalVars.workoutNotificationCategory ,fAlertBody: "Time for a 1 Minute Workout!", fRepeat: NSCalendarUnit.CalendarUnitHour)
            println("notification set for lower body >= 30")
        }else {
            // clears out all set notifications, just in case
            UIApplication.sharedApplication().cancelAllLocalNotifications()

            workoutNotification(GlobalVars.workoutNotificationStartHour, fMin: 50, fCategory: GlobalVars.workoutNotificationCategory, fAlertBody: "Time for a 1 Minute Workout!", fRepeat: NSCalendarUnit.CalendarUnitHour)
            println("notification set for lower body < 30")
        }
    }
    
    
    // instantiates the tutorial XIB
    let vc = TutorialXIBViewController(nibName: "TutorialXIBViewController", bundle: nil)
    
    
    //------------------------------------ Notification Stuff ----------------------------------------------------//
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
        dateComp.hour = fHour    // sets to current hour
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
    //------------------------------------ /Notification Stuff ----------------------------------------------------//
    
    override func viewWillAppear(animated: Bool) {
        println("start pages viewWillAppear")
        setNotifVars() // sets the notification default settings to the appropriate GlobalVars
        
        // checks to see if the user has seen the OOBE Tute/Disclaimer/Setup
        let appUserSettings = NSUserDefaults.standardUserDefaults() // instantiates a user default holder
        
        if let oobeShown = appUserSettings.stringForKey(GlobalVars.oobeTute){
            // if there IS a value set this will happen
            println("The user has oobe defined: \(oobeShown)")
        }else{
            // there is NO value set so this will happen
            vc.modalTransitionStyle = UIModalTransitionStyle.CoverVertical  // show disclaimer XIB which leads to walkthrough and initial setup
            presentViewController(vc, animated: true, completion: nil)
            println("oobeTute is set to \(appUserSettings.valueForKey(GlobalVars.oobeTute))")
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GlobalVars.exerciseIndexCount = 0
       
        // instantiates the Upper Body array data        
        var newExercise = Exercise(name: "Push-Ups", filename: "push-ups", tips:
            "Lie on the floor face down and place your hands just about about shoulder width apart while holding your torso up at arms length. \n\n" +
            "Next, lower yourself down until your chest almost touches the floor as you inhale.\n\n" +
            "Now press your upper body back up to the starting position, focussing on squeezing your chest while exhaling.\n\n" +
            "Do as many as you can in a minute, but take breaks as needed.") // 0
        GlobalVars.exerciseUB.append(newExercise)
                
        newExercise = Exercise(name: "Crunches", filename: "sit-ups", tips:
            "Lie down with your back flat to the floor.\n\n" +
            "Bend your knees at a 90-degree angle to your body (It may be easier to rest your feet under a chair to lock them in place). \n\n" +
            "Cross your hands in front of your chest. \n\n" +
            "Make sure there is a fist's worth of space between your chin and chest. \n\n" +
            "Draw your belly button in to the base of your spine.\n\n" +
            "Sit up until your shoulder blades are lifted off the floor. Focus on your abdominal muscles rather than your back, leg or neck muscles.\n\n" +
            "Exhale as you sit up. Inhale as you lie down.\n\n" +
            "Do as many as you can in a minute, but take breaks as needed.") // 1
        GlobalVars.exerciseUB.append(newExercise)
        
        newExercise = Exercise(name: "Curls", filename: "curls", tips:
            "Choose a resistance band that allows you to do at least 15 repetitions in one set. \n\n" +
            "Stand up straight with your feet hip width apart. \n\n" +
            "Place the band under your feet and hold the handles down by your sides (make sure each side is even). \n\n" +
            "Curl your arms up toward your shoulders. Make sure you keep your elbows tucked in at your sides while you exhale (don't arch your back). \n\n" +
            "Return to the starting position in a slow and controlled manner while you inhale. \n\n" +
            "Do as many as you can in a minute, but take breaks as needed.") // 2
        GlobalVars.exerciseUB.append(newExercise)
        
        newExercise = Exercise(name: "Kick Backs", filename: "tricep-kickbacks", tips:
            "Choose a resistance band that allows you to do at least 15 repetitions in one set per arm. \n\n" +
            "Start with  your weakest arm (if you're right handed it's probably your left arm). \n\n" +
            "Place the band under your right foot, take a step backwards with your left foot and hold the handle down by your side. \n\n" +
            "Place your right hand against your leg and bend your left arm at a 90 degree angle with your tricep parallel with the floor. Make sure you keep your elbow against your body. \n\n" +
            "Kick your left hand back so your arm is straight making sure to focus on using your tricep muscle. while you exhale" +
            "Return to the starting position in a slow and controlled manner while you inhale. \n\n" +
            "Do as many as you can in 30 seconds, takeing breaks as needed, then switch stances and do the other arm for 30 seconds.") // 3
        GlobalVars.exerciseUB.append(newExercise)

        // 2nd set
        newExercise = Exercise(name: "Wide Push-Ups", filename: "push-ups-wide", tips:
            "Lie on the floor face down and place your hands about a shoulder and half width apart (your elbows should be at 90 degree angles and parallel with the floor when in the down position) while holding your torso up at arms length. \n\n" +
            "Next, lower yourself down until your chest almost touches the floor as you inhale.\n\n" +
            "Now press your upper body back up to the starting position, focussing on squeezing your chest while exhaling.\n\n" +
            "Do as many as you can in a minute, but take breaks as needed.") // 4
        GlobalVars.exerciseUB.append(newExercise)
        
        newExercise = Exercise(name: "Leg Lifts", filename: "lower-abs", tips:
            "Lie flat on your back with your legs stretched out in front of you. Your legs should just be a toe's width apart. Make sure to keep your hands down flat on the ground near your sides, with your palms down. \n\n" +
            "Bend your knees and raise your legs. Your calves should be parallel to the ground, while your thighs are perpendicular. You should keep your toes pointed while you do this, drawing your abdominal muscles toward your spine. \n\n" +
            "Continue curling your kneeds towards your chest. Raise your legs as slowly as possible while exhaling. \n\n" +
            "Slowly lower your legs. Bring them down to about an inch off the floor. Don't just let gravity work for you, make sure you're in control. Hold your arms in the same place, but use them for balance and support as you lower your legs. \n\n" +
            "Do as many as you can in a minute, but take breaks as needed.") //5
        GlobalVars.exerciseUB.append(newExercise)
        
        newExercise = Exercise(name: "Curls", filename: "curls", tips:
            "Choose a resistance band that allows you to do at least 15 repetitions in one set. \n\n" +
                "Stand up straight with your feet hip width apart. \n\n" +
                "Place the band under your feet and hold the handles down by your sides (make sure each side is even). \n\n" +
                "Curl your arms up toward your shoulders. Make sure you keep your elbows tucked in at your sides while you exhale (don't arch your back). \n\n" +
                "Return to the starting position in a slow and controlled manner while you inhale. \n\n" +
            "Do as many as you can in a minute, but take breaks as needed.") // 6
        GlobalVars.exerciseUB.append(newExercise)
        
        newExercise = Exercise(name: "Kick Backs", filename: "tricep-kickbacks", tips:
            "Choose a resistance band that allows you to do at least 15 repetitions in one set per arm. \n\n" +
                "Start with  your weakest arm (if you're right handed it's probably your left arm). \n\n" +
                "Place the band under your right foot, take a step backwards with your left foot and hold the handle down by your side. \n\n" +
                "Place your right hand against your leg and bend your left arm at a 90 degree angle with your tricep parallel with the floor. Make sure you keep your elbow against your body. \n\n" +
                "Kick your left hand back so your arm is straight making sure to focus on using your tricep muscle. while you exhale" +
                "Return to the starting position in a slow and controlled manner while you inhale. \n\n" +
            "Do as many as you can in 30 seconds, takeing breaks as needed, then switch stances and do the other arm for 30 seconds.") // 7
        GlobalVars.exerciseUB.append(newExercise)
        
        
        // instantiates the Lower Body array data
        newExercise = Exercise(name: "Squats", filename: "squats", tips:
            "Stand with your spine in a straight line, and have your feet a little wider than hip-width apart. \n\n" +
            "Bend at the knees to lower your hips toward the ground and move them backwards, as though you're going to sit in a chair. Your shins should be perpendicular to the floor and your spine should stay straight. Keep your arms out in front of you for balance as needed while you inhale. \n\n" +
            "Now straighten your legs back to the starting position while you exhale \n\n" +
                "If you can't do a full squat by bringing your hips close to the floor, do a half squat or squat down as far as you can until you improve and can go lower. \n\n" +
            "Do as many as you can in a minute, takeing breaks as needed.") // 0
        GlobalVars.exerciseLB.append(newExercise)
        
        newExercise = Exercise(name: "Crunches", filename: "sit-ups", tips:
            "Lie down with your back flat to the floor.\n\n" +
                "Bend your knees at a 90-degree angle to your body (It may be easier to rest your feet under a chair to lock them in place). \n\n" +
                "Cross your hands in front of your chest. \n\n" +
                "Make sure there is a fist's worth of space between your chin and chest. \n\n" +
                "Draw your belly button in to the base of your spine.\n\n" +
                "Sit up until your shoulder blades are lifted off the floor. Focus on your abdominal muscles rather than your back, leg or neck muscles.\n\n" +
                "Exhale as you sit up. Inhale as you lie down.\n\n" +
            "Do as many as you can in a minute, but take breaks as needed.") // 1
        GlobalVars.exerciseLB.append(newExercise)
        
        newExercise = Exercise(name: "Lunges", filename: "lunges", tips:
            "Stand up straight with your feet about a shoulder width apart. Put your hands on your hips, keep your back as straight as possible, relax your shoulders and keep your eyes facing directly ahead. \n\n" +
            "Take a large step forward with one leg. The length of your step will depend on your height, but it will usually be somewhere between 2 or 3 feet (0.6 or 0.9 m). \n\n" +
            "As you step forward, lower your hips and bend your knees until they both form 90 degree angles while inhaling. Your front knee should not extend over your toes and your back knee should not touch the ground. \n\n" +
            "Pause at the bottom of the lunge for a second then push off the heel of your front foot to return to the starting position while exhaling. \n\n" +
            "Alternate legs as you go. \n\n" +
            "Do as many as you can in a minute, but take breaks as needed.") // 2
        GlobalVars.exerciseLB.append(newExercise)
        
        newExercise = Exercise(name: "Calf Raises", filename: "calf-raises", tips:
            "Stand with your feet shoulder width apart. You can hold the back of a chair for balance if needed. \n\n" +
                "Lift your heels until you're standing on your tip toes while exhaling. Distribute most of your weight onto the balls of your feet, and keep your legs straight. \n\n" +
                "Stay on your tip toes for two seconds. Then, begin to lower your heels, and move your weight away from the balls of your feet until your heels are back on the ground while inhaling. \n\n" +
            "Do as many as you can in a minute, but take breaks as needed.") // 3
        GlobalVars.exerciseLB.append(newExercise)
        
        // 2nd set
        newExercise = Exercise(name: "Squats", filename: "squats", tips:
            "Stand with your spine in a straight line, and have your feet a little wider than hip-width apart. \n\n" +
                "Bend at the knees to lower your hips toward the ground and move them backwards, as though you're going to sit in a chair. Your shins should be perpendicular to the floor and your spine should stay straight. Keep your arms out in front of you for balance as needed while you inhale. \n\n" +
                "Now straighten your legs back to the starting position while you exhale \n\n" +
                "If you can't do a full squat by bringing your hips close to the floor, do a half squat or squat down as far as you can until you improve and can go lower. \n\n" +
            "Do as many as you can in a minute, takeing breaks as needed.") // 4
        GlobalVars.exerciseLB.append(newExercise)
        
        newExercise = Exercise(name: "Leg Lifts", filename: "lower-abs", tips:
            "Lie flat on your back with your legs stretched out in front of you. Your legs should just be a toe's width apart. Make sure to keep your hands down flat on the ground near your sides, with your palms down. \n\n" +
                "Bend your knees and raise your legs. Your calves should be parallel to the ground, while your thighs are perpendicular. You should keep your toes pointed while you do this, drawing your abdominal muscles toward your spine. \n\n" +
                "Continue curling your kneeds towards your chest. Raise your legs as slowly as possible while exhaling. \n\n" +
                "Slowly lower your legs. Bring them down to about an inch off the floor. Don't just let gravity work for you, make sure you're in control. Hold your arms in the same place, but use them for balance and support as you lower your legs. \n\n" +
            "Do as many as you can in a minute, but take breaks as needed.") //5
        GlobalVars.exerciseLB.append(newExercise)
        
        newExercise = Exercise(name: "Lunges", filename: "lunges", tips:
            "Stand up straight with your feet about a shoulder width apart. Put your hands on your hips, keep your back as straight as possible, relax your shoulders and keep your eyes facing directly ahead. \n\n" +
                "Take a large step forward with one leg. The length of your step will depend on your height, but it will usually be somewhere between 2 or 3 feet (0.6 or 0.9 m). \n\n" +
                "As you step forward, lower your hips and bend your knees until they both form 90 degree angles while inhaling. Your front knee should not extend over your toes and your back knee should not touch the ground. \n\n" +
                "Pause at the bottom of the lunge for a second then push off the heel of your front foot to return to the starting position while exhaling. \n\n" +
                "Alternate legs as you go. \n\n" +
            "Do as many as you can in a minute, but take breaks as needed.") // 6
        GlobalVars.exerciseLB.append(newExercise)
        
        newExercise = Exercise(name: "Calf Raises", filename: "calf-raises", tips:
            "Stand with your feet shoulder width apart. You can hold the back of a chair for balance if needed. \n\n" +
                "Lift your heels until you're standing on your tip toes while exhaling. Distribute most of your weight onto the balls of your feet, and keep your legs straight. \n\n" +
                "Stay on your tip toes for two seconds. Then, begin to lower your heels, and move your weight away from the balls of your feet until your heels are back on the ground while inhaling. \n\n" +
            "Do as many as you can in a minute, but take breaks as needed.") // 7
        GlobalVars.exerciseLB.append(newExercise)

        // checks to see if the user has seen the OOBE Tute/Disclaimer/Setup
        let appUserSettings = NSUserDefaults.standardUserDefaults() // instantiates a user default holder
        // sets start 1MW App notification
        if let startNotifSet: AnyObject = appUserSettings.valueForKey("startDayHour"){
            // if there IS a value set this will happen
            var startHour = appUserSettings.integerForKey(GlobalVars.startDayHour)
            var startMin = appUserSettings.integerForKey(GlobalVars.startDayMin)
            
            setNotifVars()// sets globalvars and prints curren notfication settings
            
            workoutNotification(GlobalVars.workoutNotificationStartHour, fMin: GlobalVars.workoutNotificationStartMin, fCategory: "", fAlertBody: "Time to start your day!", fRepeat: NSCalendarUnit.CalendarUnitDay)
            
        }else{
            // there is NO value set so this will happen
//            appUserSettings.setValue(8, forKey: GlobalVars.startDayHour)
//            println("startDayHour was set to \(appUserSettings.valueForKey(GlobalVars.startDayHour))")
//            appUserSettings.setValue(30, forKey: GlobalVars.startDayMin)
//            println("startDayMin was set to \(appUserSettings.valueForKey(GlobalVars.startDayMin))")
//            appUserSettings.setValue(true, forKey: GlobalVars.notificationWeekday)
//            println("notificationWeekday was set to \(appUserSettings.valueForKey(GlobalVars.notificationWeekday))")
//            appUserSettings.setValue(false, forKey: GlobalVars.notificationWeekend)
//            println("notificationWeekend was set to \(appUserSettings.valueForKey(GlobalVars.notificationWeekend))")
        }
        
        println(" start page's viewDidLoad")
    }
    
    //------------------------------------ Notification Functions when button action tapped----------------------------------------------------//
    
//    func snoozeWorkout(notification:NSNotification){
//        
//        println("5 min snooze hit")
//    }
    //------------------------------------ /Notification Functions ----------------------------------------------------//
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "segueToUBExerciseType"{
            let vc = segue.destinationViewController as! OneMWViewController
            vc.navTitle = "Upper Body + Core"
            vc.exerciseTitle = GlobalVars.exerciseUB[GlobalVars.exerciseIndexCount].name
            vc.exerciseImage = UIImage(named: GlobalVars.exerciseUB[GlobalVars.exerciseIndexCount].filename)
        }else {
            let vc = segue.destinationViewController as! OneMWViewController
            vc.navTitle = "Lower Body + Core"
            vc.exerciseTitle = GlobalVars.exerciseLB[GlobalVars.exerciseIndexCount].name
            vc.exerciseImage = UIImage(named: GlobalVars.exerciseLB[GlobalVars.exerciseIndexCount].filename)
        }
    }


}
