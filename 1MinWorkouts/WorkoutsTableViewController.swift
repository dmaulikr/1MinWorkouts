//
//  WorkoutsTableViewController.swift
//  1MinWorkouts
//
//  Created by Justin Spirent on 1/12/17.
//  Copyright © 2017 Good Enough LLC. All rights reserved.
//

import UIKit

class WorkoutsTableViewController: UITableViewController {
    
    // defines the data structure for the content of each table cell
    struct cellData {
        let cell : Int!
        let titleText : String!
        let nextWorkoutText : String!
        let BGImage : UIImage!
    }
    
    // creates an array to hold the content for each of the table cells
    var arrayOfCellData = [cellData]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // sets the navbar background color and font color
        navigationController?.navigationBar.barTintColor = UIColor(red:0.53, green:0.73, blue:0.85, alpha:1.00)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        // creates an invisible footer that hides the empty table dividers
        tableView.tableFooterView = UIView(frame: .zero)
        
        // defines the content in the array for each of the table cells
        arrayOfCellData = [cellData(cell : 1, titleText : "Upper Body", nextWorkoutText : "Strength/Cardio - 7 mins", BGImage: #imageLiteral(resourceName: "UpperBody-7mins")),
                           cellData(cell : 1, titleText : "Lower Body", nextWorkoutText : "Strength/Cardio - 7 mins", BGImage: #imageLiteral(resourceName: "LowerBody-7mins")),
                           cellData(cell : 1, titleText : "7 Minute Workout", nextWorkoutText : "Strength/Cardio", BGImage: #imageLiteral(resourceName: "7MinWorkouts")),
                           cellData(cell : 1, titleText : "7 Minute Tabata", nextWorkoutText : "Strength/Cardio", BGImage: #imageLiteral(resourceName: "7MinTabata"))]
        
        // sets the table cell index to 0
        GlobalVars.workoutsIndexCount = 0
        
        // instantiates the Upper Body array data
        var newExercise = Exercise(name: "Jumping Jacks", filename: "jumping-jacks", meterFilename: "workout-progress-Step1_7",  tips:
            "1. Stand with your feet together and your hands at your sides. \n\n" +
                "2. Jump straight up while simultaneously spreading your legs shoulder width apart and raising your hands over your head. Like you're making a snow angle jumping in the air. \n\n" +
                "3. Land with your legs apart and arms over your head. \n\n" +
                "4. Jump straigt up again, but this time put your feet back together and bring your arms down to your sides following the same arcing path you made when raising them. \n\n" +
            "Do as many as you can in a minute, but take breaks as needed.") // 0
        GlobalVars.workoutsUB.append(newExercise)
        
        newExercise = Exercise(name: "Push-Ups", filename: "push-ups", meterFilename: "workout-progress-Step2_7", tips:
            "1. Lie on the floor face down and place your hands just about about shoulder width apart while holding your torso up at arms length. \n\n" +
                "2. Lower yourself down until your chest almost touches the floor as you inhale.\n\n" +
                "3. Press your upper body back up to the starting position, focussing on squeezing your chest while exhaling.\n\n" +
            "Do as many as you can in a minute, but take breaks as needed.") // 1
        GlobalVars.workoutsUB.append(newExercise)
        
        newExercise = Exercise(name: "Curls", filename: "curls", meterFilename: "workout-progress-Step3_7", tips:
            "1. Choose a resistance band that allows you to do at least 15 repetitions in one set. \n\n" +
                "2. Stand up straight with your feet hip width apart. \n\n" +
                "3. Place the band under your feet and hold the handles down by your sides. Make sure each side is even. \n\n" +
                "4. Curl your arms up toward your shoulders. Exhale and make sure to keep your elbows tucked in at your sides - don't arch your back. \n\n" +
                "5. Return to the starting position in a slow and controlled manner while you inhale. \n\n" +
            "Do as many as you can in a minute, but take breaks as needed.\n\n") // 2
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
            "Do as many as you can in a minute, but take breaks as needed.") // 4
        GlobalVars.workoutsUB.append(newExercise)
        
        newExercise = Exercise(name: "Curls", filename: "curls", meterFilename: "workout-progress-Step6_7", tips:
            "1. Choose a resistance band that allows you to do at least 15 repetitions in one set. \n\n" +
                "2. Stand up straight with your feet hip width apart. \n\n" +
                "3. Place the band under your feet and hold the handles down by your sides. Make sure each side is even. \n\n" +
                "4. Curl your arms up toward your shoulders. Exhale and make sure to keep your elbows tucked in at your sides - don't arch your back. \n\n" +
                "5. Return to the starting position in a slow and controlled manner while you inhale. \n\n" +
            "Do as many as you can in a minute, but take breaks as needed.\n\n") // 5
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
            "Do as many as you can in a minute, but take breaks as needed.") // 0
        GlobalVars.workoutsLB.append(newExercise)
        
        newExercise = Exercise(name: "Squats", filename: "squats", meterFilename: "workout-progress-Step2_7", tips:
            "1. Stand with your spine in a straight line, and have your feet a little wider than hip-width apart. \n\n" +
                "2. Bend at the knees to lower your hips toward the ground and move them backwards, as though you're going to sit in a chair. Your shins should be perpendicular to the floor and your spine should stay straight. Keep your arms out in front of you for balance as needed while you inhale. \n\n" +
                "3. Straighten your legs back to the starting position while you exhale \n\n" +
                "If you can't do a full squat by bringing your hips close to the floor, do a half squat or squat down as far as you can until you improve and can go lower. \n\n" +
            "Do as many as you can in a minute, takeing breaks as needed.") // 1
        GlobalVars.workoutsLB.append(newExercise)
        
        newExercise = Exercise(name: "Lunges", filename: "lunges", meterFilename: "workout-progress-Step3_7", tips:
            "1. Stand up straight with your feet about a shoulder width apart. Put your hands on your hips, keep your back as straight as possible, relax your shoulders and keep your eyes facing directly ahead. \n\n" +
                "2. Take a large step forward with one leg. The length of your step will depend on your height, but it will usually be somewhere between 2 or 3 feet (0.6 or 0.9 m). \n\n" +
                "3. As you step forward, lower your hips and bend your knees until they both form 90 degree angles while inhaling. Your front knee should not extend over your toes and your back knee should not touch the ground. \n\n" +
                "4. Pause at the bottom of the lunge for a second then push off the heel of your front foot to return to the starting position while exhaling. \n\n" +
                "Alternate legs as you go. \n\n" +
            "Do as many as you can in a minute, but take breaks as needed.") // 2
        GlobalVars.workoutsLB.append(newExercise)
        
        newExercise = Exercise(name: "Calf Raises", filename: "calf-raises", meterFilename: "workout-progress-Step4_7", tips:
            "1. Stand with your feet shoulder width apart. You can hold the back of a chair for balance if needed. \n\n" +
                "2. Lift your heels until you're standing on your tip toes while exhaling. Distribute most of your weight onto the balls of your feet, and keep your legs straight. \n\n" +
                "3. Stay on your tip toes for two seconds. Then, begin to lower your heels, and move your weight away from the balls of your feet until your heels are back on the ground while inhaling. \n\n" +
            "Do as many as you can in a minute, but take breaks as needed.") // 3
        GlobalVars.workoutsLB.append(newExercise)
        
        newExercise = Exercise(name: "Squats", filename: "squats", meterFilename: "workout-progress-Step5_7", tips:
            "1. Stand with your spine in a straight line, and have your feet a little wider than hip-width apart. \n\n" +
                "2. Bend at the knees to lower your hips toward the ground and move them backwards, as though you're going to sit in a chair. Your shins should be perpendicular to the floor and your spine should stay straight. Keep your arms out in front of you for balance as needed while you inhale. \n\n" +
                "3. Straighten your legs back to the starting position while you exhale \n\n" +
                "If you can't do a full squat by bringing your hips close to the floor, do a half squat or squat down as far as you can until you improve and can go lower. \n\n" +
            "Do as many as you can in a minute, takeing breaks as needed.") // 4
        GlobalVars.workoutsLB.append(newExercise)
        
        newExercise = Exercise(name: "Lunges", filename: "lunges", meterFilename: "workout-progress-Step6_7", tips:
            "1. Stand up straight with your feet about a shoulder width apart. Put your hands on your hips, keep your back as straight as possible, relax your shoulders and keep your eyes facing directly ahead. \n\n" +
                "2. Take a large step forward with one leg. The length of your step will depend on your height, but it will usually be somewhere between 2 or 3 feet (0.6 or 0.9 m). \n\n" +
                "3. As you step forward, lower your hips and bend your knees until they both form 90 degree angles while inhaling. Your front knee should not extend over your toes and your back knee should not touch the ground. \n\n" +
                "4. Pause at the bottom of the lunge for a second then push off the heel of your front foot to return to the starting position while exhaling. \n\n" +
                "Alternate legs as you go. \n\n" +
            "Do as many as you can in a minute, but take breaks as needed.") // 6
        GlobalVars.workoutsLB.append(newExercise)
        
        newExercise = Exercise(name: "Calf Raises", filename: "calf-raises", meterFilename: "workout-progress-Step7_7", tips:
            "1. Stand with your feet shoulder width apart. You can hold the back of a chair for balance if needed. \n\n" +
                "2. Lift your heels until you're standing on your tip toes while exhaling. Distribute most of your weight onto the balls of your feet, and keep your legs straight. \n\n" +
                "3. Stay on your tip toes for two seconds. Then, begin to lower your heels, and move your weight away from the balls of your feet until your heels are back on the ground while inhaling. \n\n" +
            "Do as many as you can in a minute, but take breaks as needed.") // 7
        GlobalVars.workoutsLB.append(newExercise)
        
        
        // instantiates the 7 Min Workout array data -------------------------------------------------------------------------//
        newExercise = Exercise(name: "Jumping Jacks", filename: "jumping-jacks", meterFilename: "workout-progress-Step1_12", tips:
            "1. Stand with your feet together and your hands at your sides. \n\n" +
                "2. Jump straight up while simultaneously spreading your legs shoulder width apart and raising your hands over your head. Like you're making a snow angle jumping in the air. \n\n" +
                "3. Land with your legs apart and arms over your head. \n\n" +
                "4. Jump straigt up again, but this time put your feet back together and bring your arms down to your sides following the same arcing path you made when raising them. \n\n" +
            "Do as many as you can in a minute, but take breaks as needed.")
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
            "Do as many as you can in a minute, but take breaks as needed.")
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
            "Do as many as you can in a minute, takeing breaks as needed.")
        GlobalVars.workouts7M.append(newExercise)
        
        newExercise = Exercise(name: "Squats", filename: "squats", meterFilename: "workout-progress-Step6_12", tips:
            "1. Stand with your spine in a straight line, and have your feet a little wider than hip-width apart. \n\n" +
                "2. Bend at the knees to lower your hips toward the ground and move them backwards, as though you're going to sit in a chair. Your shins should be perpendicular to the floor and your spine should stay straight. Keep your arms out in front of you for balance as needed while you inhale. \n\n" +
                "3. Straighten your legs back to the starting position while you exhale \n\n" +
                "If you can't do a full squat by bringing your hips close to the floor, do a half squat or squat down as far as you can until you improve and can go lower. \n\n" +
            "Do as many as you can in a minute, takeing breaks as needed.")
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
            "Do as many as you can in a minute, but take breaks as needed.")
        GlobalVars.workouts7M.append(newExercise)
        
