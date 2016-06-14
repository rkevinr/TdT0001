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

struct TDTActivity {
    let description: String
    let valueCategory:  ValueCategory
    let startTime: String // NSDate representation as String?
    let durationMinutes: Int
    
}

/*
var a1 = TDTActivity(description: "random activity",
                     valueCategory: ValueCategory.Ne,
                     startTime: "Tue Jun 14 12:19:37 CDT 2016",
                     durationMinutes: 15)
print(a1.valueCategory.rawValue)
*/

