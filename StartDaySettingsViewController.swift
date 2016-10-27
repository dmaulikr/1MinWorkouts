//
//  StartDaySettingsViewController.swift
//  1MinWorkouts
//
//  Created by Justin Spirent on 4/6/15.
//  Copyright (c) 2015 Good Enough LLC. All rights reserved.
//

import UIKit

class StartDaySettingsViewController: UITableViewController{

    var hour = 8
    var min = 30
    var weekday = true
    var weekend = false
    
    @IBOutlet var startDaySwitch: UISwitch!
    @IBAction func startDaySwitch(_ sender: AnyObject) {
        if startDaySwitch.isOn{
            datePickerCell.isHidden = false
            monFriCell.isHidden = false
            satSunCell.isHidden = false
            print("startDaySwitch is on")
        }else{
            datePickerCell.isHidden = true
            monFriCell.isHidden = true
            satSunCell.isHidden = true
            print("startDaySwitch is off")
        }
    }
    
    @IBOutlet var datePickerCell: UITableViewCell!
    @IBOutlet var monFriCell: UITableViewCell!
    @IBOutlet var satSunCell: UITableViewCell!
    @IBOutlet var mfCheckmark: UIImageView!
    @IBOutlet var ssCheckmark: UIImageView!
    @IBOutlet var saveButtonCell: UITableViewCell!
    
    @IBAction func saveSettingsButton(_ sender: AnyObject) {
        print("saveSettingsButton tapped")
        if startDaySwitch.isOn{
            print("startDaySwitch is on")
            
            // save the time, weekday/end settings
            let appUserSettings = UserDefaults.standard // instantiates a user default holder
            
            appUserSettings.set(hour, forKey: GlobalVars.startDayHour)
            print("startDayHour was set to \(appUserSettings.value(forKey: GlobalVars.startDayHour))")
            
            appUserSettings.set(min, forKey: GlobalVars.startDayMin)
            print("startDayMin was set to \(appUserSettings.value(forKey: GlobalVars.startDayMin))")
            
            appUserSettings.set(weekday, forKey: GlobalVars.notificationWeekday)
            print("notificationWeekday was set to \(appUserSettings.value(forKey: GlobalVars.notificationWeekday))")
            
            appUserSettings.set(weekend, forKey: GlobalVars.notificationWeekend)
            print("notificationWeekend was set to \(appUserSettings.value(forKey: GlobalVars.notificationWeekend))")
            
            appUserSettings.set(true, forKey: GlobalVars.oobeStartDaySetup)
            print("notificationWeekend was set to \(appUserSettings.value(forKey: GlobalVars.oobeStartDaySetup))")
            
            appUserSettings.set(true, forKey: GlobalVars.oobeTute)
            print("notificationWeekend was set to \(appUserSettings.value(forKey: GlobalVars.oobeTute))")
            
            // pops back to the root, prior to the disclaimer xib
            let stb = UIStoryboard(name: "Main", bundle: nil)
            let oneMWStart = stb.instantiateViewController(withIdentifier: "TabControllerMain") as! MyTabBarController

            
            self.present(oneMWStart, animated: true, completion: nil)
        }else{
            print("startDaySwitch is off")
            
            //save the weekday/end settings as false
            let appUserSettings = UserDefaults.standard // instantiates a user default holder
            
            appUserSettings.set(false, forKey: GlobalVars.notificationWeekday)
            
            appUserSettings.set(false, forKey: GlobalVars.notificationWeekend)
            
            appUserSettings.set(true, forKey: GlobalVars.oobeStartDaySetup)
            
            appUserSettings.set(true, forKey: GlobalVars.oobeTute)
            
            // pops back to the root, prior to the disclaimer xib
            let stb = UIStoryboard(name: "Main", bundle: nil)
            let oneMWStart = stb.instantiateViewController(withIdentifier: "TabControllerMain") as! MyTabBarController
            
            self.present(oneMWStart, animated: true, completion: nil)
        }
    }
    
    @IBOutlet var startDayPicker: UIDatePicker!
    
    @IBAction func startDayPIcker(_ sender: AnyObject) {
        // sets the hour and min vars to whatever was changed on the startDayPIcker
        hour = sender.hour
        min = sender.minute
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // sets the look of the weekend checkmark to off, which matches the starting var value
        ssCheckmark.image = UIImage(named: "checkmark-off")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (indexPath as NSIndexPath).row == 3 {
            monFriCell.isSelected = false
            
            if mfCheckmark.image == UIImage(named: "checkmark-on"){
                mfCheckmark.image = UIImage(named: "checkmark-off")
                weekday = false
            }else{
                mfCheckmark.image = UIImage(named: "checkmark-on")
                weekday = true
            }
        }
        if (indexPath as NSIndexPath).row == 4 {
            satSunCell.isSelected = false
            
            if ssCheckmark.image == UIImage(named: "checkmark-on"){
                ssCheckmark.image = UIImage(named: "checkmark-off")
                weekend = false
                print("Sat-Sun is set to \(weekend)")
            }else{
                ssCheckmark.image = UIImage(named: "checkmark-on")
                weekend = true
            }
        }
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
