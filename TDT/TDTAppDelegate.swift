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
    func openLogFileAndSetGlobals() {
        print(#function + " called")
        // FIXME:  must be ONLY a datestamp, because app may fully exit then restart on same day;
        let df = DateFormatter()
        df.dateFormat = "yyyy_MMdd"
        let date = Date(timeIntervalSinceNow: TimeInterval(0))
        let dateStringForToday = df.string(from: date)
        let fn = "logTDT_" + dateStringForToday + ".txt"
        
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
        print("log file path:\n" + path)
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
        fh.seekToEndOfFile() // to ensure append(ing) vs. overwriting
        TDTAppDelegate.globals = TDTAppStateVars(logFileName: fn, logFileHandle: fh,
                                  logFilePath: path, logFileURL: fp,
                                  logFileIsOpen: true,
                                  today: date   // FIXME:  need to normalize to local timezone (vs. GMT)
                                  // , activitiesList: [TDTActivity](),
                                  // activsTableView: UITableView()
                                )
        print("placeholder")
    }
    
    func closeLogFile() {
        print(#function + " called")
        guard var g = TDTAppDelegate.globals else { return }
        guard g.logFileIsOpen else { return }
        if let fh = g.logFileHandle {
            print("...closing log file...")
            fh.closeFile()
            // FIXME:  what else should be UNset/cleared here?
            g.logFileIsOpen = false
            g.logFileName = "NO_LOG_FILE_OPEN"
            g.logFileHandle = nil
            g.logFilePath = "NO_LOG_FILE_PATH"
            g.logFileURL = nil
        }
    }

    
    // MARK: App Lifecycle Methods
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
                launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        print(#function + " called")
        let state = UIApplication.shared.applicationState
        print("...app state at launch:" + String(describing: state))
        openLogFileAndSetGlobals()
        return true // returning false is ignored, anyway, correct???
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // FIXME: write any uncommitted activ/exp record(s) first to local DB
        // FIXME:  closing file in appDidEnterBkgrd may be sufficient/preferable
        print(#function + " called")
        closeLogFile()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        print(#function + " called")
        closeLogFile()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        print("\(type(of: self)).\(#function) called; RE-OPEN FILE if not already open")
        if !TDTAppDelegate.globals!.logFileIsOpen {
            TDTAppDelegate.globals!.logFileHandle = FileHandle(forUpdatingAtPath:TDTAppDelegate.globals!.logFilePath)!
            TDTAppDelegate.globals!.logFileIsOpen = true
        }
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        print(#function + " called")
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
        print(#function + " called")
        // FIXME: write any uncommitted record(s) first
        closeLogFile()
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
