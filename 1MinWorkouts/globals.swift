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
    static var exerciseUB = [Exercise]()
    static var exerciseLB = [Exercise]()
    static var exerciseCore = [Exercise]()
    static var exerciseIndexCount = 0
    static var appVersion = "Version 0.0.8c (beta)"
    
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
}

func setNotifVars(){
    let appUserSettings = NSUserDefaults.standardUserDefaults() // instantiates a user default holder
    GlobalVars.workoutNotificationStartHour = appUserSettings.integerForKey("startDayHour") as Int!
    GlobalVars.workoutNotificationStartMin = appUserSettings.integerForKey("startDayMin") as Int!
    GlobalVars.notificationSettingsWeekday = appUserSettings.boolForKey("notificationWeekday") as Bool!
    GlobalVars.notificationSettingsWeekend = appUserSettings.boolForKey("notificationWeekend") as Bool!
    print("sets GlobalVars to: \(GlobalVars.workoutNotificationStartHour) | \(GlobalVars.workoutNotificationStartMin) | \(GlobalVars.notificationSettingsWeekday) | \(GlobalVars.notificationSettingsWeekend)")
}

