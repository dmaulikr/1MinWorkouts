//
//  OneMWStartViewController.swift
//  1MinWorkouts
//
//  Created by Justin on 12/31/14.
//  Copyright (c) 2014 Good Enough LLC. All rights reserved.
//

import UIKit

class OneMWStartViewController: UIViewController {
   
    @IBOutlet var nextWorkoutNotificationLabel: UILabel!
    
    @IBAction func upperBodyBtn(sender: AnyObject) {
        GlobalVars.exerciseGroup = false
    }

    @IBAction func lowerBodyBtn(sender: AnyObject) {
        GlobalVars.exerciseGroup = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GlobalVars.exerciseIndexCount = 0
        
        //notificationsAreOk()// runs to see what notification settings state is
        
        // instantiates the Upper Body array data        
        var newExercise = Exercise(name: "Push-Ups", filename: "push-ups", tips:
            "Lie on the floor face down and place your hands just about at your shoulders while holding your torso up at arms length. \n\n" +
            "Next, lower yourself down until your chest almost touches the floor as you inhale.\n\n" +
            "Now breathe out and press your upper body back up to the starting position while squeezing your chest.\n\n" +
            "Do as many as you can in a minute, but take breaks as needed.") // 0
        GlobalVars.exerciseUB.append(newExercise)
        
        newExercise = Exercise(name: "Crunches", filename: "sit-ups", tips:
            "Lie down with your back flat to the floor.\n\n" +
            "Bend your knees are at a 90-degree angle to your body. It may be easier to rest your feet under a chair to lock them in place. \n\n" +
            "Cross your hands in front of your chest. For more advanced crunches, put your hands behind your head, but with the fingertips lightly touching the head, not clasping the head or neck. \n\n" +
            "Make sure there is a fist's worth of space between your chin and chest. \n\n" +
            "Draw your belly button in to the base of your spine.\n\n" +
            "Sit up until your shoulder blades are lifted off the floor. Be careful to use abdominal rather than back, leg or neck muscles.\n\n" +
            "Exhale as you sit up. Inhale as you lie down.\n\n" +
            "Do as many as you can in a minute, but take breaks as needed.") // 1
        GlobalVars.exerciseUB.append(newExercise)
        
        newExercise = Exercise(name: "Curls", filename: "curls", tips:
            "Choose a resistance band that allows you to do at least 15 repetitions in one set. \n\n" +
            "Stand up straight with your feet hip width apart. \n\n" +
            "Place the band under your feet and hold the handles down by your sides. \n\n" +
            "Curl your arms up toward your shoulders. Make sure you keep your elbows tucked in at your sides. \n\n" +
            "Return to the starting position in a slow and controlled manner. \n\n" +
            "Do as many as you can in a minute, but take breaks as needed.") // 2
        GlobalVars.exerciseUB.append(newExercise)
        
        newExercise = Exercise(name: "Kick Backs", filename: "tricep-kickbacks", tips:
            "Choose a resistance band that allows you to do at least 15 repetitions in one set per arm. \n\n" +
            "Start with  your weakest arm (if you're righty it's probably your left arm). \n\n" +
            "Place the band under your left foot, take a step backwards with your right foot and hold the handles down by your sides. \n\n" +
            "Place your left hand against your leg and bend your right arm at a 90 degree angle with your tricep parallel with the floor. Make sure you keep your elbow against your body. \n\n" +
            "Kick your right hand back so your arm is straight making sure to focus on using your tricep muscle." +
            "Return to the starting position in a slow and controlled manner. \n\n" +
            "Do as many as you can in 30 seconds, takeing breaks as needed, then switch stances and do the other arm for 30 seconds.") // 3
        GlobalVars.exerciseUB.append(newExercise)

        // 2nd set
        newExercise = Exercise(name: "Wide Push-Ups", filename: "push-ups-wide", tips:
            "Lie on the floor face down and place your hands so your elbows are at 90 degree angles and parallel with the floor while holding your torso up at arms length. \n\n" +
            "Next, lower yourself down until your chest almost touches the floor as you inhale.\n\n" +
            "Now breathe out and press your upper body back up to the starting position while squeezing your chest.\n\n" +
            "Do as many as you can in a minute, but take breaks as needed.") // 4
        GlobalVars.exerciseUB.append(newExercise)
        
        newExercise = Exercise(name: "Leg Lifts", filename: "lower-abs", tips:
            "Lie flat on your back with your legs stretched out in front of you. Your legs should just be a toe's width apart. Make sure to keep your hands down flat on the ground near your sides, with your palms down. \n\n" +
            "Bend your knees and raise your legs. Your calves should be parallel to the ground, while your thighs are perpendicular.[2] You should keep your toes pointed while you do this, drawing your abdominal muscles toward your spine. \n\n" +
            "Continue curling your kneeds towards your chest. Raise your legs as slowly as possible. \n\n" +
            "Slowly lower your legs. Bring them down to about an inch off the floor. Don't just let gravity work for you, make sure you're in control. Hold your arms in the same place, but use them for balance and support as you lower your legs. \n\n" +
            "Do as many as you can in a minute, but take breaks as needed.") //5
        GlobalVars.exerciseUB.append(newExercise)
        
        newExercise = Exercise(name: "Curls", filename: "curls", tips:
            "Choose a resistance band that allows you to do at least 15 repetitions in one set. \n\n" +
            "Stand up straight with your feet hip width apart. \n\n" +
            "Place the band under your feet and hold the handles down by your sides. \n\n" +
            "Curl your arms up toward your shoulders. Make sure you keep your elbows tucked in at your sides. \n\n" +
            "Return to the starting position in a slow and controlled manner. \n\n" +
            "Do as many as you can in a minute, but take breaks as needed.") // 6
        GlobalVars.exerciseUB.append(newExercise)
        
        newExercise = Exercise(name: "Kick Backs", filename: "tricep-kickbacks", tips:
            "Choose a resistance band that allows you to do at least 15 repetitions in one set per arm. \n\n" +
            "Start with  your weakest arm (if you're righty it's probably your left arm). \n\n" +
            "Place the band under your left foot, take a step backwards with your right foot and hold the handles down by your sides. \n\n" +
            "Place your left hand against your leg and bend your right arm at a 90 degree angle with your tricep parallel with the floor. Make sure you keep your elbow against your body. \n\n" +
            "Kick your right hand back so your arm is straight making sure to focus on using your tricep muscle." +
            "Return to the starting position in a slow and controlled manner. \n\n" +
            "Do as many as you can in 30 seconds, takeing breaks as needed, then switch stances and do the other arm for 30 seconds.") // 7
        GlobalVars.exerciseUB.append(newExercise)
        
        
        // instantiates the Lower Body array data
        newExercise = Exercise(name: "Squats", filename: "squats", tips:
            "Stand with your spine in a straight line, and have your feet a little wider than hip-width apart. \n\n" +
            "Bend at the knees to lower your hips toward the ground and move them backwards, as though you're going to sit in a chair. Your shins should be perpendicular to the floor and your spine should stay straight. Keep your arms out in front of you for balance as needed. \n\n" +
            "If you can't do a full squat by bringing your hips close to the floor, do a half squat or squat down as far as you can until you improve and can go lower. \n\n" +
            "Do as many as you can in 30 seconds, takeing breaks as needed, then switch stances and do the other arm for 30 seconds.") // 0
        GlobalVars.exerciseLB.append(newExercise)
        
        newExercise = Exercise(name: "Crunches", filename: "sit-ups", tips:
            "Lie down with your back flat to the floor.\n\n" +
            "Bend your knees are at a 90-degree angle to your body. It may be easier to rest your feet under a chair to lock them in place. \n\n" +
            "Cross your hands in front of your chest. For more advanced crunches, put your hands behind your head, but with the fingertips lightly touching the head, not clasping the head or neck. \n\n" +
            "Make sure there is a fist's worth of space between your chin and chest. \n\n" +
            "Draw your belly button in to the base of your spine.\n\n" +
            "Sit up until your shoulder blades are lifted off the floor. Be careful to use abdominal rather than back, leg or neck muscles.\n\n" +
            "Exhale as you sit up. Inhale as you lie down.\n\n" +
            "Do as many as you can in a minute, but take breaks as needed.") // 1
        GlobalVars.exerciseLB.append(newExercise)
        
        newExercise = Exercise(name: "Calf Raises", filename: "calf-raises", tips:
            "Stand with your feet should width apart. You can hold the back of a chair for balance if needed. \n\n" +
            "Lift your heels until you're standing on your tippy toes. Distribute most of your weight onto the balls of your feet, and keep your legs straight. \n\n" +
            "Stay on your tippy toes for two seconds. Then, begin to lower your heels, and move your weight away from the balls of your feet until your heels are back on the ground. \n\n" +
            "Do as many as you can in a minute, but take breaks as needed.") // 2
        GlobalVars.exerciseLB.append(newExercise)
        
        newExercise = Exercise(name: "Lunges", filename: "lunges", tips:
            "Stand up straight with your feet about a shoulder width apart.Put your hands on your hips, keep your back as straight as possible, relax your shoulders and keep your eyes facing directly ahead. Engage your core \n\n" +
            "Take a large step forward with one leg. The length of your step will depend on your height, but it will usually be somewhere between 2 or 3 feet (0.6 or 0.9 m). \n\n" +
            "As you step forward, lower your hips and bend your knees until they both form 90 degree angles. Your front knee should not extend over your toes and your back knee should not touch the ground. \n\n" +
            "Pause at the bottom of the lunge for up to 5 seconds. Push off the heel of your front foot to return to the starting position. \n\n" +
            "Alternate legs as you go. \n\n" +
            "Do as many as you can in a minute, but take breaks as needed.") // 3
        GlobalVars.exerciseLB.append(newExercise)
        
        // 2nd set
        newExercise = Exercise(name: "Squats", filename: "squats", tips:
            "Stand with your spine in a straight line, and have your feet a little wider than hip-width apart. \n\n" +
            "Bend at the knees to lower your hips toward the ground and move them backwards, as though you're going to sit in a chair. Your shins should be perpendicular to the floor and your spine should stay straight. Keep your arms out in front of you for balance as needed. \n\n" +
            "If you can't do a full squat by bringing your hips close to the floor, do a half squat or squat down as far as you can until you improve and can go lower. \n\n" +
            "Do as many as you can in 30 seconds, takeing breaks as needed, then switch stances and do the other arm for 30 seconds.") // 4
        GlobalVars.exerciseLB.append(newExercise)
        
        newExercise = Exercise(name: "Leg Lifts", filename: "lower-abs", tips:
            "Lie flat on your back with your legs stretched out in front of you. Your legs should just be a toe's width apart. Make sure to keep your hands down flat on the ground near your sides, with your palms down. \n\n" +
            "Bend your knees and raise your legs. Your calves should be parallel to the ground, while your thighs are perpendicular.[2] You should keep your toes pointed while you do this, drawing your abdominal muscles toward your spine. \n\n" +
            "Continue curling your kneeds towards your chest. Raise your legs as slowly as possible. \n\n" +
            "Slowly lower your legs. Bring them down to about an inch off the floor. Don't just let gravity work for you, make sure you're in control. Hold your arms in the same place, but use them for balance and support as you lower your legs. \n\n" +
            "Do as many as you can in a minute, but take breaks as needed.") //5
        GlobalVars.exerciseLB.append(newExercise)
        
        newExercise = Exercise(name: "Calf Raises", filename: "calf-raises", tips:
            "Stand with your feet should width apart. You can hold the back of a chair for balance if needed. \n\n" +
            "Lift your heels until you're standing on your tippy toes. Distribute most of your weight onto the balls of your feet, and keep your legs straight. \n\n" +
            "Stay on your tippy toes for two seconds. Then, begin to lower your heels, and move your weight away from the balls of your feet until your heels are back on the ground. \n\n" +
            "Do as many as you can in a minute, but take breaks as needed.") // 6
        GlobalVars.exerciseLB.append(newExercise)
        
        newExercise = Exercise(name: "Lunges", filename: "lunges", tips:
            "Stand up straight with your feet about a shoulder width apart.Put your hands on your hips, keep your back as straight as possible, relax your shoulders and keep your eyes facing directly ahead. Engage your core \n\n" +
            "Take a large step forward with one leg. The length of your step will depend on your height, but it will usually be somewhere between 2 or 3 feet (0.6 or 0.9 m). \n\n" +
            "As you step forward, lower your hips and bend your knees until they both form 90 degree angles. Your front knee should not extend over your toes and your back knee should not touch the ground. \n\n" +
            "Pause at the bottom of the lunge for up to 5 seconds. Push off the heel of your front foot to return to the starting position. \n\n" +
            "Alternate legs as you go. \n\n" +
            "Do as many as you can in a minute, but take breaks as needed.") // 7
        GlobalVars.exerciseLB.append(newExercise)

        //------------------------------------ Notification Stuff ----------------------------------------------------//
        let today = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitMonth | .CalendarUnitYear | .CalendarUnitDay, fromDate: today)
        let hour = components.hour
        let minutes = components.minute
        let month = components.month
        let year = components.year
        let day = components.day
        var repeatHour = NSCalendarUnit.CalendarUnitHour
        var repeatDay = NSCalendarUnit.CalendarUnitDay
        var noRepeat = NSCalendarUnit.allZeros
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"segueToWorkoutNow:", name: "workoutNowPressed", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"skippedWorkout:", name: "skipWorkout", object: nil)
        
        var dateComp:NSDateComponents = NSDateComponents()
        dateComp.year = year    // sets to current year
        dateComp.month = month  // sets to current month
        dateComp.day = day      // sets to current day
        dateComp.hour = GlobalVars.workoutNotificationHour    // sets to current hour
        dateComp.minute = 20
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
        notification.repeatInterval = GlobalVars.workoutNotificationRepeater // sets when the notification repeats
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        //------------------------------------ /Notification Stuff ----------------------------------------------------//
    }
    
    //------------------------------------ Notification Functions when button action tapped----------------------------------------------------//
    
    func segueToWorkoutNow(notification:NSNotification){
        var message:UIAlertController = UIAlertController(title: "Workout Now", message: "You hit the Workout Now action", preferredStyle: UIAlertControllerStyle.Alert)
        message.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(message, animated: true, completion: nil)
    }
    
    func skippedWorkout(notification:NSNotification){
        var message:UIAlertController = UIAlertController(title: "Skipped", message: "You skipped this workout", preferredStyle: UIAlertControllerStyle.Alert)
        message.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(message, animated: true, completion: nil)
    }
    //------------------------------------ /Notification Functions ----------------------------------------------------//
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "segueToUBExerciseType"{
            let vc = segue.destinationViewController as OneMWViewController
            vc.navTitle = "Upper Body"
            vc.exerciseTitle = GlobalVars.exerciseUB[GlobalVars.exerciseIndexCount].name
            vc.exerciseImage = UIImage(named: GlobalVars.exerciseUB[GlobalVars.exerciseIndexCount].filename)                
        }else {
            let vc = segue.destinationViewController as OneMWViewController
            vc.navTitle = "Lower Body"
            vc.exerciseTitle = GlobalVars.exerciseLB[GlobalVars.exerciseIndexCount].name
            vc.exerciseImage = UIImage(named: GlobalVars.exerciseLB[GlobalVars.exerciseIndexCount].filename)
        }
    }


}
