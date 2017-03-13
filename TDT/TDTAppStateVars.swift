//
//  TDTAppStateVars.swift
//  TDT
//
//  Created by Kevin on 8/19/16.
//  Copyright © 2016 R. Kevin Ryan. All rights reserved.
//

import UIKit

struct TDTAppStateVars {
    var logFileName: String
    var logFileHandle: FileHandle // FIXME: elim redundant vars here
    var logFilePath: String
    var logFileURL: URL
    var logFileIsOpen: Bool    
}
