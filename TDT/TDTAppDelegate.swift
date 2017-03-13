//
//  TDTAppDelegate.swift
//  TDT
//
//  Created by Kevin on 6/13/16.
//  Copyright © 2016 R. Kevin Ryan. All rights reserved.
//

import UIKit

@UIApplicationMain
class TDTAppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static var globals: TDTAppStateVars?
    static var activitiesList: [TDTActivity] = [TDTActivity]()
    static var activsTableView: UITableView?


    class func setTableView(_ view: UITableView) {
        activsTableView = view
    }
    
    // MARK:  app setup/mgmt helper functions
    func openLogFile() {
        // FIXME:  must be ONLY a datestamp, because app may fully exit then restart on same day;
        // FIXME:     (datestamp will match, but PID may NOT)
        let df = DateFormatter()
        df.dateFormat = "yyyy_MMdd"
        let date = Date(timeIntervalSinceNow: TimeInterval(0))
        let dateStringForToday = df.string(from: date)

        let pid = ProcessInfo.processInfo.processIdentifier
        let fn = "logTDT_" + dateStringForToday + "." + String(pid) + ".txt" // FIXME (datestamp ONLY)
        
        guard let dirURL = FileManager.default
                            .urls(
                                for: .documentDirectory,
                                in: .allDomainsMask
                            ).first                                 else {
                print("failed to get directory URL for output file")
                // FIXME:  consider throwing error????
                return
        }
        
        let fp = dirURL.appendingPathComponent(fn)
        let path = fp.path //  fp.absoluteString
        let fm = FileManager.default // FIXME: remove redundancy above
        if fm.fileExists(atPath: path) {
            print("file exists, so ONLY open it")
        } else {
            let fileCreated = fm.createFile(atPath: path, contents: nil,
                                  attributes: [ FileAttributeKey.type.rawValue: FileAttributeType.typeRegular ]
                                )
            var crdate: AnyObject?
            do {
                try crdate = fm.attributesOfItem(atPath: path)[FileAttributeKey.creationDate] as AnyObject?
            } catch {
                print("failed to get logfile-creation date")
            }
            print("file: \(fn) created at \(crdate!)")
        }
        
        var fh: FileHandle
        // FIXME: need better error checking in this section
        fh = FileHandle(forUpdatingAtPath: path)!
        TDTAppDelegate.globals = TDTAppStateVars(logFileName: fn, logFileHandle: fh,
                                  logFilePath: path, logFileURL: fp,
                                  logFileIsOpen: true
                                  // , activitiesList: [TDTActivity](),
                                  // activsTableView: UITableView()
                                )
    }
    
    // MARK: App Lifecycle Methods
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       // print("\(self.dynamicType).\(#function) called; create/open output FILE")
        openLogFile()
        return true // returning false is ignored, anyway, correct???
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state.
       // print("\(self.dynamicType).\(#function) called; CLOSE FILE [_after_ writing last record]")
        // FIXME:  closing file in appDidEnterBkgrd may be sufficient (doing here may be redundant)
       TDTAppDelegate.globals!.logFileHandle.closeFile()  // FIXME: write any uncommitted record(s) first
       TDTAppDelegate.globals!.logFileIsOpen = false
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
       // print("\(self.dynamicType).\(#function) called; CLOSE FILE [_after_ writing last record]")
       TDTAppDelegate.globals!.logFileHandle.closeFile()  // FIXME: write any uncommitted record(s) first
       TDTAppDelegate.globals!.logFileIsOpen = false
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
       // print("\(self.dynamicType).\(#function) called; RE-OPEN FILE if not already open")
        if !TDTAppDelegate.globals!.logFileIsOpen {
            TDTAppDelegate.globals!.logFileHandle = FileHandle(forUpdatingAtPath:TDTAppDelegate.globals!.logFilePath)!
           TDTAppDelegate.globals!.logFileIsOpen = true
        }
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        if !TDTAppDelegate.globals!.logFileIsOpen {
            TDTAppDelegate.globals!.logFileHandle = FileHandle(forUpdatingAtPath:TDTAppDelegate.globals!.logFilePath)!
           TDTAppDelegate.globals!.logFileIsOpen = true
        }
    }
    
    func applicationSignificantTimeChange(_ application: UIApplication) {
        print("\(type(of: self)).\(#function) called;\n  " +
                "TODO:  add adjustments based on time/TZ change")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
       // print("\(self.dynamicType).\(#function) called; should CLOSE FILE [_after_ writing last record] ??")
       TDTAppDelegate.globals!.logFileHandle.closeFile()  // FIXME: write any uncommitted record(s) first
       TDTAppDelegate.globals!.logFileIsOpen = false // FIXME: pointless if app will "die" after this?
    }

}

/*
 do {
 }
 catch let err as NSError {
     /* error handling here */
     print("ERROR:   \(err.debugDescription)")
     print("failed to get filehandle for output file")
     return false
 }
*/
