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
    static var exerciseIndexCount = 0
    
    static var appUserSettings: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    static var workoutNotificationStartHour = appUserSettings.integerForKey("startDayHour") as Int!           //8 // set by the user at start up
    static var workoutNotificationStartMin = appUserSettings.integerForKey("startDayMin") as Int!             //30 // set by the user at start up
    static var notificationSettingsWeekday = appUserSettings.boolForKey("notificationWeekday") as Bool!    //true
    static var notificationSettingsWeekend = appUserSettings.boolForKey("notificationWeekend") as Bool!    //false
    
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
