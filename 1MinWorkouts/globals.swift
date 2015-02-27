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
    static var workoutNotificationStartHour = 9 // 9AM
    static var workoutNotificationEndHour = 17  // 5PM
    static var endDayNotificationLabel = "\(GlobalVars.workoutNotificationStartHour):50 AM Tomorrow"
}
