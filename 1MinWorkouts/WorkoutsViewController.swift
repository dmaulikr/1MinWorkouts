//
//  WorkoutsViewController.swift
//  1MinWorkouts
//
//  Created by Justin on 12/29/14.
//  Copyright (c) 2014 Good Enough LLC. All rights reserved.
//


import UIKit
import AudioToolbox

class WorkoutsViewController: UIViewController, WorkoutViewControllerDelegate {

    var exerciseTitle = ""
    var exerciseImage = UIImage(named: "")
    var navTitle = ""
    var meterImage = UIImage(named: "")
    var exerciseCountdownTimer = Timer()
    var totalTime = 0
    
    @IBOutlet var exerciseTypeTitle: UILabel!
    @IBOutlet var switchSidesSubTitle: UILabel!
    @IBOutlet var exerciseTypeImage: UIImageView!
    @IBOutlet var exerciseTypeInfoBtn: UIButton!
    
    @IBOutlet var nextWorkoutView: UIVisualEffectView!
    @IBOutlet var nextWorkoutCountdownLabel: UILabel!
    
    //---------------- use this to play through stock iOS tones --------------//
//    var alertTone = UInt32(1100)// double vibrate (got to 1301)

//    @IBAction func findTonesBtn(_ sender: AnyObject) {
//        
//        for _ in 1...100 {
//            alertTone += 1
//            AudioServicesPlaySystemSound(alertTone) // plays tones
//            sleep(2)
//            print("\(alertTone)")
//        }
//    }
    //---------------- use this to play through stock iOS tones --------------//
    
