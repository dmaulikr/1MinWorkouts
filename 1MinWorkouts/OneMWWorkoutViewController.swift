//
//  OneMWWorkoutViewController.swift
//  1MinWorkouts
//
//  Created by Justin on 1/6/15.
//  Copyright (c) 2015 Good Enough LLC. All rights reserved.
//

import UIKit
import AudioToolbox

protocol OneMWWorkoutViewControllerDelegate{
    func myVCDidFinish(controller:OneMWWorkoutViewController,indexCount:Int)
}

class OneMWWorkoutViewController: UIViewController {
    
    var delegate:OneMWWorkoutViewControllerDelegate? = nil
    var exerciseTitle = ""
    var exerciseImage = UIImage(named: "")
    var navTitle = ""
    var exercisesCount = 0
    
    var exerciseCountdownTimer = NSTimer()
    //var exerciseSecondsCount = 0
    var totalTime = 0
    
    @IBOutlet var startWorkoutBtn: UILabel!
    @IBOutlet var getReadyCounterLabel: UILabel! // label that counts down from 5 to the workout
    @IBOutlet var getReadyView: UIVisualEffectView!
    @IBOutlet var workoutCountdownLabel: UILabel! // label that counts down from 60 for the workout
    @IBOutlet var exerciseTypeTitle: UILabel!
    @IBOutlet var exerciseTypeImage: UIImageView!
    @IBOutlet var closeWorkoutBtnLabel: UIButton!
    
    @IBAction func closeWorkoutBtn(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
        exerciseCountdownTimer.invalidate()
        
        // increments the index variable to update to the next exercise
        changeExercise()
        println("incremented exercise index to \(GlobalVars.exerciseIndexCount)")
        
        // passes the incremented variable to the prior screen delegate
        if (delegate != nil) {
            delegate!.myVCDidFinish(self, indexCount: GlobalVars.exerciseIndexCount)
            println("\(GlobalVars.exerciseIndexCount) was saved to delegate")
        }
    }
    
    @IBAction func startWorkoutBtn(sender: AnyObject) {
        startWorkoutBtn.hidden = true
        getReadyView.hidden = false
        workoutCountdownLabel.hidden = false
        
        exerciseCountdownTimer.invalidate()
        setExerciseTimerGetReady(5, timerLabel: "5")
    }
        
    func changeExercise(){
        if GlobalVars.exerciseIndexCount == 7{
            println("exercise index started over")
            return GlobalVars.exerciseIndexCount = 0
        }else{
            var newCount = GlobalVars.exerciseIndexCount
            newCount++
            return GlobalVars.exerciseIndexCount = newCount
        }
    }
    
