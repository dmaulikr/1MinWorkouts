//
//  WorkoutsOptionsViewController.swift
//  1MinWorkouts
//
//  Created by Justin Spirent on 7/17/17.
//  Copyright © 2017 Good Enough LLC. All rights reserved.
//

import UIKit

class WorkoutsOptionsViewController: UIViewController {
    
    let shownTipsSettings = UserDefaults.standard // instantiates a user defaultholder for keeping track of the tips shown or not
    
    @IBOutlet var workoutsTableView: UITableView!
    @IBOutlet var TipWorkoutsView: UIView!
    @IBAction func CloseWorkoutsTipBtn(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {self.TipWorkoutsView.alpha = 0.0})
        shownTipsSettings.set(true, forKey: "WorkoutsStarterTip")
    }

    // creates an array to hold the content for each of the table cells
    //var arrayOfCellData = [cellData]()
    
    override func viewWillAppear(_ animated: Bool) {
        
        TipWorkoutsView.alpha = 0.0
        // checks to see if Tip has been shown yet
        let tipViewed = shownTipsSettings.bool(forKey: "WorkoutsStarterTip")
        if tipViewed == false{
            UIView.animate(withDuration: 0.5, animations: {self.TipWorkoutsView.alpha = 1.0})
            //TipStarterView.isHidden = false
        }else{
            TipWorkoutsView.alpha = 0.0
        }
        
        //enables 1MW tab so user can get back if doing 1MW workouts
        if  let arrayOfTabBarItems = tabBarController?.tabBar.items as AnyObject as? NSArray,let tabBarItem = arrayOfTabBarItems[0] as? UITabBarItem {
            tabBarItem.isEnabled = true
        }
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // sets the navbar background color and font color
        navigationController?.navigationBar.barTintColor = UIColor(red:0.53, green:0.73, blue:0.85, alpha:1.00)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        // creates an invisible footer that hides the empty table dividers
        workoutsTableView.tableFooterView = UIView(frame: .zero)
        
        // defines the content in the array for each of the table cells
        //arrayOfCellData = [cellData(cell : 1, titleText : "Upper Body", nextWorkoutText : "Strength/Cardio - 7 mins", BGImage: #imageLiteral(resourceName: "UpperBody-7mins")),
          //                 cellData(cell : 1, titleText : "Lower Body", nextWorkoutText : "Strength/Cardio - 7 mins", BGImage: #imageLiteral(resourceName: "LowerBody-7mins")),
            //               cellData(cell : 1, titleText : "Core", nextWorkoutText : "Strength/Cardio - 7 mins", BGImage: #imageLiteral(resourceName: "Core")),
              //             cellData(cell : 1, titleText : "7 Minute Workout", nextWorkoutText : "Strength/Cardio", BGImage: #imageLiteral(resourceName: "7MinWorkouts")),
                //           cellData(cell : 1, titleText : "7 Minute Tabata", nextWorkoutText : "Strength/Cardio", BGImage: #imageLiteral(resourceName: "7MinTabata"))]
        
        // sets the table cell index to 0
        GlobalVars.workoutsIndexCount = 0
        
        // instantiates the Upper Body array data -------------------------------------------------------------------------//
        var newExercise = Exercise(name: "Jumping Jacks", filename: "jumping-jacks", meterFilename: "workout-progress-Step1_7",  tips:
            "1. Stand with your feet together and your hands at your sides. \n\n" +
                "2. Jump straight up while simultaneously spreading your legs shoulder width apart and raising your hands over your head. Like you're making a snow angle jumping in the air. \n\n" +
                "3. Land with your legs apart and arms over your head. \n\n" +
                "4. Jump straigt up again, but this time put your feet back together and bring your arms down to your sides following the same arcing path you made when raising them. \n\n" +
            "Do as many as you can, but take breaks as needed.") // 0
        GlobalVars.workoutsUB.append(newExercise)
        
        newExercise = Exercise(name: "Push-Ups", filename: "push-ups", meterFilename: "workout-progress-Step2_7", tips:
            "1. Lie on the floor face down and place your hands just about about shoulder width apart while holding your torso up at arms length. \n\n" +
                "2. Lower yourself down until your chest almost touches the floor as you inhale.\n\n" +
                "3. Press your upper body back up to the starting position, focussing on squeezing your chest while exhaling.\n\n" +
            "Do as many as you can, but take breaks as needed.") // 1
        GlobalVars.workoutsUB.append(newExercise)
        
        newExercise = Exercise(name: "Curls", filename: "curls", meterFilename: "workout-progress-Step3_7", tips:
            "1. Choose a resistance band that allows you to do at least 15 repetitions in one set. \n\n" +
                "2. Stand up straight with your feet hip width apart. \n\n" +
                "3. Place the band under your feet and hold the handles down by your sides. Make sure each side is even. \n\n" +
                "4. Curl your arms up toward your shoulders. Exhale and make sure to keep your elbows tucked in at your sides - don't arch your back. \n\n" +
                "5. Return to the starting position in a slow and controlled manner while you inhale. \n\n" +
            "Do as many as you can, but take breaks as needed.\n\n") // 2
        GlobalVars.workoutsUB.append(newExercise)
        
        newExercise = Exercise(name: "Tricep Dips", filename: "dips", meterFilename: "workout-progress-Step4_7", tips:
            "1. Position your hands shoulder-width apart on a secured table/desk or stable chair. \n\n" +
                "2. Slide your butt off the front of the chair with your legs extended out in front of you. \n\n" +
                "3. Straighten your arms, keeping a little bend in your elbows to keep tension on your triceps and off your elbow joints. \n\n" +
                "4. Slowly bend your elbows to lower your body toward the floor until your elbows are at about a 90-degree angle. Be sure to keep your back close to the chairs seat. \n\n" +
                "5. Once you reach the bottom of the movement, press down into the chair to straighten your elbows, returning to the starting position. This completes one rep. \n\n" +
                "6. Keep your shoulders down as you lower and raise your body. You can bend your legs to modify this exercise. \n\n" +
            "Do as many as you can, takeing breaks as needed.") // 3
        GlobalVars.workoutsUB.append(newExercise)
        
        newExercise = Exercise(name: "Wide Push-Ups", filename: "push-ups-wide", meterFilename: "workout-progress-Step5_7", tips:
            "1. Lie on the floor face down and place your hands about a shoulder and half width apart (your elbows should be at 90 degree angles and parallel with the floor when in the down position) while holding your torso up at arms length. \n\n" +
                "2. Lower yourself down until your chest almost touches the floor as you inhale.\n\n" +
                "3. Press your upper body back up to the starting position, focussing on squeezing your chest while exhaling.\n\n" +
            "Do as many as you can, but take breaks as needed.") // 4
        GlobalVars.workoutsUB.append(newExercise)
        
        newExercise = Exercise(name: "Curls", filename: "curls", meterFilename: "workout-progress-Step6_7", tips:
            "1. Choose a resistance band that allows you to do at least 15 repetitions in one set. \n\n" +
                "2. Stand up straight with your feet hip width apart. \n\n" +
                "3. Place the band under your feet and hold the handles down by your sides. Make sure each side is even. \n\n" +
                "4. Curl your arms up toward your shoulders. Exhale and make sure to keep your elbows tucked in at your sides - don't arch your back. \n\n" +
                "5. Return to the starting position in a slow and controlled manner while you inhale. \n\n" +
            "Do as many as you can, but take breaks as needed.\n\n") // 5
        GlobalVars.workoutsUB.append(newExercise)
        
        
        newExercise = Exercise(name: "Tricep Dips", filename: "dips", meterFilename: "workout-progress-Step7_7", tips:
            "1. Position your hands shoulder-width apart on a secured table/desk or stable chair. \n\n" +
                "2. Slide your butt off the front of the chair with your legs extended out in front of you. \n\n" +
                "3. Straighten your arms, keeping a little bend in your elbows to keep tension on your triceps and off your elbow joints. \n\n" +
                "4. Slowly bend your elbows to lower your body toward the floor until your elbows are at about a 90-degree angle. Be sure to keep your back close to the chairs seat. \n\n" +
                "5. Once you reach the bottom of the movement, press down into the chair to straighten your elbows, returning to the starting position. This completes one rep. \n\n" +
                "6. Keep your shoulders down as you lower and raise your body. You can bend your legs to modify this exercise. \n\n" +
            "Do as many as you can, takeing breaks as needed.")  // 6
        GlobalVars.workoutsUB.append(newExercise)
        
        
        // instantiates the Lower Body array data -------------------------------------------------------------------------//
        newExercise = Exercise(name: "Jumping Jacks", filename: "jumping-jacks", meterFilename: "workout-progress-Step1_7", tips:
            "1. Stand with your feet together and your hands at your sides. \n\n" +
                "2. Jump straight up while simultaneously spreading your legs shoulder width apart and raising your hands over your head. Like you're making a snow angle jumping in the air. \n\n" +
                "3. Land with your legs apart and arms over your head. \n\n" +
                "4. Jump straigt up again, but this time put your feet back together and bring your arms down to your sides following the same arcing path you made when raising them. \n\n" +
            "Do as many as you can, but take breaks as needed.") // 0
        GlobalVars.workoutsLB.append(newExercise)
        
        newExercise = Exercise(name: "Squats", filename: "squats", meterFilename: "workout-progress-Step2_7", tips:
            "1. Stand with your spine in a straight line, and have your feet a little wider than hip-width apart. \n\n" +
                "2. Bend at the knees to lower your hips toward the ground and move them backwards, as though you're going to sit in a chair. Your shins should be perpendicular to the floor and your spine should stay straight. Keep your arms out in front of you for balance as needed while you inhale. \n\n" +
                "3. Straighten your legs back to the starting position while you exhale \n\n" +
                "If you can't do a full squat by bringing your hips close to the floor, do a half squat or squat down as far as you can until you improve and can go lower. \n\n" +
            "Do as many as you can, takeing breaks as needed.") // 1
        GlobalVars.workoutsLB.append(newExercise)
        
        newExercise = Exercise(name: "Lunges", filename: "lunges", meterFilename: "workout-progress-Step3_7", tips:
            "1. Stand up straight with your feet about a shoulder width apart. Put your hands on your hips, keep your back as straight as possible, relax your shoulders and keep your eyes facing directly ahead. \n\n" +
                "2. Take a large step forward with one leg. The length of your step will depend on your height, but it will usually be somewhere between 2 or 3 feet (0.6 or 0.9 m). \n\n" +
                "3. As you step forward, lower your hips and bend your knees until they both form 90 degree angles while inhaling. Your front knee should not extend over your toes and your back knee should not touch the ground. \n\n" +
                "4. Pause at the bottom of the lunge for a second then push off the heel of your front foot to return to the starting position while exhaling. \n\n" +
                "Alternate legs as you go. \n\n" +
            "Do as many as you can, but take breaks as needed.") // 2
        GlobalVars.workoutsLB.append(newExercise)
        
        newExercise = Exercise(name: "Calf Raises", filename: "calf-raises", meterFilename: "workout-progress-Step4_7", tips:
            "1. Stand with your feet shoulder width apart. You can hold the back of a chair for balance if needed. \n\n" +
                "2. Lift your heels until you're standing on your tip toes while exhaling. Distribute most of your weight onto the balls of your feet, and keep your legs straight. \n\n" +
                "3. Stay on your tip toes for two seconds. Then, begin to lower your heels, and move your weight away from the balls of your feet until your heels are back on the ground while inhaling. \n\n" +
            "Do as many as you can, but take breaks as needed.") // 3
        GlobalVars.workoutsLB.append(newExercise)
        
        newExercise = Exercise(name: "Squats", filename: "squats", meterFilename: "workout-progress-Step5_7", tips:
            "1. Stand with your spine in a straight line, and have your feet a little wider than hip-width apart. \n\n" +
                "2. Bend at the knees to lower your hips toward the ground and move them backwards, as though you're going to sit in a chair. Your shins should be perpendicular to the floor and your spine should stay straight. Keep your arms out in front of you for balance as needed while you inhale. \n\n" +
                "3. Straighten your legs back to the starting position while you exhale \n\n" +
                "If you can't do a full squat by bringing your hips close to the floor, do a half squat or squat down as far as you can until you improve and can go lower. \n\n" +
            "Do as many as you can, takeing breaks as needed.") // 4
        GlobalVars.workoutsLB.append(newExercise)
        
        newExercise = Exercise(name: "Lunges", filename: "lunges", meterFilename: "workout-progress-Step6_7", tips:
            "1. Stand up straight with your feet about a shoulder width apart. Put your hands on your hips, keep your back as straight as possible, relax your shoulders and keep your eyes facing directly ahead. \n\n" +
                "2. Take a large step forward with one leg. The length of your step will depend on your height, but it will usually be somewhere between 2 or 3 feet (0.6 or 0.9 m). \n\n" +
                "3. As you step forward, lower your hips and bend your knees until they both form 90 degree angles while inhaling. Your front knee should not extend over your toes and your back knee should not touch the ground. \n\n" +
                "4. Pause at the bottom of the lunge for a second then push off the heel of your front foot to return to the starting position while exhaling. \n\n" +
                "Alternate legs as you go. \n\n" +
            "Do as many as you can, but take breaks as needed.") // 6
        GlobalVars.workoutsLB.append(newExercise)
        
        newExercise = Exercise(name: "Calf Raises", filename: "calf-raises", meterFilename: "workout-progress-Step7_7", tips:
            "1. Stand with your feet shoulder width apart. You can hold the back of a chair for balance if needed. \n\n" +
                "2. Lift your heels until you're standing on your tip toes while exhaling. Distribute most of your weight onto the balls of your feet, and keep your legs straight. \n\n" +
                "3. Stay on your tip toes for two seconds. Then, begin to lower your heels, and move your weight away from the balls of your feet until your heels are back on the ground while inhaling. \n\n" +
            "Do as many as you can, but take breaks as needed.") // 7
        GlobalVars.workoutsLB.append(newExercise)
        
        
        // instantiates the Core array data -------------------------------------------------------------------------//
        newExercise = Exercise(name: "Crunches", filename: "sit-ups", meterFilename: "workout-progress-Step1_7", tips:
            "1. Lie down with your back flat to the floor. \n\n" +
                "2. Bend your knees at a 90-degree angle to your body. It may be easier to rest your feet under a chair to lock them in place. \n\n" +
                "3. Cross your hands in front of your chest. Make sure there is a fist's worth of space between your chin and chest. \n\n" +
                "4. Draw your belly button in to the base of your spine while you sit up. Your shoulder blades should just lift off the floor. \n\n" +
                "Exhale as you sit up. Inhale as you lie down. \n\n" +
                "Do as many as you can, but take breaks as needed. \n\n" +
            "") //0
        GlobalVars.workoutsCore.append(newExercise)
        
        newExercise = Exercise(name: "Side Plank", filename: "side-plank-right", meterFilename: "workout-progress-Step2_7", tips:
            "1. Lie on your side with your legs straight and your body in a straight line (shoulders and hips stacked one on top of the other; don’t lean forward or backwards).\n\n" +
                "2. Prop your body up so your hips are off the floor. Rest your weight on the elbow that’s touching the floor.\n\n" +
                "3. Only your forearm and feet should touch the floor.\n\n" +
                "4. Do not let your hips sag (this is the challenging part of this move). As you get tired, you’ll want to drop your hips, but focus on keeping them stationary. \n\n" +
            "Hold for 30 seconds then switch sides for the remainder of the minute, but take breaks as needed.")
        GlobalVars.workoutsCore.append(newExercise) //1
        
        newExercise = Exercise(name: "Leg Lifts", filename: "lower-abs", meterFilename: "workout-progress-Step3_7", tips:
            "1. Lie flat on your back with your legs stretched out in front of you. Your legs should just be a toe's width apart. Make sure to keep your hands down flat on the ground near your sides, with your palms down. \n\n" +
                "2. Bend your knees and raise your legs. Your calves should be parallel to the ground, while your thighs are perpendicular. You should keep your toes pointed while you do this, drawing your abdominal muscles toward your spine. \n\n" +
                "3. Continue curling your knees towards your chest. Raise your legs as slowly as possible while exhaling. \n\n" +
                "4. Slowly lower your legs. Bring them down to about an inch off the floor. Don't just let gravity work for you, make sure you're in control. Hold your arms in the same place, but use them for balance and support as you lower your legs. \n\n" +
            "Do as many as you can, but take breaks as needed.")
        GlobalVars.workoutsCore.append(newExercise) //2
        
        newExercise = Exercise(name: "Plank", filename: "plank", meterFilename: "workout-progress-Step4_7", tips:
            "1. Lie on your stomach, flat on the floor. Push up onto your forearms.\n\n" +
                "2. Bend your elbows and rest your weight on your forearms.\n\n" +
                "3. Keep your elbows under your shoulders.\n\n" +
                "4. Pull your belly button towards your spine.\n\n" +
                "5. Your body should form a flat line. Don’t let your hips sag, and don’t push your butt up—keep your body in a straight line.\n\n" +
                "6. You can do this plank on your hands instead of your elbows if you prefer (if you feel any pain or stiffness in your wrists, balance your weight on your elbows instead).\n\n" +
            "Hold this position for as long as you can, but take breaks as needed.")
        GlobalVars.workoutsCore.append(newExercise) //3
        
        newExercise = Exercise(name: "Crunches", filename: "sit-ups", meterFilename: "workout-progress-Step5_7", tips:
            "1. Lie down with your back flat to the floor. \n\n" +
                "2. Bend your knees at a 90-degree angle to your body. It may be easier to rest your feet under a chair to lock them in place. \n\n" +
                "3. Cross your hands in front of your chest. Make sure there is a fist's worth of space between your chin and chest. \n\n" +
                "4. Draw your belly button in to the base of your spine while you sit up. Your shoulder blades should just lift off the floor. \n\n" +
                "Exhale as you sit up. Inhale as you lie down. \n\n" +
                "Do as many as you, but take breaks as needed. \n\n" +
            "") //4
        GlobalVars.workoutsCore.append(newExercise)
        
        newExercise = Exercise(name: "Side Plank", filename: "side-plank-right", meterFilename: "workout-progress-Step6_7", tips:
            "1. Lie on your side with your legs straight and your body in a straight line (shoulders and hips stacked one on top of the other; don’t lean forward or backwards).\n\n" +
                "2. Prop your body up so your hips are off the floor. Rest your weight on the elbow that’s touching the floor.\n\n" +
                "3. Only your forearm and feet should touch the floor.\n\n" +
                "4. Do not let your hips sag (this is the challenging part of this move). As you get tired, you’ll want to drop your hips, but focus on keeping them stationary. \n\n" +
            "Hold for 30 seconds then switch sides for the remainder of the minute, but take breaks as needed.")
        GlobalVars.workoutsCore.append(newExercise) //5
        
        newExercise = Exercise(name: "Leg Lifts", filename: "lower-abs", meterFilename: "workout-progress-Step7_7", tips:
            "1. Lie flat on your back with your legs stretched out in front of you. Your legs should just be a toe's width apart. Make sure to keep your hands down flat on the ground near your sides, with your palms down. \n\n" +
                "2. Bend your knees and raise your legs. Your calves should be parallel to the ground, while your thighs are perpendicular. You should keep your toes pointed while you do this, drawing your abdominal muscles toward your spine. \n\n" +
                "3. Continue curling your knees towards your chest. Raise your legs as slowly as possible while exhaling. \n\n" +
                "4. Slowly lower your legs. Bring them down to about an inch off the floor. Don't just let gravity work for you, make sure you're in control. Hold your arms in the same place, but use them for balance and support as you lower your legs. \n\n" +
            "Do as many as you can, but take breaks as needed.")
        GlobalVars.workoutsCore.append(newExercise) //6
        
        
        // instantiates the 7 Min Workout array data -------------------------------------------------------------------------//
        newExercise = Exercise(name: "Jumping Jacks", filename: "jumping-jacks", meterFilename: "workout-progress-Step1_12", tips:
            "1. Stand with your feet together and your hands at your sides. \n\n" +
                "2. Jump straight up while simultaneously spreading your legs shoulder width apart and raising your hands over your head. Like you're making a snow angle jumping in the air. \n\n" +
                "3. Land with your legs apart and arms over your head. \n\n" +
                "4. Jump straigt up again, but this time put your feet back together and bring your arms down to your sides following the same arcing path you made when raising them. \n\n" +
            "Do as many as you can, but take breaks as needed.")
        GlobalVars.workouts7M.append(newExercise)
        
        newExercise = Exercise(name: "Wall Sit", filename: "wall_sit", meterFilename: "workout-progress-Step2_12", tips:
            "1. Start by standing about 2 feet away from a wall with your back against the wall. \n\n" +
                "2. Slide your back down the wall until your hips and knees bend at a 90 degrees angle. \n\n" +
                "3. Keep the shoulders, upper back and the back of the head against the wall. \n\n" +
                "4. Both feet should be flat on the ground with the weight evenly distributed. \n\n" +
            "5. Hold for the required amount of time.")
        GlobalVars.workouts7M.append(newExercise)
        
        newExercise = Exercise(name: "Push-Ups", filename: "push-ups", meterFilename: "workout-progress-Step3_12", tips:
            "1. Lie on the floor face down and place your hands just about about shoulder width apart while holding your torso up at arms length. \n\n" +
                "2. Lower yourself down until your chest almost touches the floor as you inhale.\n\n" +
                "3. Press your upper body back up to the starting position, focussing on squeezing your chest while exhaling.\n\n" +
            "Do as many as you can, but take breaks as needed.")
        GlobalVars.workouts7M.append(newExercise)
        
        newExercise = Exercise(name: "Plank", filename: "plank", meterFilename: "workout-progress-Step4_12", tips:
            "1. Lie on your stomach, flat on the floor. Push up onto your forearms.\n\n" +
                "2. Bend your elbows and rest your weight on your forearms.\n\n" +
                "3. Keep your elbows under your shoulders.\n\n" +
                "4. Pull your belly button towards your spine.\n\n" +
                "5. Your body should form a flat line. Don’t let your hips sag, and don’t push your butt up—keep your body in a straight line.\n\n" +
                "6. You can do this plank on your hands instead of your elbows if you prefer (if you feel any pain or stiffness in your wrists, balance your weight on your elbows instead).\n\n" +
            "Hold this position for as long as you can, but take breaks as needed.")
        GlobalVars.workouts7M.append(newExercise)
        
        newExercise = Exercise(name: "Chair Step Ups", filename: "chair-step-ups", meterFilename: "workout-progress-Step5_12", tips:
            "1. Stand with your spine in a straight line, and have your feet a little wider than hip-width apart. \n\n" +
                "2. Bend at the knees to lower your hips toward the ground and move them backwards, as though you're going to sit in a chair. Your shins should be perpendicular to the floor and your spine should stay straight. Keep your arms out in front of you for balance as needed while you inhale. \n\n" +
                "3. Straighten your legs back to the starting position while you exhale \n\n" +
                "If you can't do a full squat by bringing your hips close to the floor, do a half squat or squat down as far as you can until you improve and can go lower. \n\n" +
            "Do as many as you can, takeing breaks as needed.")
        GlobalVars.workouts7M.append(newExercise)
        
        newExercise = Exercise(name: "Squats", filename: "squats", meterFilename: "workout-progress-Step6_12", tips:
            "1. Stand with your spine in a straight line, and have your feet a little wider than hip-width apart. \n\n" +
                "2. Bend at the knees to lower your hips toward the ground and move them backwards, as though you're going to sit in a chair. Your shins should be perpendicular to the floor and your spine should stay straight. Keep your arms out in front of you for balance as needed while you inhale. \n\n" +
                "3. Straighten your legs back to the starting position while you exhale \n\n" +
                "If you can't do a full squat by bringing your hips close to the floor, do a half squat or squat down as far as you can until you improve and can go lower. \n\n" +
            "Do as many as you can, takeing breaks as needed.")
        GlobalVars.workouts7M.append(newExercise)
        
        newExercise = Exercise(name: "Tricep Dips", filename: "dips", meterFilename: "workout-progress-Step7_12", tips:
            "1. Position your hands shoulder-width apart on a secured table/desk or stable chair. \n\n" +
                "2. Slide your butt off the front of the chair with your legs extended out in front of you. \n\n" +
                "3. Straighten your arms, keeping a little bend in your elbows to keep tension on your triceps and off your elbow joints. \n\n" +
                "4. Slowly bend your elbows to lower your body toward the floor until your elbows are at about a 90-degree angle. Be sure to keep your back close to the chairs seat. \n\n" +
                "5. Once you reach the bottom of the movement, press down into the chair to straighten your elbows, returning to the starting position. This completes one rep. \n\n" +
                "6. Keep your shoulders down as you lower and raise your body. You can bend your legs to modify this exercise. \n\n" +
            "Do as many as you can, takeing breaks as needed.")
        GlobalVars.workouts7M.append(newExercise)
        
        newExercise = Exercise(name: "Plank", filename: "plank", meterFilename: "workout-progress-Step8_12", tips:
            "1. Lie on your stomach, flat on the floor. Push up onto your forearms.\n\n" +
                "2. Bend your elbows and rest your weight on your forearms.\n\n" +
                "3. Keep your elbows under your shoulders.\n\n" +
                "4. Pull your belly button towards your spine.\n\n" +
                "5. Your body should form a flat line. Don’t let your hips sag, and don’t push your butt up—keep your body in a straight line.\n\n" +
                "6. You can do this plank on your hands instead of your elbows if you prefer (if you feel any pain or stiffness in your wrists, balance your weight on your elbows instead).\n\n" +
            "Hold this position for as long as you can, but take breaks as needed.")
        GlobalVars.workouts7M.append(newExercise)
        
        newExercise = Exercise(name: "High Knees/Run In Place", filename: "high-knees", meterFilename: "workout-progress- Step9_12", tips:
            "1. Stand in place with your feet hip-width apart. /n/n" +
                "2. Drive your right knee toward your chest and quickly place it back on the ground. /n/n" +
                "3. Follow immediately by driving your left knee toward your chest. /n/n" +
            "Continue to alternate knees as quickly as you can. Take breaks as needed.")
        GlobalVars.workouts7M.append(newExercise)
        
        newExercise = Exercise(name: "Lunges", filename: "lunges", meterFilename: "workout-progress-Step10_12", tips:
            "1. Stand up straight with your feet about a shoulder width apart. Put your hands on your hips, keep your back as straight as possible, relax your shoulders and keep your eyes facing directly ahead. \n\n" +
                "2. Take a large step forward with one leg. The length of your step will depend on your height, but it will usually be somewhere between 2 or 3 feet (0.6 or 0.9 m). \n\n" +
                "3. As you step forward, lower your hips and bend your knees until they both form 90 degree angles while inhaling. Your front knee should not extend over your toes and your back knee should not touch the ground. \n\n" +
                "4. Pause at the bottom of the lunge for a second then push off the heel of your front foot to return to the starting position while exhaling. \n\n" +
                "Alternate legs as you go. \n\n" +
            "Do as many as you can, but take breaks as needed.")
        GlobalVars.workouts7M.append(newExercise)
        
        newExercise = Exercise(name: "Rotation Push-Ups", filename: "push-ups-rotation", meterFilename: "workout-progress-Step11_12", tips:
            "1. Lie on the floor face down and place your hands just about about shoulder width apart while holding your torso up at arms length. \n\n" +
                "2. Lower yourself down until your chest almost touches the floor as you inhale.\n\n" +
                "3. Press your upper body back up to the starting position, focussing on squeezing your chest while exhaling. At the top of the push-up, rotate your upper body and extend your right arm upwards. Return to starting position and repeat. Alternate sides as you go. \n\n" +
            "Do as many as you can, but take breaks as needed.")
        GlobalVars.workouts7M.append(newExercise)
        
        newExercise = Exercise(name: "Side Plank", filename: "side-plank-right", meterFilename: "workout-progress-Step12_12", tips:
            "1. Lie on your side with your legs straight and your body in a straight line (shoulders and hips stacked one on top of the other; don’t lean forward or backwards).\n\n" +
                "2. Prop your body up so your hips are off the floor. Rest your weight on the elbow that’s touching the floor.\n\n" +
                "3. Only your forearm and feet should touch the floor.\n\n" +
                "4. Do not let your hips sag (this is the challenging part of this move). As you get tired, you’ll want to drop your hips, but focus on keeping them stationary. \n\n" +
            "Hold for 15 seconds then switch sides for the remainder of the time, but take breaks as needed.") //1
        GlobalVars.workouts7M.append(newExercise)
        
        
        // instantiates the 7 Min Tabata array data -------------------------------------------------------------------------//
        newExercise = Exercise(name: "Jumping Jacks", filename: "jumping-jacks", meterFilename: "workout-progress-Step1_14", tips:
            "1. Stand with your feet together and your hands at your sides. \n\n" +
                "2. Jump straight up while simultaneously spreading your legs shoulder width apart and raising your hands over your head. Like you're making a snow angle jumping in the air. \n\n" +
                "3. Land with your legs apart and arms over your head. \n\n" +
                "4. Jump straigt up again, but this time put your feet back together and bring your arms down to your sides following the same arcing path you made when raising them. \n\n" +
            "Do as many as you can, but take breaks as needed.")
        GlobalVars.workouts7T.append(newExercise) // 0
        
        newExercise = Exercise(name: "Squats", filename: "squats", meterFilename: "workout-progress-Step2_14", tips:
            "1. Stand with your spine in a straight line, and have your feet a little wider than hip-width apart. \n\n" +
                "2. Bend at the knees to lower your hips toward the ground and move them backwards, as though you're going to sit in a chair. Your shins should be perpendicular to the floor and your spine should stay straight. Keep your arms out in front of you for balance as needed while you inhale. \n\n" +
                "3. Straighten your legs back to the starting position while you exhale \n\n" +
                "If you can't do a full squat by bringing your hips close to the floor, do a half squat or squat down as far as you can until you improve and can go lower. \n\n" +
            "Do as many as you can, takeing breaks as needed.")
        GlobalVars.workouts7T.append(newExercise) // 1
        
        newExercise = Exercise(name: "Push-Ups", filename: "push-ups", meterFilename: "workout-progress-Step3_14", tips:
            "1. Lie on the floor face down and place your hands just about about shoulder width apart while holding your torso up at arms length. \n\n" +
                "2. Lower yourself down until your chest almost touches the floor as you inhale.\n\n" +
                "3. Press your upper body back up to the starting position, focussing on squeezing your chest while exhaling.\n\n" +
            "Do as many as you can, but take breaks as needed.")
        GlobalVars.workouts7T.append(newExercise) // 2
        
        newExercise = Exercise(name: "Lunges", filename: "lunges", meterFilename: "workout-progress-Step4_14", tips:
            "1. Stand up straight with your feet about a shoulder width apart. Put your hands on your hips, keep your back as straight as possible, relax your shoulders and keep your eyes facing directly ahead. \n\n" +
                "2. Take a large step forward with one leg. The length of your step will depend on your height, but it will usually be somewhere between 2 or 3 feet (0.6 or 0.9 m). \n\n" +
                "3. As you step forward, lower your hips and bend your knees until they both form 90 degree angles while inhaling. Your front knee should not extend over your toes and your back knee should not touch the ground. \n\n" +
                "4. Pause at the bottom of the lunge for a second then push off the heel of your front foot to return to the starting position while exhaling. \n\n" +
                "Alternate legs as you go. \n\n" +
            "Do as many as you can, but take breaks as needed.")
        GlobalVars.workouts7T.append(newExercise) // 3
        
        newExercise = Exercise(name: "Crunches", filename: "sit-ups", meterFilename: "workout-progress-Step5_14", tips:
            "1. Lie down with your back flat to the floor. \n\n" +
                "2. Bend your knees at a 90-degree angle to your body. It may be easier to rest your feet under a chair to lock them in place. \n\n" +
                "3. Cross your hands in front of your chest. Make sure there is a fist's worth of space between your chin and chest. \n\n" +
                "4. Draw your belly button in to the base of your spine while you sit up. Your shoulder blades should just lift off the floor. \n\n" +
                "Exhale as you sit up. Inhale as you lie down. \n\n" +
                "Do as many as you can, but take breaks as needed. \n\n" +
            "")
        GlobalVars.workouts7T.append(newExercise) // 4
        
        newExercise = Exercise(name: "Plank", filename: "plank", meterFilename: "workout-progress-Step6_14", tips:
            "1. Lie on your stomach, flat on the floor. Push up onto your forearms.\n\n" +
                "2. Bend your elbows and rest your weight on your forearms.\n\n" +
                "3. Keep your elbows under your shoulders.\n\n" +
                "4. Pull your belly button towards your spine.\n\n" +
                "5. Your body should form a flat line. Don’t let your hips sag, and don’t push your butt up—keep your body in a straight line.\n\n" +
                "6. You can do this plank on your hands instead of your elbows if you prefer (if you feel any pain or stiffness in your wrists, balance your weight on your elbows instead).\n\n" +
            "Hold this position for as long as you can, but take breaks as needed.")
        GlobalVars.workouts7T.append(newExercise) //5
        
        newExercise = Exercise(name: "Curls", filename: "curls", meterFilename: "workout-progress-Step7_14", tips:
            "1. Choose a resistance band that allows you to do at least 15 repetitions in one set. \n\n" +
                "2. Stand up straight with your feet hip width apart. \n\n" +
                "3. Place the band under your feet and hold the handles down by your sides. Make sure each side is even. \n\n" +
                "4. Curl your arms up toward your shoulders. Exhale and make sure to keep your elbows tucked in at your sides - don't arch your back. \n\n" +
                "5. Return to the starting position in a slow and controlled manner while you inhale. \n\n" +
            "Do as many as you can, but take breaks as needed.\n\n")
        GlobalVars.workouts7T.append(newExercise) //6
        
        newExercise = Exercise(name: "Jumping Jacks", filename: "jumping-jacks", meterFilename: "workout-progress-Step8_14", tips:
            "1. Stand with your feet together and your hands at your sides. \n\n" +
                "2. Jump straight up while simultaneously spreading your legs shoulder width apart and raising your hands over your head. Like you're making a snow angle jumping in the air. \n\n" +
                "3. Land with your legs apart and arms over your head. \n\n" +
                "4. Jump straigt up again, but this time put your feet back together and bring your arms down to your sides following the same arcing path you made when raising them. \n\n" +
            "Do as many as you can, but take breaks as needed.")
        GlobalVars.workouts7T.append(newExercise) // 7
        
        newExercise = Exercise(name: "Squats", filename: "squats", meterFilename: "workout-progress-Step9_14", tips:
            "1. Stand with your spine in a straight line, and have your feet a little wider than hip-width apart. \n\n" +
                "2. Bend at the knees to lower your hips toward the ground and move them backwards, as though you're going to sit in a chair. Your shins should be perpendicular to the floor and your spine should stay straight. Keep your arms out in front of you for balance as needed while you inhale. \n\n" +
                "3. Straighten your legs back to the starting position while you exhale \n\n" +
                "If you can't do a full squat by bringing your hips close to the floor, do a half squat or squat down as far as you can until you improve and can go lower. \n\n" +
            "Do as many as you can, takeing breaks as needed.")
        GlobalVars.workouts7T.append(newExercise) // 8
        
        newExercise = Exercise(name: "Push-Ups", filename: "push-ups", meterFilename: "workout-progress-Step10_14", tips:
            "1. Lie on the floor face down and place your hands just about about shoulder width apart while holding your torso up at arms length. \n\n" +
                "2. Lower yourself down until your chest almost touches the floor as you inhale.\n\n" +
                "3. Press your upper body back up to the starting position, focussing on squeezing your chest while exhaling.\n\n" +
            "Do as many as you can, but take breaks as needed.")
        GlobalVars.workouts7T.append(newExercise) // 9
        
        newExercise = Exercise(name: "Lunges", filename: "lunges", meterFilename: "workout-progress-Step11_14", tips:
            "1. Stand up straight with your feet about a shoulder width apart. Put your hands on your hips, keep your back as straight as possible, relax your shoulders and keep your eyes facing directly ahead. \n\n" +
                "2. Take a large step forward with one leg. The length of your step will depend on your height, but it will usually be somewhere between 2 or 3 feet (0.6 or 0.9 m). \n\n" +
                "3. As you step forward, lower your hips and bend your knees until they both form 90 degree angles while inhaling. Your front knee should not extend over your toes and your back knee should not touch the ground. \n\n" +
                "4. Pause at the bottom of the lunge for a second then push off the heel of your front foot to return to the starting position while exhaling. \n\n" +
                "Alternate legs as you go. \n\n" +
            "Do as many as you can, but take breaks as needed.")
        GlobalVars.workouts7T.append(newExercise) // 10
        
        newExercise = Exercise(name: "Crunches", filename: "sit-ups", meterFilename: "workout-progress-Step12_14", tips:
            "1. Lie down with your back flat to the floor. \n\n" +
                "2. Bend your knees at a 90-degree angle to your body. It may be easier to rest your feet under a chair to lock them in place. \n\n" +
                "3. Cross your hands in front of your chest. Make sure there is a fist's worth of space between your chin and chest. \n\n" +
                "4. Draw your belly button in to the base of your spine while you sit up. Your shoulder blades should just lift off the floor. \n\n" +
                "Exhale as you sit up. Inhale as you lie down. \n\n" +
                "Do as many as you can, but take breaks as needed. \n\n" +
            "")
        GlobalVars.workouts7T.append(newExercise) // 11
        
        newExercise = Exercise(name: "Plank", filename: "plank", meterFilename: "workout-progress-Step13_14", tips:
            "1. Lie on your stomach, flat on the floor. Push up onto your forearms.\n\n" +
                "2. Bend your elbows and rest your weight on your forearms.\n\n" +
                "3. Keep your elbows under your shoulders.\n\n" +
                "4. Pull your belly button towards your spine.\n\n" +
                "5. Your body should form a flat line. Don’t let your hips sag, and don’t push your butt up—keep your body in a straight line.\n\n" +
                "6. You can do this plank on your hands instead of your elbows if you prefer (if you feel any pain or stiffness in your wrists, balance your weight on your elbows instead).\n\n" +
            "Hold this position for as long as you can, but take breaks as needed.")
        GlobalVars.workouts7T.append(newExercise) // 12
        
        newExercise = Exercise(name: "Curls", filename: "curls", meterFilename: "workout-progress-Step14_14", tips:
            "1. Choose a resistance band that allows you to do at least 15 repetitions in one set. \n\n" +
                "2. Stand up straight with your feet hip width apart. \n\n" +
                "3. Place the band under your feet and hold the handles down by your sides. Make sure each side is even. \n\n" +
                "4. Curl your arms up toward your shoulders. Exhale and make sure to keep your elbows tucked in at your sides - don't arch your back. \n\n" +
                "5. Return to the starting position in a slow and controlled manner while you inhale. \n\n" +
            "Do as many as you can, but take breaks as needed.\n\n")
        GlobalVars.workouts7T.append(newExercise) // 13
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "img1MWUBSegue"{
            let vc = segue.destination as! WorkoutsViewController
            vc.navTitle = "1MW Upper Body"
            vc.exerciseTitle = GlobalVars.workoutsUB[GlobalVars.workoutsIndexCount].name
            vc.exerciseImage = UIImage(named: GlobalVars.workoutsUB[GlobalVars.workoutsIndexCount].filename)
            vc.meterImage = UIImage(named: GlobalVars.workoutsUB[GlobalVars.workoutsIndexCount].meterFilename)
            print("1MW UB Segue")
        }
                
        if segue.identifier == "img1MWLBSegue"{
            let vc = segue.destination as! WorkoutsViewController
            vc.navTitle = "1MW Lower Body"
            vc.exerciseTitle = GlobalVars.workoutsLB[GlobalVars.workoutsIndexCount].name
            vc.exerciseImage = UIImage(named: GlobalVars.workoutsLB[GlobalVars.workoutsIndexCount].filename)
            vc.meterImage = UIImage(named: GlobalVars.workoutsUB[GlobalVars.workoutsIndexCount].meterFilename)
                    
            print("1MW LB Segue")
        }
                
        if segue.identifier == "img1MWCSegue"{
            let vc = segue.destination as! WorkoutsViewController
            vc.navTitle = "1MW Core"
            vc.exerciseTitle = GlobalVars.workoutsCore[GlobalVars.workoutsIndexCount].name
            vc.exerciseImage = UIImage(named: GlobalVars.workoutsCore[GlobalVars.workoutsIndexCount].filename)
            vc.meterImage = UIImage(named: GlobalVars.workoutsCore[GlobalVars.workoutsIndexCount].meterFilename)
                    
            print("1MW Core")
        }
                
        if segue.identifier == "wb7MWSegue"{
            let vc = segue.destination as! WorkoutsViewController
            vc.navTitle = "7 Minute Workout"
            vc.exerciseTitle = GlobalVars.workouts7M[GlobalVars.workoutsIndexCount].name
            vc.exerciseImage = UIImage(named: GlobalVars.workouts7M[GlobalVars.workoutsIndexCount].filename)
            vc.meterImage = UIImage(named: GlobalVars.workouts7M[GlobalVars.workoutsIndexCount].meterFilename)
                    
            print("7M Segue")
        }
                
        if segue.identifier == "wb7MTSegue"{
            let vc = segue.destination as! WorkoutsViewController
            vc.navTitle = "7 Minute Tabata"
            vc.exerciseTitle = GlobalVars.workouts7T[GlobalVars.workoutsIndexCount].name
            vc.exerciseImage = UIImage(named: GlobalVars.workouts7T[GlobalVars.workoutsIndexCount].filename)
            vc.meterImage = UIImage(named: GlobalVars.workouts7T[GlobalVars.workoutsIndexCount].meterFilename)
                    
            print("7T Segue")
        }
    }

}
