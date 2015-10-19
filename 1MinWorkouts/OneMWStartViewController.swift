//
//  OneMWStartViewController.swift
//  1MinWorkouts
//
//  Created by Justin on 12/31/14.
//  Copyright (c) 2014 Good Enough LLC. All rights reserved.
//

import UIKit

class OneMWStartViewController: UIViewController {
    
    @IBOutlet var UBBtnLastWorkoutLabel: UILabel!
    @IBOutlet var LBBtnLastWorkoutLabel: UILabel!
    @IBOutlet var CoreBtnLastWorkoutLabel: UILabel!
    
    // function that sets todays current date to the selected muscle group
    func getTodaysDate(){
        let todaysDate = NSDate()
        
        let todaysDateFormatter = NSDateFormatter()
        todaysDateFormatter.dateStyle = .MediumStyle
        //todaysDateFormatter.timeStyle = .ShortStyle
        
        let todaysDateString = todaysDateFormatter.stringFromDate(todaysDate)
        
        UBBtnLastWorkoutLabel.text = "Last Workout: \(todaysDateString)"
        LBBtnLastWorkoutLabel.text = "Last Workout: \(todaysDateString)"
        CoreBtnLastWorkoutLabel.text = "Last Workout: \(todaysDateString)"
    }
    
    @IBAction func upperBodyBtn(sender: AnyObject) {
        GlobalVars.exerciseGroup = false
        
//        // sets workout notifications for the day
//        if GlobalVars.workoutNotificationStartMin >= 30{
//            // clears out all set notifications, just in case
//            UIApplication.sharedApplication().cancelAllLocalNotifications()
//            
//            workoutNotification(GlobalVars.workoutNotificationStartHour + 1, fMin: 50, fCategory: GlobalVars.workoutNotificationCategory ,fAlertBody: "It's time for a 1 Minute Workout!", fRepeat: NSCalendarUnit.CalendarUnitHour)
//            println("notification set for upper body >= 30")
//        }else {
//            // clears out all set notifications, just in case
//            UIApplication.sharedApplication().cancelAllLocalNotifications()
//            
//            workoutNotification(GlobalVars.workoutNotificationStartHour, fMin: 50, fCategory: GlobalVars.workoutNotificationCategory, fAlertBody: "It's time for a 1 Minute Workout!", fRepeat: NSCalendarUnit.CalendarUnitHour)
//            println("notification set for upper body < 30")
//        }
        
        // get todays date and set it to the Last Workout label and show/hide correct labels
        getTodaysDate()
        UBBtnLastWorkoutLabel.hidden = false
        LBBtnLastWorkoutLabel.hidden = true
        CoreBtnLastWorkoutLabel.hidden = true
    }
    
    @IBAction func lowerBodyBtn(sender: AnyObject) {
        GlobalVars.exerciseGroup = true
        // get todays date and set it to the Last Workout label and show/hide correct labels
        getTodaysDate()
        UBBtnLastWorkoutLabel.hidden = true
        LBBtnLastWorkoutLabel.hidden = false
        CoreBtnLastWorkoutLabel.hidden = true
    }
    
    @IBAction func allCoreBtn(sender: AnyObject) {
        GlobalVars.exerciseGroup = true
        // get todays date and set it to the Last Workout label and show/hide correct labels
        getTodaysDate()
        UBBtnLastWorkoutLabel.hidden = true
        LBBtnLastWorkoutLabel.hidden = true
        CoreBtnLastWorkoutLabel.hidden = false
    }
    
