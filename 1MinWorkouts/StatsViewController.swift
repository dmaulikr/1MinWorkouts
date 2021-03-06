//
//  StatsViewController.swift
//  1MinWorkouts
//
//  Created by Justin on 12/29/14.
//  Copyright (c) 2014 Good Enough LLC. All rights reserved.
//

import UIKit
import MessageUI

class StatsViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    let shownTipsSettings = UserDefaults.standard // instantiates a user defaultholder for keeping track of the tips shown or not
    
    @IBOutlet var TipStatsView: UIView!
    @IBAction func CloseTipBtn(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {self.TipStatsView.alpha = 0.0})
        shownTipsSettings.set(true, forKey: "StatsStarterTip")
    }
    
    @IBAction func sendFeedbackBtn(_ sender: AnyObject) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        
        TipStatsView.alpha = 0.0
        // checks to see if Tip has been shown yet
        let tipViewed = shownTipsSettings.bool(forKey: "StatsStarterTip")
        if tipViewed == false{
            UIView.animate(withDuration: 0.5, animations: {self.TipStatsView.alpha = 1.0})
        }else{
            TipStatsView.alpha = 0.0
        }
        
        //enables 1MW tab so user can get back if doing 1MW workouts
        if  let arrayOfTabBarItems = tabBarController?.tabBar.items as AnyObject as? NSArray,let tabBarItem = arrayOfTabBarItems[0] as? UITabBarItem {
            tabBarItem.isEnabled = true
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
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["onemwfeedback@gmail.com"])
        mailComposerVC.setSubject("1MW Statistics Feedback")
        mailComposerVC.setMessageBody("Feedback is great! Trolling, not so great...", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        sendMailErrorAlert.addAction(defaultAction)
        
        present(sendMailErrorAlert, animated: true, completion: nil)
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
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
