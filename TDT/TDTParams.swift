//
//  TDTParams.swift
//  TDT
//
//  Created by Kevin on 6/22/16.
//  Copyright © 2016 R. Kevin Ryan. All rights reserved.
//


// var maxNe = 240   // FIXME: nd better way to assoc w/arbitrary valueCategory

struct TDTParams {
    typealias categKey = String

    // value units are minutes
    var categGoals: [
            categKey: (
                minPercentageOfTotalTime: Int,
                minAbsoluteTime: Int,
                maxAbsoluteTime: Int
            )
        ]
    
}

