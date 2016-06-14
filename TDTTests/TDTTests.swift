//
//  TDTTests.swift
//  TDTTests
//
//  Created by Kevin on 6/13/16.
//  Copyright © 2016 R. Kevin Ryan. All rights reserved.
//

import XCTest
@testable import TDT

class TDTTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
//        var a1 = TDTActivity(description:  "random activity",
//                             valueCategory: ValueCategory.Ne,
//                             startTime: "Tue Jun 14 12:19:37 CDT 2016",
//                             durationMinutes: 15)
//        print(a1.valueCategory.rawValue)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddActivity() {
        var a1 = TDTActivity(description:  "random activity",
                             valueCategory: ValueCategory.Ne,
                             startTime: "Tue Jun 14 12:19:37 CDT 2016",
                             durationMinutes: 15)
        print("**** TDTActivity struct:\n     \(a1)\n************")
        XCTAssert(a1.durationMinutes == 15)
        XCTAssert(a1.valueCategory.rawValue == "Ne")
    }
    
    
    /*
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssert(M_PI == M_PI)
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    */
    
}
