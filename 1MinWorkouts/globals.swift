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
    
    static var workoutNotificationHour = workoutNotificationStartHour
    static var workoutNotificationStartHour = 11 // 9AM
    static var workoutNotificationEndHour = 17  // 5PM
    static var workoutNotificationText = "It's time for your first 1 Minute Workout!"
    static var workoutNotificationRepeater = NSCalendarUnit.CalendarUnitDay
}
