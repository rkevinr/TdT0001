//
//  TDTActivity.swift
//  TDT
//
//  Created by Kevin on 6/13/16.
//  Copyright © 2016 R. Kevin Ryan. All rights reserved.
//

import Foundation

enum ValueCategory: String {
    case B = "B"
    case Ne = "Ne"
    case NB = "NB"
    case SL = "SL"
}

let defaultValueCategory = ValueCategory.Ne

struct TDTActivity {
    let description: String
    let valueCategory:  ValueCategory
    let durationMinutes: Int
    let startTime: NSDate // NSDate representation as String?
 
    init(_ description: String = "[empty]",
            valueCategory: ValueCategory = defaultValueCategory,
            durationMins: Int = 15,
            startTime: NSDate = NSDate(timeIntervalSinceNow: 0) ) {
        
        self.description = description
        self.valueCategory = valueCategory
        self.durationMinutes = durationMins
        self.startTime = startTime
    }
}

/*
var a1 = TDTActivity(description: "random activity",
                     valueCategory: ValueCategory.Ne,
                     startTime: "Tue Jun 14 12:19:37 CDT 2016",
                     durationMinutes: 15)
print(a1.valueCategory.rawValue)
*/