        newExercise = Exercise(name: "Rotation Push-Ups", filename: "push-ups-rotation", meterFilename: "workout-progress-Step11_12", tips:
            "1. Lie on the floor face down and place your hands just about about shoulder width apart while holding your torso up at arms length. \n\n" +
                "2. Lower yourself down until your chest almost touches the floor as you inhale.\n\n" +
                "3. Press your upper body back up to the starting position, focussing on squeezing your chest while exhaling. At the top of the push-up, rotate your upper body and extend your right arm upwards. Return to starting position and repeat. Alternate sides as you go. \n\n" +
            "Do as many as you can in a minute, but take breaks as needed.")
        GlobalVars.workouts7M.append(newExercise)
        
        newExercise = Exercise(name: "Side Plank", filename: "side-plank-right", meterFilename: "workout-progress-Step12_12", tips:
            "1. Lie on your side with your legs straight and your body in a straight line (shoulders and hips stacked one on top of the other; don’t lean forward or backwards).\n\n" +
                "2. Prop your body up so your hips are off the floor. Rest your weight on the elbow that’s touching the floor.\n\n" +
                "3. Only your forearm and feet should touch the floor.\n\n" +
                "4. Do not let your hips sag (this is the challenging part of this move). As you get tired, you’ll want to drop your hips, but focus on keeping them stationary. \n\n" +
            "Hold for 30 seconds then switch sides for the remainder of the minute, but take breaks as needed.") //1
        GlobalVars.workouts7M.append(newExercise)
    
