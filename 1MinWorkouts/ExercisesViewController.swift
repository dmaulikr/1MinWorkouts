//
//  ExercisesViewController.swift
//  1MinWorkouts
//
//  Created by Justin on 1/16/17.
//  Copyright © 2017 Good Enough LLC. All rights reserved.
//

import UIKit
import AudioToolbox

protocol WorkoutViewControllerDelegate{
    func myVCDidFinish(_ controller:ExercisesViewController,indexCount:Int)
}

class ExercisesViewController: UIViewController {

    var delegate:WorkoutViewControllerDelegate? = nil
    var exerciseTitle = ""
    var exerciseImage = UIImage(named: "")
    var navTitle = ""
    var exercisesCount = 0
    var meterImage = UIImage(named: "")
    
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
    @IBOutlet var workoutMeterImage: UIImageView!
    
    @IBOutlet var nextWorkoutView: UIVisualEffectView! // whole view container for get next workout count down
    @IBOutlet var nextWorkoutCountdownLabel: UILabel! // label that counts down for next workout

    
    @IBAction func cancelWorkout(_ sender: Any) {
        // closes the current view and goes back to starting view
        self.dismiss(animated: true, completion: nil)
        
        // kills the countdown timer
        exerciseCountdownTimer.invalidate()
        
        // Resets the index variable to update to the next exercise back to the start
        GlobalVars.workoutsIndexCount = 0
        
        // passes the incremented variable to the prior screen delegate
        if (delegate != nil) {
            delegate!.myVCDidFinish(self, indexCount: GlobalVars.workoutsIndexCount)
        }
    }
    
    // restart button
    @IBAction func startWorkoutBtn(_ sender: AnyObject) {
        getReadyView.isHidden = false
        workoutCountdownLabel.isHidden = true
        
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
//        if navTitle == "Upper Body" && GlobalVars.workoutsIndexCount == 7 || navTitle == "Lower Body" && GlobalVars.workoutsIndexCount == 7{
//            
//            print("UB and LB index reached 7 indexCount is \(GlobalVars.workoutsIndexCount)")
//            
//            return GlobalVars.workoutsIndexCount = 0
//        }else{
//            var newCount = GlobalVars.workoutsIndexCount
//            newCount += 1
//            
//            print("changeExercise's else indexCount is \(GlobalVars.workoutsIndexCount)")
//            
//            return GlobalVars.workoutsIndexCount = newCount
//            
//        }
        var newCount = GlobalVars.workoutsIndexCount
        newCount += 1
        
        print("changeExercise's else indexCount is \(GlobalVars.workoutsIndexCount)")
        
        return GlobalVars.workoutsIndexCount = newCount
    }
    
    //----------------------------------------- Main workout timer -----------------------------------------//
    func exerciseTimerRun(){
        GlobalVars.exerciseSecondsCount -= 1 // decreases the count down by 1
        let minutes = (GlobalVars.exerciseSecondsCount / 60) // converts the seconds into minute format
        let seconds = (GlobalVars.exerciseSecondsCount - (minutes * 60)) // converts the seconds back to seconds
        
        let timerOutput = String(format:"%.2d", seconds) // defines the output that is placed on the label
        workoutCountdownLabel.text = timerOutput
        
        // what happens when the timer has 10 seconds left
        if exerciseTitle != "Side Plank"{ // if Side Plank doesn't do the 10 sec reminder vibrate since you switch at 30 sec
            if (GlobalVars.exerciseSecondsCount == 10) {
                AudioServicesPlaySystemSound(1361) // was 1360, plays double vibrate when there's 10 secs left in workout
            }
        }
        
        // shows switch sides countdown for Side Plank
        if exerciseTitle == "Side Plank" && GlobalVars.exerciseSecondsCount == 15{
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
            
            // sends alert when workout is finished-------------------------------------------------------------------//
            if navTitle == "7 Minute Tabata" && GlobalVars.workoutsIndexCount == 13 ||
                navTitle == "Upper Body" && GlobalVars.workoutsIndexCount == 6 ||
                navTitle == "Lower Body" && GlobalVars.workoutsIndexCount == 6 ||
                navTitle == "7 Minute Workout" && GlobalVars.workoutsIndexCount == 11{
                
                let alert = UIAlertController(title: "You're Finished With Your Workout", message: "\n\n\nNice Job!", preferredStyle: UIAlertControllerStyle.alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
                    (action: UIAlertAction!) in
                    
                    // Resets the index variable to update to the next exercise back to the start
                    GlobalVars.workoutsIndexCount = 0
                    
                    // passes the incremented variable to the prior screen delegate
                    if (self.delegate != nil) {
                        self.delegate!.myVCDidFinish(self, indexCount: GlobalVars.workoutsIndexCount)
                    }
                    
                    self.dismiss(animated: true, completion: nil)
                }))
                
                let thumbsImage = UIImage(named: "thumbs-up")
                let imageView = UIImageView(frame: CGRect(x: 117, y: 67, width: 40, height: 40))
                imageView.image = thumbsImage
                
                alert.view.addSubview(imageView)
                
                self.present(alert, animated: true, completion: nil)
                // sends alert when workout is finished-------------------------------------------------------------------//
            }else{
                // increments the index index variable to update to the next exercise
                changeExercise()
            
                // passes the incremented variable to the prior screen delegate
                if (delegate != nil) {
                    delegate!.myVCDidFinish(self, indexCount: GlobalVars.workoutsIndexCount)
                }
            
                func gotoWorkoutVC(){
                    let vc = ExercisesViewController(nibName: "ExercisesViewController", bundle: nil)
                    navigationController?.pushViewController(vc, animated: true)
                }
                
                self.dismiss(animated: true, completion: nil)
            }
            
