//
//  WorkoutsTableViewController.swift
//  1MinWorkouts
//
//  Created by Justin Spirent on 1/12/17.
//  Copyright © 2017 Good Enough LLC. All rights reserved.
//

import UIKit

class WorkoutsTableViewController: UITableViewController {
    
    // defines the data structure for the content of each table cell
    struct cellData {
        let cell : Int!
        let titleText : String!
        let nextWorkoutText : String!
        let BGImage : UIImage!
    }
    
    // creates an array to hold the content for each of the table cells
    var arrayOfCellData = [cellData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // sets the navbar background color and font color
        navigationController?.navigationBar.barTintColor = UIColor(red:0.53, green:0.73, blue:0.85, alpha:1.00)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        // creates an invisible footer that hides the empty table dividers
        tableView.tableFooterView = UIView(frame: .zero)
        
        // defines the content in the array for each of the table cells
        arrayOfCellData = [cellData(cell : 1, titleText : "Upper Body", nextWorkoutText : "Strength/Cardio - 7 mins", BGImage: #imageLiteral(resourceName: "UpperBody-7mins")),
                           cellData(cell : 1, titleText : "Lower Body", nextWorkoutText : "Strength/Cardio - 7 mins", BGImage: #imageLiteral(resourceName: "LowerBody-7mins")),
                           cellData(cell : 1, titleText : "7 Minute Workout", nextWorkoutText : "Strength/Cardio", BGImage: #imageLiteral(resourceName: "7MinWorkouts")),
                           cellData(cell : 1, titleText : "7 Minute Tabata", nextWorkoutText : "Strength/Cardio", BGImage: #imageLiteral(resourceName: "7MinTabata"))]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayOfCellData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if arrayOfCellData[indexPath.row].cell == 1{
            let cell = Bundle.main.loadNibNamed("WorkoutsTableViewCell", owner: self, options: nil)?.first as! WorkoutsTableViewCell
            
            cell.BGImageView.image = arrayOfCellData[indexPath.row].BGImage
            cell.TitleLabel.text = arrayOfCellData[indexPath.row].titleText
            cell.LastWorkoutLabel.text = arrayOfCellData[indexPath.row].nextWorkoutText
            
            return cell
        }else{
            let cell = Bundle.main.loadNibNamed("WorkoutsTableViewCell", owner: self, options: nil)?.first as! WorkoutsTableViewCell
            
            cell.BGImageView.image = arrayOfCellData[indexPath.row].BGImage
            cell.TitleLabel.text = arrayOfCellData[indexPath.row].titleText
            cell.LastWorkoutLabel.text = arrayOfCellData[indexPath.row].nextWorkoutText
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if arrayOfCellData[indexPath.row].cell == 1{
            return 95
        }else{
            return 95
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
