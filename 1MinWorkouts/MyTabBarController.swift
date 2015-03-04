//
//  MyTabBarController.swift
//  1MinWorkouts
//
//  Created by Justin on 2/6/15.
//  Copyright (c) 2015 Good Enough LLC. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.tintColor = UIColor(red:0.51, green:0.74, blue:0.87, alpha:1)
        
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
