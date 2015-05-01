//
//  AboutViewController.swift
//  1MinWorkouts
//
//  Created by Justin Spirent on 5/1/15.
//  Copyright (c) 2015 Good Enough LLC. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet var aboutLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        aboutLabel.text = GlobalVars.appVersion
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
