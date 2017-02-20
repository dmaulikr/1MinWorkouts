//
//  WorkoutsInfoViewController.swift
//  1MinWorkouts
//
//  Created by Justin Spirent on 1/16/17.
//  Copyright © 2017 Good Enough LLC. All rights reserved.
//

import UIKit

class WorkoutsInfoViewController: UIViewController {

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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
