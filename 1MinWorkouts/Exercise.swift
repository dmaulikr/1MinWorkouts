//
//  Exercise.swift
//  1MinWorkouts
//
//  Created by Justin on 1/6/15.
//  Copyright (c) 2015 Good Enough LLC. All rights reserved.
//

import Foundation

struct Exercise {
    var name : String
    var filename : String
    var meterFilename : String
    var tips : String
    
    func workout() -> String{
        return("The first workout is \(name) and has an image called \(filename). The workout tips are \(tips). With a meter image called \(meterFilename)")
    }
}