    // instantiates the walkthrough XIB
    let vc = TutorialXIBViewController(nibName: "TutorialXIBViewController", bundle: nil)
    
    
    //------------------------------------ Notification Function ----------------------------------------------------//
    func workoutNotification(fHour: Int, fMin: Int, fCategory: String ,fAlertBody: String, fRepeat: NSCalendarUnit){
        
        let today = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Year, .Month, .Day, .Hour, .Minute, .Second], fromDate: today)
        //let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitMonth | .CalendarUnitYear | .CalendarUnitDay, fromDate: today)
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
    
    override func viewWillAppear(animated: Bool) {
        setNotifVars() // sets the notification default settings to the appropriate GlobalVars
        
        // checks to see if the user has seen the OOBE Tute/Disclaimer/Setup
        let appUserSettings = NSUserDefaults.standardUserDefaults() // instantiates a user default holder
        
        if let oobeShown = appUserSettings.stringForKey(GlobalVars.oobeTute){
            // if there IS a value set this will happen
        }else{
            // there is NO value set so this will happen
            vc.modalTransitionStyle = UIModalTransitionStyle.CoverVertical  // show disclaimer XIB which leads to walkthrough and initial setup
            presentViewController(vc, animated: true, completion: nil)
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hides all last workout date labels on start up
        UBBtnLastWorkoutLabel.hidden = true
        LBBtnLastWorkoutLabel.hidden = true
        CoreBtnLastWorkoutLabel.hidden = true
        
        GlobalVars.exerciseIndexCount = 0
       
        // instantiates the Upper Body array data        
        var newExercise = Exercise(name: "Push-Ups", filename: "push-ups", tips:
            "1. Lie on the floor face down and place your hands just about about shoulder width apart while holding your torso up at arms length. \n\n" +
            "2. Lower yourself down until your chest almost touches the floor as you inhale.\n\n" +
            "3. Press your upper body back up to the starting position, focussing on squeezing your chest while exhaling.\n\n" +
            "Do as many as you can in a minute, but take breaks as needed.") // 0
        GlobalVars.exerciseUB.append(newExercise)
                
        newExercise = Exercise(name: "Plank", filename: "plank", tips:
            "1. Lie on your stomach, flat on the floor. Push up onto your forearms.\n\n" +
            "2. Bend your elbows and rest your weight on your forearms.\n\n" +
            "3. Keep your elbows under your shoulders.\n\n" +
            "4. Pull your belly button towards your spine.\n\n" +
            "5. Your body should form a flat line. Don’t let your hips sag, and don’t push your butt up—keep your body in a straight line.\n\n" +
            "6. You can do this plank on your hands instead of your elbows if you prefer (if you feel any pain or stiffness in your wrists, balance your weight on your elbows instead).\n\n" +
            "Hold this position for as long as you can, but take breaks as needed.") // 1
        GlobalVars.exerciseUB.append(newExercise)
        
        newExercise = Exercise(name: "Curls", filename: "curls", tips:
            "1. Choose a resistance band that allows you to do at least 15 repetitions in one set. \n\n" +
            "2. Stand up straight with your feet hip width apart. \n\n" +
            "3. Place the band under your feet and hold the handles down by your sides (make sure each side is even). \n\n" +
            "4. Curl your arms up toward your shoulders (exhale and make sure to keep your elbows tucked in at your sides - don't arch your back). \n\n" +
            "5. Return to the starting position in a slow and controlled manner while you inhale. \n\n" +
            "Do as many as you can in a minute, but take breaks as needed.") // 2
        GlobalVars.exerciseUB.append(newExercise)
        
        newExercise = Exercise(name: "Tricep Dips", filename: "dips", tips:
            "1. Position your hands shoulder-width apart on a secured table/desk or stable chair. \n\n" +
            "2. Slide your butt off the front of the chair with your legs extended out in front of you. \n\n" +
            "3. Straighten your arms, keeping a little bend in your elbows to keep tension on your triceps and off your elbow joints. \n\n" +
            "4. Slowly bend your elbows to lower your body toward the floor until your elbows are at about a 90-degree angle. Be sure to keep your back close to the chairs seat. \n\n" +
            "5. Once you reach the bottom of the movement, press down into the chair to straighten your elbows, returning to the starting position. This completes one rep. \n\n" +
            "6. Keep your shoulders down as you lower and raise your body. You can bend your legs to modify this exercise. \n\n" +
            "Do as many as you can, takeing breaks as needed.") // 3
        GlobalVars.exerciseUB.append(newExercise)

        // 2nd set
        newExercise = Exercise(name: "Wide Push-Ups", filename: "push-ups-wide", tips:
            "1. Lie on the floor face down and place your hands about a shoulder and half width apart (your elbows should be at 90 degree angles and parallel with the floor when in the down position) while holding your torso up at arms length. \n\n" +
            "2. Lower yourself down until your chest almost touches the floor as you inhale.\n\n" +
            "3. Press your upper body back up to the starting position, focussing on squeezing your chest while exhaling.\n\n" +
            "Do as many as you can in a minute, but take breaks as needed.") // 4
        GlobalVars.exerciseUB.append(newExercise)
        
        newExercise = Exercise(name: "Side Plank", filename: "side-plank", tips:
            "1. Lie on your side with your legs straight and your body in a straight line (shoulders and hips stacked one on top of the other; don’t lean forward or backwards).\n\n" +
            "2. Prop your body up so your hips are off the floor. Rest your weight on the elbow that’s touching the floor.\n\n" +
            "3. Only your forearm and feet should touch the floor.\n\n" +
            "4. Do not let your hips sag (this is the challenging part of this move). As you get tired, you’ll want to drop your hips, but focus on keeping them stationary. \n\n" +
            "Hold for 30 seconds then switch sides for the remainder of the minute, but take breaks as needed.") //5
        GlobalVars.exerciseUB.append(newExercise)
        
        newExercise = Exercise(name: "Curls", filename: "curls", tips:
            "1. Choose a resistance band that allows you to do at least 15 repetitions in one set. \n\n" +
            "2. Stand up straight with your feet hip width apart. \n\n" +
            "3. Place the band under your feet and hold the handles down by your sides (make sure each side is even). \n\n" +
            "4. Curl your arms up toward your shoulders (exhale and make sure to keep your elbows tucked in at your sides - don't arch your back). \n\n" +
            "5. Return to the starting position in a slow and controlled manner while you inhale. \n\n" +
            "Do as many as you can in a minute, but take breaks as needed.") // 6
        GlobalVars.exerciseUB.append(newExercise)
        
        newExercise = Exercise(name: "Tricep Dips", filename: "dips", tips:
            "1. Position your hands shoulder-width apart on a secured table/desk or stable chair. \n\n" +
            "2. Slide your butt off the front of the chair with your legs extended out in front of you. \n\n" +
            "3. Straighten your arms, keeping a little bend in your elbows to keep tension on your triceps and off your elbow joints. \n\n" +
            "4. Slowly bend your elbows to lower your body toward the floor until your elbows are at about a 90-degree angle. Be sure to keep your back close to the chairs seat. \n\n" +
            "5. Once you reach the bottom of the movement, press down into the chair to straighten your elbows, returning to the starting position. This completes one rep. \n\n" +
            "6. Keep your shoulders down as you lower and raise your body. You can bend your legs to modify this exercise. \n\n" +
            "Do as many as you can, takeing breaks as needed.")  // 7
        GlobalVars.exerciseUB.append(newExercise)
        
        
        // instantiates the Lower Body array data
        newExercise = Exercise(name: "Squats", filename: "squats", tips:
            "1. Stand with your spine in a straight line, and have your feet a little wider than hip-width apart. \n\n" +
            "2. Bend at the knees to lower your hips toward the ground and move them backwards, as though you're going to sit in a chair. Your shins should be perpendicular to the floor and your spine should stay straight. Keep your arms out in front of you for balance as needed while you inhale. \n\n" +
            "3. Straighten your legs back to the starting position while you exhale \n\n" +
            "If you can't do a full squat by bringing your hips close to the floor, do a half squat or squat down as far as you can until you improve and can go lower. \n\n" +
            "Do as many as you can in a minute, takeing breaks as needed.") // 0
        GlobalVars.exerciseLB.append(newExercise)
        
        newExercise = Exercise(name: "Crunches", filename: "sit-ups", tips:
            "1. Lie down with your back flat to the floor.\n\n" +
            "2. Bend your knees at a 90-degree angle to your body (It may be easier to rest your feet under a chair to lock them in place). \n\n" +
            "3. Cross your hands in front of your chest (Make sure there is a fist's worth of space between your chin and chest). \n\n" +
            "4. Draw your belly button in to the base of your spine while you sit up. Your shoulder blades should just lift off the floor. \n\n" +
            "Exhale as you sit up. Inhale as you lie down.\n\n" +
            "Do as many as you can in a minute, but take breaks as needed.") // 1
        GlobalVars.exerciseLB.append(newExercise)
        
        newExercise = Exercise(name: "Lunges", filename: "lunges", tips:
            "1. Stand up straight with your feet about a shoulder width apart. Put your hands on your hips, keep your back as straight as possible, relax your shoulders and keep your eyes facing directly ahead. \n\n" +
            "2. Take a large step forward with one leg. The length of your step will depend on your height, but it will usually be somewhere between 2 or 3 feet (0.6 or 0.9 m). \n\n" +
            "3. As you step forward, lower your hips and bend your knees until they both form 90 degree angles while inhaling. Your front knee should not extend over your toes and your back knee should not touch the ground. \n\n" +
            "4. Pause at the bottom of the lunge for a second then push off the heel of your front foot to return to the starting position while exhaling. \n\n" +
            "Alternate legs as you go. \n\n" +
            "Do as many as you can in a minute, but take breaks as needed.") // 2
        GlobalVars.exerciseLB.append(newExercise)
        
        newExercise = Exercise(name: "Calf Raises", filename: "calf-raises", tips:
            "1. Stand with your feet shoulder width apart. You can hold the back of a chair for balance if needed. \n\n" +
            "2. Lift your heels until you're standing on your tip toes while exhaling. Distribute most of your weight onto the balls of your feet, and keep your legs straight. \n\n" +
            "3. Stay on your tip toes for two seconds. Then, begin to lower your heels, and move your weight away from the balls of your feet until your heels are back on the ground while inhaling. \n\n" +
            "Do as many as you can in a minute, but take breaks as needed.") // 3
        GlobalVars.exerciseLB.append(newExercise)
        
        // 2nd set
        newExercise = Exercise(name: "Squats", filename: "squats", tips:
            "1. Stand with your spine in a straight line, and have your feet a little wider than hip-width apart. \n\n" +
            "2. Bend at the knees to lower your hips toward the ground and move them backwards, as though you're going to sit in a chair. Your shins should be perpendicular to the floor and your spine should stay straight. Keep your arms out in front of you for balance as needed while you inhale. \n\n" +
            "3. Straighten your legs back to the starting position while you exhale \n\n" +
            "If you can't do a full squat by bringing your hips close to the floor, do a half squat or squat down as far as you can until you improve and can go lower. \n\n" +
            "Do as many as you can in a minute, takeing breaks as needed.") // 4
        GlobalVars.exerciseLB.append(newExercise)
        
        newExercise = Exercise(name: "Leg Lifts", filename: "lower-abs", tips:
            "1. Lie flat on your back with your legs stretched out in front of you. Your legs should just be a toe's width apart. Make sure to keep your hands down flat on the ground near your sides, with your palms down. \n\n" +
            "2. Bend your knees and raise your legs. Your calves should be parallel to the ground, while your thighs are perpendicular. You should keep your toes pointed while you do this, drawing your abdominal muscles toward your spine. \n\n" +
            "3. Continue curling your knees towards your chest. Raise your legs as slowly as possible while exhaling. \n\n" +
            "4. Slowly lower your legs. Bring them down to about an inch off the floor. Don't just let gravity work for you, make sure you're in control. Hold your arms in the same place, but use them for balance and support as you lower your legs. \n\n" +
            "Do as many as you can in a minute, but take breaks as needed.") //5
        GlobalVars.exerciseLB.append(newExercise)
        
        newExercise = Exercise(name: "Lunges", filename: "lunges", tips:
            "1. Stand up straight with your feet about a shoulder width apart. Put your hands on your hips, keep your back as straight as possible, relax your shoulders and keep your eyes facing directly ahead. \n\n" +
            "2. Take a large step forward with one leg. The length of your step will depend on your height, but it will usually be somewhere between 2 or 3 feet (0.6 or 0.9 m). \n\n" +
            "3. As you step forward, lower your hips and bend your knees until they both form 90 degree angles while inhaling. Your front knee should not extend over your toes and your back knee should not touch the ground. \n\n" +
            "4. Pause at the bottom of the lunge for a second then push off the heel of your front foot to return to the starting position while exhaling. \n\n" +
            "Alternate legs as you go. \n\n" +
            "Do as many as you can in a minute, but take breaks as needed.") // 6
        GlobalVars.exerciseLB.append(newExercise)
        
        newExercise = Exercise(name: "Calf Raises", filename: "calf-raises", tips:
            "1. Stand with your feet shoulder width apart. You can hold the back of a chair for balance if needed. \n\n" +
            "2. Lift your heels until you're standing on your tip toes while exhaling. Distribute most of your weight onto the balls of your feet, and keep your legs straight. \n\n" +
            "3. Stay on your tip toes for two seconds. Then, begin to lower your heels, and move your weight away from the balls of your feet until your heels are back on the ground while inhaling. \n\n" +
            "Do as many as you can in a minute, but take breaks as needed.") // 7
        GlobalVars.exerciseLB.append(newExercise)
        
        // instantiates the Core array data
        newExercise = Exercise(name: "Plank", filename: "plank", tips:
            "1. Lie on your stomach, flat on the floor. Push up onto your forearms.\n\n" +
                "2. Bend your elbows and rest your weight on your forearms.\n\n" +
                "3. Keep your elbows under your shoulders.\n\n" +
                "4. Pull your belly button towards your spine.\n\n" +
                "5. Your body should form a flat line. Don’t let your hips sag, and don’t push your butt up—keep your body in a straight line.\n\n" +
                "6. You can do this plank on your hands instead of your elbows if you prefer (if you feel any pain or stiffness in your wrists, balance your weight on your elbows instead).\n\n" +
            "Hold this position for as long as you can, but take breaks as needed.") // 0
        GlobalVars.exerciseCore.append(newExercise)
        
        newExercise = Exercise(name: "Side Plank", filename: "side-plank", tips:
            "1. Lie on your side with your legs straight and your body in a straight line (shoulders and hips stacked one on top of the other; don’t lean forward or backwards).\n\n" +
                "2. Prop your body up so your hips are off the floor. Rest your weight on the elbow that’s touching the floor.\n\n" +
                "3. Only your forearm and feet should touch the floor.\n\n" +
                "4. Do not let your hips sag (this is the challenging part of this move). As you get tired, you’ll want to drop your hips, but focus on keeping them stationary. \n\n" +
            "Hold for 30 seconds then switch sides for the remainder of the minute, but take breaks as needed.") //1
        GlobalVars.exerciseCore.append(newExercise)
        
        newExercise = Exercise(name: "Crunches", filename: "sit-ups", tips:
            "1. Lie down with your back flat to the floor.\n\n" +
                "2. Bend your knees at a 90-degree angle to your body (It may be easier to rest your feet under a chair to lock them in place). \n\n" +
                "3. Cross your hands in front of your chest (Make sure there is a fist's worth of space between your chin and chest). \n\n" +
                "4. Draw your belly button in to the base of your spine while you sit up. Your shoulder blades should just lift off the floor. \n\n" +
                "Exhale as you sit up. Inhale as you lie down.\n\n" +
            "Do as many as you can in a minute, but take breaks as needed.") // 2
        GlobalVars.exerciseCore.append(newExercise)
        
        newExercise = Exercise(name: "Leg Lifts", filename: "lower-abs", tips:
            "1. Lie flat on your back with your legs stretched out in front of you. Your legs should just be a toe's width apart. Make sure to keep your hands down flat on the ground near your sides, with your palms down. \n\n" +
                "2. Bend your knees and raise your legs. Your calves should be parallel to the ground, while your thighs are perpendicular. You should keep your toes pointed while you do this, drawing your abdominal muscles toward your spine. \n\n" +
                "3. Continue curling your knees towards your chest. Raise your legs as slowly as possible while exhaling. \n\n" +
                "4. Slowly lower your legs. Bring them down to about an inch off the floor. Don't just let gravity work for you, make sure you're in control. Hold your arms in the same place, but use them for balance and support as you lower your legs. \n\n" +
            "Do as many as you can in a minute, but take breaks as needed.") //3
        GlobalVars.exerciseCore.append(newExercise)
        
        newExercise = Exercise(name: "Plank", filename: "plank", tips:
            "1. Lie on your stomach, flat on the floor. Push up onto your forearms.\n\n" +
                "2. Bend your elbows and rest your weight on your forearms.\n\n" +
                "3. Keep your elbows under your shoulders.\n\n" +
                "4. Pull your belly button towards your spine.\n\n" +
                "5. Your body should form a flat line. Don’t let your hips sag, and don’t push your butt up—keep your body in a straight line.\n\n" +
                "6. You can do this plank on your hands instead of your elbows if you prefer (if you feel any pain or stiffness in your wrists, balance your weight on your elbows instead).\n\n" +
            "Hold this position for as long as you can, but take breaks as needed.") // 4
        GlobalVars.exerciseCore.append(newExercise)
        
        newExercise = Exercise(name: "Side Plank", filename: "side-plank", tips:
            "1. Lie on your side with your legs straight and your body in a straight line (shoulders and hips stacked one on top of the other; don’t lean forward or backwards).\n\n" +
                "2. Prop your body up so your hips are off the floor. Rest your weight on the elbow that’s touching the floor.\n\n" +
                "3. Only your forearm and feet should touch the floor.\n\n" +
                "4. Do not let your hips sag (this is the challenging part of this move). As you get tired, you’ll want to drop your hips, but focus on keeping them stationary. \n\n" +
            "Hold for 30 seconds then switch sides for the remainder of the minute, but take breaks as needed.") // 5
        GlobalVars.exerciseCore.append(newExercise)
        
        newExercise = Exercise(name: "Crunches", filename: "sit-ups", tips:
            "1. Lie down with your back flat to the floor.\n\n" +
                "2. Bend your knees at a 90-degree angle to your body (It may be easier to rest your feet under a chair to lock them in place). \n\n" +
                "3. Cross your hands in front of your chest (Make sure there is a fist's worth of space between your chin and chest). \n\n" +
                "4. Draw your belly button in to the base of your spine while you sit up. Your shoulder blades should just lift off the floor. \n\n" +
                "Exhale as you sit up. Inhale as you lie down.\n\n" +
            "Do as many as you can in a minute, but take breaks as needed.") // 6
        GlobalVars.exerciseCore.append(newExercise)
        
        newExercise = Exercise(name: "Leg Lifts", filename: "lower-abs", tips:
            "1. Lie flat on your back with your legs stretched out in front of you. Your legs should just be a toe's width apart. Make sure to keep your hands down flat on the ground near your sides, with your palms down. \n\n" +
                "2. Bend your knees and raise your legs. Your calves should be parallel to the ground, while your thighs are perpendicular. You should keep your toes pointed while you do this, drawing your abdominal muscles toward your spine. \n\n" +
                "3. Continue curling your knees towards your chest. Raise your legs as slowly as possible while exhaling. \n\n" +
                "4. Slowly lower your legs. Bring them down to about an inch off the floor. Don't just let gravity work for you, make sure you're in control. Hold your arms in the same place, but use them for balance and support as you lower your legs. \n\n" +
            "Do as many as you can in a minute, but take breaks as needed.") // 7
        GlobalVars.exerciseCore.append(newExercise)
        

        // checks to see if the user has seen the OOBE Tute/Disclaimer/Setup
        let appUserSettings = NSUserDefaults.standardUserDefaults() // instantiates a user default holder
        // sets start 1MW App notification
        if let startNotifSet: AnyObject = appUserSettings.valueForKey("startDayHour"){
            // if there IS a value set this will happen
            var startHour = appUserSettings.integerForKey(GlobalVars.startDayHour)
            var startMin = appUserSettings.integerForKey(GlobalVars.startDayMin)
            
            setNotifVars()// sets globalvars and prints curren notfication settings
            
            workoutNotification(GlobalVars.workoutNotificationStartHour, fMin: GlobalVars.workoutNotificationStartMin, fCategory: "", fAlertBody: "Time for your first workout of the day!", fRepeat: NSCalendarUnit.Day)
            
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
        }
        if segue.identifier == "segueToLBExerciseType"{
            let vc = segue.destinationViewController as! OneMWViewController
            vc.navTitle = "Lower Body + Core"
            vc.exerciseTitle = GlobalVars.exerciseLB[GlobalVars.exerciseIndexCount].name
            vc.exerciseImage = UIImage(named: GlobalVars.exerciseLB[GlobalVars.exerciseIndexCount].filename)
        }
        if segue.identifier == "segueToCoreExerciseType"{
            let vc = segue.destinationViewController as! OneMWViewController
            vc.navTitle = "All Core"
            vc.exerciseTitle = GlobalVars.exerciseCore[GlobalVars.exerciseIndexCount].name
            vc.exerciseImage = UIImage(named: GlobalVars.exerciseCore[GlobalVars.exerciseIndexCount].filename)
        }
    }


}
