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
    
    @IBOutlet var exerciseTypeTitle: UILabel!
    @IBOutlet var switchSidesSubTitle: UILabel!
    @IBOutlet var exerciseTypeImage: UIImageView!
    @IBOutlet var exerciseTypeInfoBtn: UIButton!
    
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func myVCDidFinish(_ controller: ExercisesViewController, indexCount: Int) {
        if navigationItem.title == "Upper Body"{
            let image = UIImage(named: GlobalVars.workoutsUB[indexCount].filename)
            exerciseTypeImage.image = image
            exerciseTypeTitle.text = GlobalVars.workoutsUB[indexCount].name
                        
            //add switch sub-title to needed exercises
            if exerciseTypeTitle.text == "Side Plank"{
                switchSidesSubTitle.isHidden = false
                switchSidesSubTitle.text = "Switch Sides @ 30 Secs"
            }else{
                switchSidesSubTitle.isHidden = true
            }
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
                switchSidesSubTitle.text = "Switch Sides @ 30 Secs"
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
                switchSidesSubTitle.text = "Switch Sides @ 30 Secs"
            }else{
                switchSidesSubTitle.isHidden = true
            }
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
                vc.meterImage = UIImage(named: GlobalVars.workoutsUB[GlobalVars.workoutsIndexCount].meterFilename)
                vc.delegate = self
            }
            if navigationItem.title == "7 Minute Tabata"{
                // set up WorkoutsViewController to show All Core stuff
                GlobalVars.exerciseGroup = false
                
                let vc = segue.destination as! ExercisesViewController
                vc.navTitle = "7 Minute Tabata"
                vc.exerciseTitle = GlobalVars.workouts7T[GlobalVars.workoutsIndexCount].name
                vc.exerciseImage = UIImage(named: GlobalVars.workouts7T[GlobalVars.workoutsIndexCount].filename)
                vc.meterImage = UIImage(named: GlobalVars.workoutsUB[GlobalVars.workoutsIndexCount].meterFilename)
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

//    override func viewWillDisappear(_ animated: Bool) {
//        //resets the arrays index to starting point
//        GlobalVars.workoutsIndexCount = 0
//        
//        print("the indexCount = \(GlobalVars.workoutsIndexCount)")
//    }

}