        // instantiates the 7 Min Tabata array data -------------------------------------------------------------------------//
        newExercise = Exercise(name: "Squats", filename: "squats", meterFilename: "workout-progress-Step1_6", tips:
            "1. Stand with your spine in a straight line, and have your feet a little wider than hip-width apart. \n\n" +
                "2. Bend at the knees to lower your hips toward the ground and move them backwards, as though you're going to sit in a chair. Your shins should be perpendicular to the floor and your spine should stay straight. Keep your arms out in front of you for balance as needed while you inhale. \n\n" +
                "3. Straighten your legs back to the starting position while you exhale \n\n" +
                "If you can't do a full squat by bringing your hips close to the floor, do a half squat or squat down as far as you can until you improve and can go lower. \n\n" +
            "Do as many as you can in a minute, takeing breaks as needed.")
        GlobalVars.workouts7T.append(newExercise) // 0
        
        newExercise = Exercise(name: "Jumping Jacks", filename: "jumping-jacks", meterFilename: "workout-progress-Step2_6", tips:
            "1. Stand with your feet together and your hands at your sides. \n\n" +
                "2. Jump straight up while simultaneously spreading your legs shoulder width apart and raising your hands over your head. Like you're making a snow angle jumping in the air. \n\n" +
                "3. Land with your legs apart and arms over your head. \n\n" +
                "4. Jump straigt up again, but this time put your feet back together and bring your arms down to your sides following the same arcing path you made when raising them. \n\n" +
            "Do as many as you can in a minute, but take breaks as needed.")
        GlobalVars.workouts7T.append(newExercise) // 1
        