    override func viewWillAppear(_ animated: Bool) {
        // defines when to show the next exercise wait timer after the first workout has been done
        if GlobalVars.workoutsIndexCount != 0 && nextWorkoutView.isHidden == false{
            let currentTimerCount = nextWorkoutCountdownLabel
            let currentTimerCountInt:Int? = Int((currentTimerCount?.text)!)
            setExerciseTimer(currentTimerCountInt!, timerLabel: "\(currentTimerCount)")
            print("------------ viewWillAppear reset time")
        }else if GlobalVars.workoutsIndexCount != 0{
            nextWorkoutView.isHidden = false
        
            UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
                    self.nextWorkoutView.center.y = self.nextWorkoutView.center.y - 150
                    print("------------ viewWillAppear animate")
            }) { (value:Bool) in
                // stops the countdown
                self.exerciseCountdownTimer.invalidate()
                
                //Sets the next exercise wait timer after the animation loads
                if self.navTitle == "Upper Body" || self.navTitle == "Lower Body"{
                    self.setExerciseTimer(30, timerLabel: "30")
                }else if self.navTitle == "7 Minute Workout" || self.navTitle == "7 Minute Tabata"{
                    self.setExerciseTimer(10, timerLabel: "10")
                }
            }
        }else{
            // hides the next workout view
            nextWorkoutView.isHidden = true
            print("------------ viewWillAppear hide view")
        }
    }
    
    override func viewDidLayoutSubviews() {
        // checks to make sure the next workout counter view is only shown when needed
        if GlobalVars.workoutsIndexCount != 0{
            nextWorkoutView.center.y = nextWorkoutView.center.y + 150
        }else {
            nextWorkoutView.center.y = nextWorkoutView.center.y
        }
        
        // makes sure the next workout countdown value is set prior to showing it
        if self.navTitle == "Upper Body" || self.navTitle == "Lower Body"{
            self.nextWorkoutCountdownLabel.text = "30"
        }else if self.navTitle == "7 Minute Workout" || self.navTitle == "7 Minute Tabata"{
            self.nextWorkoutCountdownLabel.text = "10"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // sets the navbar background color and font color
        navigationController?.navigationBar.barTintColor = UIColor(red:0.53, green:0.73, blue:0.85, alpha:1.00)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        //hides switch sides sub-title by default
        switchSidesSubTitle.isHidden = true
        
        //my modal transition style
        modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        
        navigationItem.title = navTitle
        exerciseTypeTitle.text = exerciseTitle
        exerciseTypeImage.image = exerciseImage
        
    }
    
    //----------------------------------------- next exercise wait timer -----------------------------------------//
    func exerciseTimerGetReady(){
        GlobalVars.nextExerciseSecondsCount -= 1 // decreases the count down by 1
        let minutes = (GlobalVars.nextExerciseSecondsCount / 60) // converts the seconds into minute format
        let seconds = (GlobalVars.nextExerciseSecondsCount - (minutes * 60)) // converts the seconds back to seconds
        let timerOutput = String(format:"%.d", seconds) // defines the output that is placed on the label
        nextWorkoutCountdownLabel.text = timerOutput
        
        // what happens when the timer ends
        if (GlobalVars.nextExerciseSecondsCount == 5) {
            
            exerciseCountdownTimer.invalidate() // stops the countdown
            
            //setExerciseTimer(0, timerLabel: "0")
            
            nextWorkoutView.isHidden = true
            
            AudioServicesPlaySystemSound(1120) // plays vibrate and tone
            
            // segues to the next workout
            performSegue(withIdentifier: "segueToExercises", sender: self)
            
        }
    }
    
    // method that defines the timer for next workout timer
    func setExerciseTimer(_ timerTime : Int, timerLabel : String){
        
        totalTime = timerTime // sets the timer to starting time desired
        
        nextWorkoutCountdownLabel.text = timerLabel // sets timer label to starting time desired
        
        GlobalVars.nextExerciseSecondsCount = totalTime; // sets timer to an hour
        exerciseCountdownTimer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: #selector(ExercisesViewController.exerciseTimerGetReady), userInfo: nil, repeats: true) // sets the timer interval to 1.0 seconds and uses the timerRun method as the countdown
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func myVCDidFinish(_ controller: ExercisesViewController, indexCount: Int) {
        if navigationItem.title == "Upper Body"{
            let image = UIImage(named: GlobalVars.workoutsUB[indexCount].filename)
            exerciseTypeImage.image = image
            exerciseTypeTitle.text = GlobalVars.workoutsUB[indexCount].name
            switchSidesSubTitle.isHidden = true
        }
        if navigationItem.title == "Lower Body"{
            let image = UIImage(named: GlobalVars.workoutsLB[indexCount].filename)
            exerciseTypeImage.image = image
            exerciseTypeTitle.text = GlobalVars.workoutsLB[indexCount].name
            
            //add switch sub-title to needed exercises
            if exerciseTypeTitle.text == "Lunges"{
                switchSidesSubTitle.isHidden = false
                switchSidesSubTitle.text = "Alternate Sides"
            }else{
                switchSidesSubTitle.isHidden = true
            }
        }
        if navigationItem.title == "7 Minute Workout"{
            let image = UIImage(named: GlobalVars.workouts7M[indexCount].filename)
            exerciseTypeImage.image = image
            exerciseTypeTitle.text = GlobalVars.workouts7M[indexCount].name
            
            
            //add switch sub-title to needed exercises
            if exerciseTypeTitle.text == "Side Plank"{
                switchSidesSubTitle.isHidden = false
                switchSidesSubTitle.text = "Switch Sides @ 15 Secs"
            }else if exerciseTypeTitle.text == "Chair Step Ups" ||
                exerciseTypeTitle.text == "High Knees/Run In Place" ||
                exerciseTypeTitle.text == "Rotation Push-Ups"{
                switchSidesSubTitle.isHidden = false
                switchSidesSubTitle.text = "Alternate Sides"
            }else{
                switchSidesSubTitle.isHidden = true
            }
        }
        if navigationItem.title == "7 Minute Tabata"{
            let image = UIImage(named: GlobalVars.workouts7T[indexCount].filename)
            exerciseTypeImage.image = image
            exerciseTypeTitle.text = GlobalVars.workouts7T[indexCount].name
            switchSidesSubTitle.isHidden = true
        }
        controller.navigationController!.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueToExercises"{
            
            // false = UB objects (default start)  true = LB objects
            if navigationItem.title == "Upper Body"{
                // set up WorkoutsViewController to show Upper Body stuff
                GlobalVars.exerciseGroup = true
                
                let vc = segue.destination as! ExercisesViewController
                vc.navTitle = "Upper Body"
                vc.exerciseTitle = GlobalVars.workoutsUB[GlobalVars.workoutsIndexCount].name
                vc.exerciseImage = UIImage(named: GlobalVars.workoutsUB[GlobalVars.workoutsIndexCount].filename)
                vc.meterImage = UIImage(named: GlobalVars.workoutsUB[GlobalVars.workoutsIndexCount].meterFilename)
                vc.delegate = self
            }
            if navigationItem.title == "Lower Body"{
                // set up WorkoutsViewController to show Lower Body stuff
                GlobalVars.exerciseGroup = false
                
                let vc = segue.destination as! ExercisesViewController
                vc.navTitle = "Lower Body"
                vc.exerciseTitle = GlobalVars.workoutsLB[GlobalVars.workoutsIndexCount].name
                vc.exerciseImage = UIImage(named: GlobalVars.workoutsLB[GlobalVars.workoutsIndexCount].filename)
                vc.meterImage = UIImage(named: GlobalVars.workoutsUB[GlobalVars.workoutsIndexCount].meterFilename)
                vc.delegate = self
            }
            if navigationItem.title == "7 Minute Workout"{
                // set up WorkoutsViewController to show All Core stuff
                GlobalVars.exerciseGroup = false
                
                let vc = segue.destination as! ExercisesViewController
                vc.navTitle = "7 Minute Workout"
                vc.exerciseTitle = GlobalVars.workouts7M[GlobalVars.workoutsIndexCount].name
                vc.exerciseImage = UIImage(named: GlobalVars.workouts7M[GlobalVars.workoutsIndexCount].filename)
                vc.meterImage = UIImage(named: GlobalVars.workouts7M[GlobalVars.workoutsIndexCount].meterFilename)
                vc.delegate = self
            }
            if navigationItem.title == "7 Minute Tabata"{
                // set up WorkoutsViewController to show All Core stuff
                GlobalVars.exerciseGroup = false
                
                let vc = segue.destination as! ExercisesViewController
                vc.navTitle = "7 Minute Tabata"
                vc.exerciseTitle = GlobalVars.workouts7T[GlobalVars.workoutsIndexCount].name
                vc.exerciseImage = UIImage(named: GlobalVars.workouts7T[GlobalVars.workoutsIndexCount].filename)
                vc.meterImage = UIImage(named: GlobalVars.workouts7T[GlobalVars.workoutsIndexCount].meterFilename)
                vc.delegate = self
            }
        }
        
        if segue.identifier == "segueToExerciseInfo"{
            
            // false = UB objects (default start)  true = LB objects
            if navigationItem.title == "Upper Body"{
                // set up WorkoutsViewController to show Upper Body stuff
                GlobalVars.exerciseGroup = true
                
                let vc = segue.destination as! WorkoutsInfoViewController
                vc.exerciseTitle = GlobalVars.workoutsUB[GlobalVars.workoutsIndexCount].name
                vc.exerciseTips = GlobalVars.workoutsUB[GlobalVars.workoutsIndexCount].tips
            }
            if navigationItem.title == "Lower Body"{
                // set up WorkoutsViewController to show Lower Body stuff
                GlobalVars.exerciseGroup = false
                
                let vc = segue.destination as! WorkoutsInfoViewController
                vc.exerciseTitle = GlobalVars.workoutsLB[GlobalVars.workoutsIndexCount].name
                vc.exerciseTips = GlobalVars.workoutsLB[GlobalVars.workoutsIndexCount].tips
            }
            if navigationItem.title == "7 Minute Workout"{
                // set up WorkoutsViewController to show 7 Min Workouts stuff
                GlobalVars.exerciseGroup = false
                
                let vc = segue.destination as! WorkoutsInfoViewController
                vc.exerciseTitle = GlobalVars.workouts7M[GlobalVars.workoutsIndexCount].name
                vc.exerciseTips = GlobalVars.workouts7M[GlobalVars.workoutsIndexCount].tips
            }
            if navigationItem.title == "7 Minute Tabata"{
                // set up WorkoutsViewController to show 7 Min Tabata stuff
                GlobalVars.exerciseGroup = false
                
                let vc = segue.destination as! WorkoutsInfoViewController
                vc.exerciseTitle = GlobalVars.workouts7T[GlobalVars.workoutsIndexCount].name
                vc.exerciseTips = GlobalVars.workouts7T[GlobalVars.workoutsIndexCount].tips
            }
        }
    }
    

    override func viewWillDisappear(_ animated: Bool) {
        
        exerciseCountdownTimer.invalidate() // stops the countdown
        
        // checks to see if it's disappearing to go to the list view and not the next view
        if (self.isMovingFromParentViewController){
            GlobalVars.workoutsIndexCount = 0
        }
        
        //resets the arrays index to starting point
//        GlobalVars.workoutsIndexCount = 0
//        
//        print("the indexCount = \(GlobalVars.workoutsIndexCount)")
    }

}
