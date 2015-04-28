//
//  SettingsDetailViewController.swift
//  1MinWorkouts
//
//  Created by Justin on 1/14/15.
//  Copyright (c) 2015 Good Enough LLC. All rights reserved.
//

import UIKit

class SettingsDetailViewController: UIViewController , UITableViewDataSource  {
    
    //var settingsSet = GlobalVars.settingsSet
    
    @IBOutlet var startDayReminderView: UIView!
    @IBOutlet var startDayToggle: UISwitch!
    @IBOutlet var startDayPicker: UIDatePicker!
    
    @IBOutlet var autoEndDayView: UIView!
    @IBOutlet var autoEndDayPicker: UIDatePicker!
    
    @IBOutlet var aboutView: UIView!
    
    let settingsStartDay = [
        ("Monday - Friday"),
        ("Saturday and Sunday")
    ]
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return settingsStartDay.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("checkedCells", forIndexPath: indexPath) as! UITableViewCell
        
           let (settingsTitle) = settingsStartDay[indexPath.row]
            cell.textLabel?.text = settingsTitle
        
        return cell
    }

    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        
        let cell: UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        if cell.accessoryType == UITableViewCellAccessoryType.None {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        } else {
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        println("You selected cell #\(indexPath.row)!")
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