        newExercise = Exercise(name: "Push-Ups", filename: "push-ups", meterFilename: "workout-progress-Step3_6", tips:
            "1. Lie on the floor face down and place your hands just about about shoulder width apart while holding your torso up at arms length. \n\n" +
                "2. Lower yourself down until your chest almost touches the floor as you inhale.\n\n" +
                "3. Press your upper body back up to the starting position, focussing on squeezing your chest while exhaling.\n\n" +
            "Do as many as you can in a minute, but take breaks as needed.")
        GlobalVars.workouts7T.append(newExercise) // 2
        
        // round2
        
        newExercise = Exercise(name: "Squats", filename: "squats", meterFilename: "workout-progress-Step5_6", tips:
            "1. Stand with your spine in a straight line, and have your feet a little wider than hip-width apart. \n\n" +
                "2. Bend at the knees to lower your hips toward the ground and move them backwards, as though you're going to sit in a chair. Your shins should be perpendicular to the floor and your spine should stay straight. Keep your arms out in front of you for balance as needed while you inhale. \n\n" +
                "3. Straighten your legs back to the starting position while you exhale \n\n" +
                "If you can't do a full squat by bringing your hips close to the floor, do a half squat or squat down as far as you can until you improve and can go lower. \n\n" +
            "Do as many as you can in a minute, takeing breaks as needed.")
        GlobalVars.workouts7T.append(newExercise) // 3
        
        newExercise = Exercise(name: "Jumping Jacks", filename: "jumping-jacks", meterFilename: "workout-progress-Step5_6", tips:
            "1. Stand with your feet together and your hands at your sides. \n\n" +
                "2. Jump straight up while simultaneously spreading your legs shoulder width apart and raising your hands over your head. Like you're making a snow angle jumping in the air. \n\n" +
                "3. Land with your legs apart and arms over your head. \n\n" +
                "4. Jump straigt up again, but this time put your feet back together and bring your arms down to your sides following the same arcing path you made when raising them. \n\n" +
            "Do as many as you can in a minute, but take breaks as needed.")
        GlobalVars.workouts7T.append(newExercise) // 4
        
