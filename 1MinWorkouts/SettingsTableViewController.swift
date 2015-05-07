//
//  SettingsTableViewController.swift
//  1MinWorkouts
//
//  Created by Justin on 1/14/15.
//  Copyright (c) 2015 Good Enough LLC. All rights reserved.
//

import UIKit
import MessageUI

class SettingsTableViewController: UITableViewController, MFMailComposeViewControllerDelegate, BWWalkthroughViewControllerDelegate, SettingsStartDayTableViewControllerDelegate {

    @IBOutlet var startDayDetailLabel: UILabel!
    @IBOutlet var aboutDetailLabel: UILabel!
    @IBOutlet var viewWalkthroughCell: UITableViewCell!
    
    @IBAction func sendFeedbackBtn(sender: AnyObject) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if GlobalVars.workoutNotificationStartHour < 12{
            startDayDetailLabel.text = "\(GlobalVars.workoutNotificationStartHour):\(GlobalVars.workoutNotificationStartMin)AM"
        }else if GlobalVars.workoutNotificationStartHour >= 13{
            startDayDetailLabel.text = "\(GlobalVars.workoutNotificationStartHour - 12):\(GlobalVars.workoutNotificationStartMin)PM"
        }else if GlobalVars.workoutNotificationStartHour == 12{
            startDayDetailLabel.text = "\(GlobalVars.workoutNotificationStartHour):\(GlobalVars.workoutNotificationStartMin)PM"
        }
        
        if GlobalVars.workoutNotificationStartMin < 10{
            startDayDetailLabel.text = "\(GlobalVars.workoutNotificationStartHour):0\(GlobalVars.workoutNotificationStartMin)AM"
        }
        
        if GlobalVars.notificationSettingsWeekday == false && GlobalVars.notificationSettingsWeekend == false{
            startDayDetailLabel.text = "Off"
        }
        
        aboutDetailLabel.text = GlobalVars.appVersion        
    }

    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["onemwfeedback@gmail.com"])
        mailComposerVC.setSubject("1MW Feedback")
        mailComposerVC.setMessageBody("Feedback is great! Trolling, not so great...", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == 1 {
            viewWalkthroughCell.selected = false
            
            // Get view controllers, build and show the walkthrough
            let stb = UIStoryboard(name: "Walkthrough", bundle: nil)
            let walkthrough = stb.instantiateViewControllerWithIdentifier("walk0") as! BWWalkthroughViewController
            let page_one = stb.instantiateViewControllerWithIdentifier("walk1") as! UIViewController
            let page_two = stb.instantiateViewControllerWithIdentifier("walk2") as! UIViewController
            let page_three = stb.instantiateViewControllerWithIdentifier("walk3") as! UIViewController
            let page_four = stb.instantiateViewControllerWithIdentifier("walk4") as! UIViewController
            
            // Attach the pages to the master
            walkthrough.delegate = self
            walkthrough.addViewController(page_one)
            walkthrough.addViewController(page_two)
            walkthrough.addViewController(page_three)
            walkthrough.addViewController(page_four)
            
            //walkthrough.closeButton?.setTitle("Done", forState: UIControlState.Normal)
            
            self.presentViewController(walkthrough, animated: true, completion: nil)
            
            println("viewWalkthroughCell tapped")
        }
    }
    
    func myVCDidFinish(controller: SettingsStartDayTableViewController, text: String) {
        startDayDetailLabel.text = text
        controller.navigationController?.popViewControllerAnimated(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "startDaySettingsSegue"{
            let vc = segue.destinationViewController as! SettingsStartDayTableViewController
            vc.startTime = startDayDetailLabel.text!
            vc.delegate = self
        }
    }

}
