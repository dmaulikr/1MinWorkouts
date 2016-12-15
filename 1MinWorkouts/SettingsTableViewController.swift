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
    
    @IBAction func sendFeedbackBtn(_ sender: AnyObject) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
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
        let sendMailErrorAlert = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail. Please check the e-mail configuration and try again.", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        sendMailErrorAlert.addAction(defaultAction)
        
        present(sendMailErrorAlert, animated: true, completion: nil)
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (indexPath as NSIndexPath).row == 1 {
            viewWalkthroughCell.isSelected = false
            
            // Get view controllers, build and show the walkthrough
            let stb = UIStoryboard(name: "Walkthrough", bundle: nil)
            let walkthrough = stb.instantiateViewController(withIdentifier: "walk0") as! BWWalkthroughViewController
            let page_one = stb.instantiateViewController(withIdentifier: "walk1") 
            let page_two = stb.instantiateViewController(withIdentifier: "walk2") 
            let page_three = stb.instantiateViewController(withIdentifier: "walk3") 
            let page_four = stb.instantiateViewController(withIdentifier: "walk4") 
            
            // Attach the pages to the master
            walkthrough.delegate = self
            walkthrough.addViewController(page_one)
            walkthrough.addViewController(page_two)
            walkthrough.addViewController(page_three)
            walkthrough.addViewController(page_four)
            
            //walkthrough.closeButton?.setTitle("Done", forState: UIControlState.Normal)
            
            self.present(walkthrough, animated: true, completion: nil)
            
            print("viewWalkthroughCell tapped")
        }
    }
    
    func myVCDidFinish(_ controller: SettingsStartDayTableViewController, text: String) {
        startDayDetailLabel.text = text
       controller.navigationController!.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if segue.identifier == "startDaySettingsSegue"{
            let vc = segue.destination as! SettingsStartDayTableViewController
            vc.startTime = startDayDetailLabel.text!
            vc.delegate = self
        }
    }

}
