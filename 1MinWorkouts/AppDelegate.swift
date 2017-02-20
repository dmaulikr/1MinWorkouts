//
//  AppDelegate.swift
//  1MinWorkouts
//
//  Created by Justin on 12/29/14.
//  Copyright (c) 2014 Good Enough LLC. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        let actionOne = UNNotificationAction(identifier: "snoozeNotif", title: "5 Min Snooze", options: [])
        let actionTwo = UNNotificationAction(identifier: "skip", title: "Skip Workout", options: [])
        let category = UNNotificationCategory(identifier: "myCategory", actions: [actionOne, actionTwo], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        return true
    }
    
    // creates a notification for next hourly workout
    func scheduleNotificationNextWorkout(at date: Date) {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents(in: .current, from: date)
        let newComponents = DateComponents(calendar: calendar, timeZone: .current, month: components.month, day: components.day, hour: components.hour, minute: components.minute)
//        let newComponents = DateComponents(hour: components.hour, minute: components.minute)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: newComponents, repeats: true) // repeats every hour
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3600, repeats: true) // interval trigger to show a notification every hour
        
        let content = UNMutableNotificationContent()
        content.body = "It's time for a 1MinuteWorkout!"
        content.sound = UNNotificationSound.default()
        content.categoryIdentifier = "myCategory"
        
        let request = UNNotificationRequest(identifier: "textNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests() //  removes/clears all pending notification request
        UNUserNotificationCenter.current().add(request) {(error) in
            if let error = error {
                print("Uh oh! We had an error: \(error)")
            }
        }
    }
    
    // allows the app to save state
    func application(_ application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
        return true
    }
    
    // allows the app to retore state
    func application(_ application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
        return true
    }
}


extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if response.actionIdentifier == "snoozeNotif" {
            let newDate = Date(timeInterval: 300, since: Date()) // sets the reminder notifcation to occur in (300)5 mins from original notification time
            scheduleNotificationNextWorkout(at: newDate)
            print("the new notif is in \(newDate)")
        }else if response.actionIdentifier == "skip" {
            let newDate = Date(timeInterval: 3600, since: Date()) // sets the reminder notifcation to occur in an (3600)hour from original notification time
            scheduleNotificationNextWorkout(at: newDate)
            print("the new notif is in \(newDate)")
        }
    }
}
