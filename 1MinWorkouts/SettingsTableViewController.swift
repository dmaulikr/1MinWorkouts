//
//  SettingsTableViewController.swift
//  1MinWorkouts
//
//  Created by Justin on 1/14/15.
//  Copyright (c) 2015 Good Enough LLC. All rights reserved.
//

import UIKit
import MessageUI

class SettingsTableViewController: UITableViewController, MFMailComposeViewControllerDelegate, BWWalkthroughViewControllerDelegate {

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
        }else{
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

    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        
//    }
    
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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */


}