    /////////////////////// method that does the counting down for the 60 seconds timer ///////////////////////////////
    func exerciseTimerRun(){
        GlobalVars.exerciseSecondsCount-- // decreases the count down by 1
        var minutes = (GlobalVars.exerciseSecondsCount / 60) // converts the seconds into minute format
        var seconds = (GlobalVars.exerciseSecondsCount - (minutes * 60)) // converts the seconds back to seconds
        
        let timerOutput = String(format:"%.2d", seconds) // defines the output that is placed on the label
        workoutCountdownLabel.text = timerOutput
        
        // what happens when the timer ends
        if (GlobalVars.exerciseSecondsCount == 0) {
            exerciseCountdownTimer.invalidate() // stops the countdown
            
            
            // increments the index variable to update to the next exercise
            changeExercise()
            println("incremented exercise index to \(GlobalVars.exerciseIndexCount)")
            
            // passes the incremented variable to the prior screen delegate
            if (delegate != nil) {
                delegate!.myVCDidFinish(self, indexCount: GlobalVars.exerciseIndexCount)
                println("\(GlobalVars.exerciseIndexCount) was saved to delegate")
            }
            
            // sends an alert when timer is up
            func gotoWorkoutVC(){
                let vc = OneMWWorkoutViewController(nibName: "OneMWWorkoutViewController", bundle: nil)
                navigationController?.pushViewController(vc, animated: true)
            }
            
            var alert = UIAlertController(title: "Nice Job!", message: "\n\n\nTake an hour break!", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: {
                (action: UIAlertAction!) in
                
                // passes the incremented variable to the prior screen delegate
                if (self.delegate != nil) {
                    self.delegate!.myVCDidFinish(self, indexCount: GlobalVars.exerciseIndexCount)
                    println("\(GlobalVars.exerciseIndexCount) was saved to delegate")
                }
                self.dismissViewControllerAnimated(true, completion: nil)
            }))
            
            let thumbsImage = UIImage(named: "thumbs-up")
            var imageView = UIImageView(frame: CGRectMake(117, 47, 40, 40))
            imageView.image = thumbsImage
            
            alert.view.addSubview(imageView)
            
            self.presentViewController(alert, animated: true, completion: nil)
            
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate)) // sends vibrate when workout is done
        }
    }
    
    // method that defines the actual timer for minute exercise timer
    func setExerciseTimer(timerTime : Int, timerLabel : String){
        
        totalTime = timerTime // sets the timer to starting time desired
        
        workoutCountdownLabel.text = timerLabel // sets timer label to starting time desired
        
        GlobalVars.exerciseSecondsCount = totalTime; // sets timer to an hour
        exerciseCountdownTimer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("exerciseTimerRun"), userInfo: nil, repeats: true) // sets the timer interval to 1.0 seconds and uses the timerRun method as the countdown
    }
    
    /////////////////////// method that does the counting down for the 5 seconds get ready timer ///////////////////////////////
    func exerciseTimerGetReady(){
        GlobalVars.exerciseSecondsCount-- // decreases the count down by 1
        var minutes = (GlobalVars.exerciseSecondsCount / 60) // converts the seconds into minute format
        var seconds = (GlobalVars.exerciseSecondsCount - (minutes * 60)) // converts the seconds back to seconds
        
        let timerOutput = String(format:"%.d", seconds) // defines the output that is placed on the label
        getReadyCounterLabel.text = timerOutput
        
        // what happens when the timer ends
        if (GlobalVars.exerciseSecondsCount == 0) {
            exerciseCountdownTimer.invalidate() // stops the countdown
            
            getReadyView.hidden = true
            setExerciseTimer(60, timerLabel: "60")
        }
    }
    
    // method that defines the actual timer for hour exercise timer
    func setExerciseTimerGetReady(timerTime : Int, timerLabel : String){
        
        totalTime = timerTime // sets the timer to starting time desired
        
        getReadyCounterLabel.text = timerLabel // sets timer label to starting time desired
        
        GlobalVars.exerciseSecondsCount = totalTime; // sets timer to an hour
        exerciseCountdownTimer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("exerciseTimerGetReady"), userInfo: nil, repeats: true) // sets the timer interval to 1.0 seconds and uses the timerRun method as the countdown
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exercisesCount = GlobalVars.exerciseUB.count
        println("exerciseCount is \(exercisesCount)")
        navigationItem.title = navTitle
        exerciseTypeTitle.text = exerciseTitle
        exerciseTypeImage.image = exerciseImage
        
        startWorkoutBtn.hidden = true
        getReadyView.hidden = false
        workoutCountdownLabel.hidden = false
        
        setExerciseTimerGetReady(5, timerLabel: "5")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueToInfo"{
            
            // false = UB objects (default start)  true = LB objects
            if navigationItem.title == "Upper Body"{
                // set up OneMWViewController to show Upper Body stuff
                GlobalVars.exerciseGroup = true
                
                let vc = segue.destinationViewController as! OneMWInfoViewController
                vc.exerciseTitle = GlobalVars.exerciseUB[GlobalVars.exerciseIndexCount].name
                vc.exerciseTips = GlobalVars.exerciseUB[GlobalVars.exerciseIndexCount].tips
            }else{
                // set up OneMWViewController to show Lower Body stuff
                GlobalVars.exerciseGroup = false
                
                let vc = segue.destinationViewController as! OneMWInfoViewController
                vc.exerciseTitle = GlobalVars.exerciseLB[GlobalVars.exerciseIndexCount].name
                vc.exerciseTips = GlobalVars.exerciseLB[GlobalVars.exerciseIndexCount].tips
            }
        }

    }
    

}
