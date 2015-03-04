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
    
    static var workoutNotificationStartHour = 8 // set by the user at start up
    static var workoutNotificationStartMin = 30 // set by the user at start up
    static var workoutNotificationCategory = "WORKOUT-NOW_CATEGORY"
    static var workoutNotificationLabel = "\(workoutNotificationStartHour):50 AM"
    static var notificationDayOfWeek = "monday"
    static var notificationSettingsWeekday = true
    static var notificationSettingsWeekend = false
}
