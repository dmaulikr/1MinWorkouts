//
//  WorkoutsViewController.swift
//  1MinWorkouts
//
//  Created by Justin on 12/29/14.
//  Copyright (c) 2014 Good Enough LLC. All rights reserved.
//

import UIKit
import AudioToolbox

class WorkoutsViewController: UIViewController {

    var alertTone = UInt32(1481)//1359 double vibrate
    
    @IBAction func findTonesBtn(sender: AnyObject) {
        
        for _ in 1...100 {
            alertTone += 1
            AudioServicesPlaySystemSound(alertTone) // plays haptic no vibration twice when there's 10 secs left in workout
            sleep(2)
            print("\(alertTone)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
