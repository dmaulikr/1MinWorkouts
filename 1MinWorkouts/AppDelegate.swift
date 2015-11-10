//
//  AppDelegate.swift
//  1MinWorkouts
//
//  Created by Justin on 12/29/14.
//  Copyright (c) 2014 Good Enough LLC. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?  

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red:0.51, green:0.74, blue:0.87, alpha:1)], forState:.Selected)
        
        
        // Notification Actions
        let firstAction:UIMutableUserNotificationAction = UIMutableUserNotificationAction()
        firstAction.identifier = "SNOOZE_ACTION"
        firstAction.title = "5 Min Snooze"
        firstAction.activationMode = UIUserNotificationActivationMode.Background
        firstAction.destructive = false
        firstAction.authenticationRequired = false
        
        let secondAction:UIMutableUserNotificationAction = UIMutableUserNotificationAction()
        secondAction.identifier = "SKIP-WORKOUT_ACTION"
        secondAction.title = "Skip Workout"
        secondAction.activationMode = UIUserNotificationActivationMode.Background
        secondAction.destructive = false
        secondAction.authenticationRequired = false
        
//        var thirdAction:UIMutableUserNotificationAction = UIMutableUserNotificationAction()
//        thirdAction.identifier = "THIRD_ACTION"
//        thirdAction.title = "Third Action"
//        thirdAction.activationMode = UIUserNotificationActivationMode.Background
//        thirdAction.destructive = false
//        thirdAction.authenticationRequired = false
        
        
        // Notification Category
        let firstCategory:UIMutableUserNotificationCategory = UIMutableUserNotificationCategory()
        firstCategory.identifier = "WORKOUT-NOW_CATEGORY"

        let defaultActions:NSArray = [firstAction, secondAction]
        let minimalActions:NSArray = [firstAction, secondAction]
        
//        let defaultActions:NSArray = [firstAction, secondAction, thirdAction]
//        let minimalActions:NSArray = [firstAction, secondAction]
        
        /* need to figure out how to fix errors in Swift2 in order to use these
        firstCategory.setActions(defaultActions as [AnyObject] as [AnyObject], forContext: UIUserNotificationActionContext.Default)
        firstCategory.setActions(minimalActions as [AnyObject], forContext: UIUserNotificationActionContext.Minimal)
        */
        // NSSet of all our categories
        let categories:NSSet = NSSet(objects: firstCategory)
        
//        let settings = UIUserNotificationSettings(forTypes: [.Alert, .Badge], categories: nil)
//        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
        
        return true
    }
    
    // To know what notification actions were tapped   
    func application(application: UIApplication, handleActionWithIdentifier identifier:String?, forLocalNotification notification:UILocalNotification, completionHandler: (() -> Void)){
        
        if (identifier == "SNOOZE_ACTION"){
            
            NSNotificationCenter.defaultCenter().postNotificationName("snoozePressed", object: nil)
            
            // need to reset next days start notification
            let today = NSDate()
            let calendar = NSCalendar.currentCalendar()
            let components = calendar.components([.Year, .Month, .Day, .Hour, .Minute, .Second], fromDate: today)
            //let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitMonth | .CalendarUnitYear | .CalendarUnitDay, fromDate: today)
            let hour = components.hour
            let minutes = components.minute
            let month = components.month
            let year = components.year
            let day = components.day
            
            let dateComp:NSDateComponents = NSDateComponents()
            dateComp.year = year            // sets to current year
            dateComp.month = month          // sets to current month
            dateComp.day = day              // sets to today
            dateComp.hour = hour            // sets to current hour
            dateComp.minute = minutes + 5   // sets to users work start time
            dateComp.second = 0
            dateComp.timeZone = NSTimeZone.systemTimeZone()
            
            let calender:NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
            let date:NSDate = calender.dateFromComponents(dateComp)!
            
            let notification:UILocalNotification = UILocalNotification()
            notification.category = "WORKOUT-NOW_CATEGORY"
            notification.alertBody = "Time for a 1 Minute Workout!"
            notification.alertAction = "View App"
            notification.fireDate = date
            notification.soundName = UILocalNotificationDefaultSoundName
            notification.repeatInterval = NSCalendarUnit() // sets when the notification repeats
            
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
            
            print("snooze pressed")
            
        }
        else if (identifier == "SKIP-WORKOUT_ACTION"){
            NSNotificationCenter.defaultCenter().postNotificationName("skipWorkout", object: nil)
            
        }
        
        completionHandler()
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
      
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool{
        // should allow app to perserve state
        return true
    }
    
    func application(application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool{
        // should allow app to perserve state
        return true
    }


}