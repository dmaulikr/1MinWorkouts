//
//  TutorialXIBViewController.swift
//  1MinWorkouts
//
//  Created by Justin Spirent on 3/23/15.
//  Copyright (c) 2015 Good Enough LLC. All rights reserved.
//

import UIKit

class TutorialXIBViewController: UIViewController, BWWalkthroughViewControllerDelegate {
   
    @IBOutlet var disclaimerView: UIView!
    @IBOutlet var disclaimerText: UITextView!
    
    @IBAction func agreeToDisclaimerButton(sender: AnyObject) {
        
        var alert = UIAlertController(title: "Are You Sure?", message: "Having read the disclaimer in its entirity, you're sure you agree to it?", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes, I Agree", style: .Default, handler: {
            (action: UIAlertAction!) in
            
            self.setDisclaimerAgreed()
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    // sets the disclaimer setting
    func setDisclaimerAgreed(){
        
        // set oobeDisclaimer to true (agreed on)
        let appUserSettings = NSUserDefaults.standardUserDefaults() // instantiates a user default holder
        
        appUserSettings.setBool(true, forKey: GlobalVars.oobeDisclaimer)
        println("oobeDisclaimer was set to \(appUserSettings.valueForKey(GlobalVars.oobeDisclaimer))")
        
        // Get view controllers, build and show the walkthrough
        let stb = UIStoryboard(name: "Walkthrough", bundle: nil)
        let walkthrough = stb.instantiateViewControllerWithIdentifier("walk0") as BWWalkthroughViewController
        let page_one = stb.instantiateViewControllerWithIdentifier("walk1") as UIViewController
        let page_two = stb.instantiateViewControllerWithIdentifier("walk2") as UIViewController
        let page_three = stb.instantiateViewControllerWithIdentifier("walk3") as UIViewController
        let page_four = stb.instantiateViewControllerWithIdentifier("walk4") as UIViewController
        
        // Attach the pages to the master
        walkthrough.delegate = self
        walkthrough.addViewController(page_one)
        walkthrough.addViewController(page_two)
        walkthrough.addViewController(page_three)
        walkthrough.addViewController(page_four)
        
        self.presentViewController(walkthrough, animated: true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        
//        let appUserSettings = NSUserDefaults.standardUserDefaults() // instantiates a user default holder
//        
//        // check to see if oobeDisclaimer has a settings
//        if let disclaimerShown = appUserSettings.stringForKey(GlobalVars.oobeDisclaimer){
//            disclaimerView.hidden = true // hides the disclaimer
//            //tutorialView.hidden = false // shows tutorial
//            println("disclaimer is set to: \(disclaimerShown)")
//            
//        }else{
//            disclaimerView.hidden = false // shows the disclaimer
//            println("oobeDisclaimer is set to \(appUserSettings.valueForKey(GlobalVars.oobeDisclaimer))")
//        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        disclaimerText.sizeToFit() // sets the exerciseDescription label so it will dynamically change size based on text content
        disclaimerText.text =
            "Always consult a qualified medical professional before beginning any nutritional program or exercise program. Never disregard professional medical advice or delay in seeking it because of something you have read in “1MinWorkouts.” Any content or information provided by “1MinWorkouts” is for informational and educational purposes only and any use thereof is solely at your own risk. “1MinWorkouts” Company bears no responsibility thereof. \n\n" +
            "The information contained herein is not intended to be a substitute for professional medical advice, diagnosis or treatment in any manner. Always seek the advice of your physician or other qualified health provider with any questions you may have regarding any medical condition. All information contained in “1MinWorkouts”. including but not limited to text, graphics, images, information, third party information and/or advice, food, recipes, exercises, diets, psychology, websites, links, including but not limited to any content by employees, consultants or writers and contributors, and or any other material contained herein are for informational and educational purposes only. \n\n" +
            "By agreeing and entering the “1MinWorkouts” app the reader and/or viewer does hereby acknowledge that it is your sole responsibility to review this Disclaimer and any other disclaimer or waiver."
        
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