            //AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate)) // sends vibrate when workout is done
            AudioServicesPlaySystemSound(1120) // plays vibrate and tone
 
        }
    }
    
    // method that defines the actual timer for minute exercise timer
    func setExerciseTimer(_ timerTime : Int, timerLabel : String){
        
        totalTime = timerTime // sets the timer to starting time desired
        
        workoutCountdownLabel.text = timerLabel // sets timer label to starting time desired
        
        GlobalVars.exerciseSecondsCount = totalTime; // sets timer to an hour
        exerciseCountdownTimer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: #selector(ExercisesViewController.exerciseTimerRun), userInfo: nil, repeats: true) // sets the timer interval to 1.0 seconds and uses the timerRun method as the countdown
    }
    
    //----------------------------------------- get ready timer -----------------------------------------//
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
                workoutCountdownLabel.text = "15"
                setExerciseTimer(15, timerLabel: "15")
                getReadyLabel.text = "Get ready to workout!"
                getReadyView.isHidden = true
                workoutCountdownLabel.isHidden = false
                print("switched sides timer reset was triggered")
            }else {// regular 5 sec countdown get ready
                exerciseCountdownTimer.invalidate() // stops the countdown
                
                getReadyView.isHidden = true
                workoutCountdownLabel.isHidden = false
                if self.navTitle == "Upper Body" || self.navTitle == "Lower Body" || self.navTitle == "7 Minute Workout"{
                    self.setExerciseTimer(30, timerLabel: "30")
                }else if self.navTitle == "7 Minute Tabata"{
                    self.setExerciseTimer(20, timerLabel: "20")
                }
                // for testing
//                if self.navTitle == "Upper Body" || self.navTitle == "Lower Body" || self.navTitle == "7 Minute Workout"{
//                    self.setExerciseTimer(03, timerLabel: "03")// should be 30
//                }else if self.navTitle == "7 Minute Tabata"{
//                    self.setExerciseTimer(02, timerLabel: "02") // should be 20
//                }
                
                AudioServicesPlaySystemSound(1120) // plays vibrate and tone 1008-start/stop 1110 (nice option, maybe too simple)
                print("get ready triggered else")
            }
        }
    }
    
    // method that defines the actual timer for get ready exercise timer
    func setExerciseTimerGetReady(_ timerTime : Int, timerLabel : String){
        
        totalTime = timerTime // sets the timer to starting time desired
        
        getReadyCounterLabel.text = timerLabel // sets timer label to starting time desired
        
        GlobalVars.exerciseSecondsCount = totalTime; // sets timer to an hour
        exerciseCountdownTimer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: #selector(ExercisesViewController.exerciseTimerGetReady), userInfo: nil, repeats: true) // sets the timer interval to 1.0 seconds and uses the timerRun method as the countdown
        
    }
    
    // method that defines the actual timer for next workout exercise timer
    func setNextWorkoutTimer(_ timerTime : Int, timerLabel : String){
        
        totalTime = timerTime // sets the timer to starting time desired
        
        nextWorkoutCountdownLabel.text = timerLabel // sets timer label to starting time desired
        
        GlobalVars.exerciseSecondsCount = totalTime; // sets timer to an hour
        exerciseCountdownTimer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: #selector(ExercisesViewController.exerciseTimerGetReady), userInfo: nil, repeats: true) // sets the timer interval to 1.0 seconds and uses the timerRun method as the countdown
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // sets up the initial view and points page vars at right vars
        //exercisesCount = GlobalVars.exerciseUB.count
        navigationItem.title = navTitle
        exerciseTypeTitle.text = exerciseTitle
        exerciseTypeImage.image = exerciseImage
        workoutMeterImage.image = meterImage
        
        startWorkoutBtn.isHidden = true
        
        // sets the get ready to workout countdown view
        getReadyView.isHidden = false
        workoutCountdownLabel.isHidden = true
        setExerciseTimerGetReady(5, timerLabel: "5")
        
        // sets the get ready to workout label for the initial workout start message
        getReadyLabel.text = "Get ready to workout!"
        
        //hide switch sides sub-title by default
        switchSidesSubTitle.isHidden = true
        
        //show switch sides sub-title for relevant exercises
        if exerciseTitle == "Side Plank"{
            switchSidesSubTitle.isHidden = false
            switchSidesSubTitle.text = "Switch Sides @ 15 Secs"
        }else
            //show switch sides sub-title for Lunges
            if exerciseTypeTitle.text == "Chair Step Ups" ||
                exerciseTypeTitle.text == "High Knees/Run In Place" ||
                exerciseTypeTitle.text == "Rotation Push-Ups"{
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToWrokoutInfo"{
            
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
                // set up WorkoutsViewController to show Core stuff
                GlobalVars.exerciseGroup = false
                
                let vc = segue.destination as! WorkoutsInfoViewController
                vc.exerciseTitle = GlobalVars.workouts7M[GlobalVars.workoutsIndexCount].name
                vc.exerciseTips = GlobalVars.workouts7M[GlobalVars.workoutsIndexCount].tips
            }
            if navigationItem.title == "7 Minute Tabata"{
                // set up WorkoutsViewController to show Core stuff
                GlobalVars.exerciseGroup = false
                
                let vc = segue.destination as! WorkoutsInfoViewController
                vc.exerciseTitle = GlobalVars.workouts7T[GlobalVars.workoutsIndexCount].name
                vc.exerciseTips = GlobalVars.workouts7T[GlobalVars.workoutsIndexCount].tips
            }
        }
        
    }    

}