        newExercise = Exercise(name: "Push-Ups", filename: "push-ups", meterFilename: "workout-progress-Step6_6", tips:
            "1. Lie on the floor face down and place your hands just about about shoulder width apart while holding your torso up at arms length. \n\n" +
                "2. Lower yourself down until your chest almost touches the floor as you inhale.\n\n" +
                "3. Press your upper body back up to the starting position, focussing on squeezing your chest while exhaling.\n\n" +
            "Do as many as you can in a minute, but take breaks as needed.")
        GlobalVars.workouts7T.append(newExercise) // 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // lists all the cells that have been defined in the cell array
        return arrayOfCellData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if arrayOfCellData[indexPath.row].cell == 1{
            let cell = Bundle.main.loadNibNamed("WorkoutsTableViewCell", owner: self, options: nil)?.first as! WorkoutsTableViewCell
            
            cell.BGImageView.image = arrayOfCellData[indexPath.row].BGImage
            cell.TitleLabel.text = arrayOfCellData[indexPath.row].titleText
            cell.LastWorkoutLabel.text = arrayOfCellData[indexPath.row].nextWorkoutText
            
            return cell
        }else{
            let cell = Bundle.main.loadNibNamed("WorkoutsTableViewCell", owner: self, options: nil)?.first as! WorkoutsTableViewCell
            
            cell.BGImageView.image = arrayOfCellData[indexPath.row].BGImage
            cell.TitleLabel.text = arrayOfCellData[indexPath.row].titleText
            cell.LastWorkoutLabel.text = arrayOfCellData[indexPath.row].nextWorkoutText
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if arrayOfCellData[indexPath.row].cell == 1{
            return 95
        }else{
            return 95
        }
    }
    
    
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath as NSIndexPath).row == 0{
            
            // performs the segue to the next screen
            performSegue(withIdentifier: "segueToWorkouts", sender: self)
            
            print("UB cell hit")
        }
        if (indexPath as NSIndexPath).row == 1{
            
            // performs the segue to the next screen
            performSegue(withIdentifier: "segueToWorkouts", sender: self)
            
            print("LB cell hit")
            
        }
        if (indexPath as NSIndexPath).row == 2{
            
            // performs the segue to the next screen
            performSegue(withIdentifier: "segueToWorkouts", sender: self)
            
            print("7M cell hit")
        }
        if (indexPath as NSIndexPath).row == 3{
            
            // performs the segue to the next screen
            performSegue(withIdentifier: "segueToWorkouts", sender: self)
            
            print("7T cell hit")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueToWorkouts"{
            if let indexPath = tableView.indexPathForSelectedRow{
            let selectedRow = indexPath.row
            
                if selectedRow == 0{
                    let vc = segue.destination as! WorkoutsViewController
                    vc.navTitle = "Upper Body"
                    vc.exerciseTitle = GlobalVars.workoutsUB[GlobalVars.workoutsIndexCount].name
                    vc.exerciseImage = UIImage(named: GlobalVars.workoutsUB[GlobalVars.workoutsIndexCount].filename)
                    vc.meterImage = UIImage(named: GlobalVars.workoutsUB[GlobalVars.workoutsIndexCount].meterFilename)
                    print("UB Segue and selectedCell = \(selectedRow)")
                }
            
                if selectedRow == 1{
                    let vc = segue.destination as! WorkoutsViewController
                    vc.navTitle = "Lower Body"
                    vc.exerciseTitle = GlobalVars.workoutsLB[GlobalVars.workoutsIndexCount].name
                    vc.exerciseImage = UIImage(named: GlobalVars.workoutsLB[GlobalVars.workoutsIndexCount].filename)
                    vc.meterImage = UIImage(named: GlobalVars.workoutsUB[GlobalVars.workoutsIndexCount].meterFilename)
                
                    print("LB Segue and selectedCell = \(selectedRow)")
                }
            
                if selectedRow == 2{
                    let vc = segue.destination as! WorkoutsViewController
                    vc.navTitle = "7 Minute Workout"
                    vc.exerciseTitle = GlobalVars.workouts7M[GlobalVars.workoutsIndexCount].name
                    vc.exerciseImage = UIImage(named: GlobalVars.workouts7M[GlobalVars.workoutsIndexCount].filename)
                    vc.meterImage = UIImage(named: GlobalVars.workouts7M[GlobalVars.workoutsIndexCount].meterFilename)
                
                    print("7M Segue and selectedCell = \(selectedRow)")
                }
            
                if selectedRow == 3{
                    let vc = segue.destination as! WorkoutsViewController
                    vc.navTitle = "7 Minute Tabata"
                    vc.exerciseTitle = GlobalVars.workouts7T[GlobalVars.workoutsIndexCount].name
                    vc.exerciseImage = UIImage(named: GlobalVars.workouts7T[GlobalVars.workoutsIndexCount].filename)
                    vc.meterImage = UIImage(named: GlobalVars.workouts7T[GlobalVars.workoutsIndexCount].meterFilename)
                
                    print("7T Segue and selectedCell = \(selectedRow)")
                }
            }
        }
    }

}
