//
//  TDTAppStateVars.swift
//  TDT
//
//  Created by Kevin on 8/19/16.
//  Copyright © 2016 R. Kevin Ryan. All rights reserved.
//

import UIKit

// FIXME: elim redundant vars (but keep till best subset determined)

struct TDTAppStateVars {
    var logFileName: String
    var logFileHandle: FileHandle?
    var logFilePath: String
    var logFileURL: URL?
    var logFileIsOpen: Bool
    var today: Date?
    
    init(logFileName: String = "",
         logFileHandle: FileHandle,
         logFilePath: String = "",
         logFileURL: URL,
         logFileIsOpen: Bool = false,
         today: Date? = nil
        ) {
        
        self.logFileName = logFileName
        self.logFileHandle = logFileHandle
        self.logFilePath = logFilePath
        self.logFileURL = logFileURL
        self.logFileIsOpen = logFileIsOpen
        self.today = today
        
    }
}
