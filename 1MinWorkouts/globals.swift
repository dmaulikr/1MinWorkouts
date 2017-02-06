//
//  globals.swift
//  1MinWorkouts
//
//  Created by Justin on 1/6/15.
//  Copyright (c) 2015 Good Enough LLC. All rights reserved.
//

import Foundation

struct GlobalVars {
    static var exerciseGroup = false
    static var exerciseSecondsCount = 0
    static var settingsSet = ""
    static var startTime = ""
    
    // sets the arrays for the 1MW exercise info
    static var exerciseUB = [Exercise]()
    static var exerciseLB = [Exercise]()
    static var exerciseCore = [Exercise]()
    static var exerciseIndexCount = 0
    
    // sets the arrays for the Workouts exercise info
    static var workoutsUB = [Exercise]()
    static var workoutsLB = [Exercise]()
    static var workouts7M = [Exercise]()
    static var workouts7T = [Exercise]()
    static var workoutsIndexCount = 0 // used for Workouts start page table
    static var nextExerciseSecondsCount = 0
    
    static var appVersion = "Version 0.1.0 (beta)"
    
    //static var appUserSettings: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    static var workoutNotificationStartHour = 8     // will get overriden at app launch
    static var workoutNotificationStartMin = 30     // will get overriden at app launch
    static var notificationSettingsWeekday = true   // will get overriden at app launch
    static var notificationSettingsWeekend = false  // will get overriden at app launch
    
    static var workoutNotificationCategory = "WORKOUT-NOW_CATEGORY"
    static var workoutNotificationLabel = "\(workoutNotificationStartHour):50 AM"
    static var notificationDayOfWeek = "monday"
    
    //NSUserDefaults Keys
    static let oobeTute = "oobeTute"
    static let oobeDisclaimer = "oobeDisclaimer"
    static let oobeStartDaySetup = "oobeStartDaySetup"
    
    static let startDayHour = "startDayHour"
    static let startDayMin = "startDayMin"
    static let notificationWeekday = "notificationWeekday"
    static let notificationWeekend = "notificationWeekend"
    
    // Last Workout Label Keys
    static var UBLabel = true
    static var LBLabel = true
    static var ACLabel = true
    static var lastWorkoutDate = "Start Here!"
    
    static var whyNotificationsAlert = false // starts as true to show the alert
}

func setNotifVars(){
    let appUserSettings = UserDefaults.standard // instantiates a user default holder
    GlobalVars.workoutNotificationStartHour = appUserSettings.integer(forKey: "startDayHour") as Int!
    GlobalVars.workoutNotificationStartMin = appUserSettings.integer(forKey: "startDayMin") as Int!
    GlobalVars.notificationSettingsWeekday = appUserSettings.bool(forKey: "notificationWeekday") as Bool!
    GlobalVars.notificationSettingsWeekend = appUserSettings.bool(forKey: "notificationWeekend") as Bool!
    print("sets GlobalVars to: \(GlobalVars.workoutNotificationStartHour):\(GlobalVars.workoutNotificationStartMin) | \(GlobalVars.notificationSettingsWeekday) | \(GlobalVars.notificationSettingsWeekend)")
}

