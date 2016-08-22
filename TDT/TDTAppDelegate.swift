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
    var globals: TDTAppStateVars?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        print("\(self.dynamicType).\(#function) called; create/open output FILE")
        
        let pid = NSProcessInfo.processInfo().processIdentifier
        print("process ID:  \(pid)")
        let fn = "logTDT_AddDateStampASAP." + String(pid) + ".txt"  // FIXME (datestamp)

        guard let dirURL = NSFileManager.defaultManager()
                            .URLsForDirectory(
                                .DocumentDirectory,
                                inDomains: .AllDomainsMask
                            ).first                                 else {
            print("failed to get directory URL for output file")
            return false
        }
        
        // let fp = NSURL(fileURLWithPath: dir).URLByAppendingPathComponent(fn)
        let fp = dirURL.URLByAppendingPathComponent(fn)
        print("fp = \(fp)")
        
        let fm = NSFileManager.defaultManager() // FIXME: remove redundancy above
        let path = fp.path //  fp.absoluteString
        if fm.fileExistsAtPath(path!) {
            print("file exists, so ONLY open it")
        } else {
            print("file DOESN'T exist, so CREATE it now...")
            print("path = \(path)")
            let fileCreated = fm.createFileAtPath(path!, contents: nil,
                                attributes: [
                                    // NSFileAppendOnly : true,
                                    NSFileType: NSFileTypeRegular
                                    ] )
            print("file creation result:  \(fileCreated)")
        }
        
        var fh: NSFileHandle
        do {
            // FIXME: need better error checking in this section
            fh =  try NSFileHandle(forUpdatingAtPath: path!)!
            //writing
                let sampleText = "some more text: \(pid)"
                print("sample text = \(sampleText)")
                do {
                    try sampleText.writeToURL(fp, atomically: false, encoding: NSUTF8StringEncoding)
                }
                catch let err as NSError {
                    /* error handling here */
                    print("ERROR:  \(err.localizedDescription)")
                }
            // globals = TDTAppStateVars(logFileName: fn, logFileHandle: fh)
        }
        catch let err as NSError {
            /* error handling here */
            print("ERROR:   \(err.debugDescription)")
            print("failed to get filehandle for output file")
            return false
        }
        print("filehandle = \(fh)")
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        print("\(self.dynamicType).\(#function) called; CLOSE FILE")
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        print("\(self.dynamicType).\(#function) called; CLOSE FILE")
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        print("\(self.dynamicType).\(#function) called; RE-OPEN FILE")
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        print("\(self.dynamicType).\(#function) called; RE-OPEN FILE")
    }
    
    func applicationSignificantTimeChange(application: UIApplication) {
        print("\(self.dynamicType).\(#function) called;\n  " +
                "TODO:  add adjustments based on time/TZ change")
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        print("\(self.dynamicType).\(#function) called")
    }

}
