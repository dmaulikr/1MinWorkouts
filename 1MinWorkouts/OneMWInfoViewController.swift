//
//  OneMWInfoViewController.swift
//  1MinWorkouts
//
//  Created by Justin on 1/6/15.
//  Copyright (c) 2015 Good Enough LLC. All rights reserved.
//

import UIKit

class OneMWInfoViewController: UIViewController {

    var exerciseTitle = ""
    var exerciseTips = ""
    
    @IBAction func closeInfoBtn(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet var exerciseTypeTitle: UILabel!
    @IBOutlet var exerciseDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exerciseDescription.sizeToFit() // sets the exerciseDescription label so it will dynamically change size based on text content
        
        exerciseDescription.text = exerciseTips
        exerciseTypeTitle.text = exerciseTitle

        
//        if GlobalVars.exerciseGroup == true{ // reversed from start page because once it leaves that pages it's set to the alternate bool
//            // preloads the first UB exercise content
//            exerciseTypeTitle.text = GlobalVars.exerciseUB[GlobalVars.exerciseIndexCount].name
//            exerciseDescription.text = GlobalVars.exerciseUB[GlobalVars.exerciseIndexCount].tips
//            
//        }else{            
//            // preloads the first UB exercise content
//            exerciseTypeTitle.text = GlobalVars.exerciseLB[GlobalVars.exerciseIndexCount].name
//            exerciseDescription.text = GlobalVars.exerciseLB[GlobalVars.exerciseIndexCount].tips
//        }

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
