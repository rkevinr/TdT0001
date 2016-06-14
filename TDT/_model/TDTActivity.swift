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
    let valueCateg:  ValueCategory
    let startTime: String // NSDate representation as String?
    let durationMinutes: Int
    
}
