//
//  TDTHomeViewCtlr.swift
//  TDT
//
//  Created by Kevin on 6/13/16.
//  Copyright © 2016 R. Kevin Ryan. All rights reserved.
//

import UIKit

class TDTHomeViewCtlr: UIViewController {
    
    @IBAction func startDay(_ sender: UIButton) {
        // * create "today's" log file, using DATE stamp for current day
        // * save "yesterday's" log file
        // * use current TZ as starting TZ for the day (end MAY be different,
        //   and there may be other TZs in between, if traveling while logging incremental activities)
        // * on "weird" days, it's possible that "today" started BEFORE 12:00AM in current TZ; allow/support this possibility
        print("start day:  code needed!")
    }
    
    @IBAction func endDay(_ sender: UIButton) {
        // * display how much hB time needed tomorrow to preserve/exceed daily 8d avg mins
        // * save a tentative version of today's log file, subject to revision in AM
        // * record "to-bed" time [and allow adjustment now or later]
        print("end day:  code needed!")    }
    
    
    @IBAction func updateSettings(_ sender: UIButton) {
        // FIXME:  this is crummy code; here just as a starting point
        // FIXME:  add a setting for 'new' user to be prompted for categ/duration
        let settingsRead =
            UIApplication.shared.openURL(URL(string:UIApplicationOpenSettingsURLString)!)
        
        /*
        let appDefaults = [String:AnyObject]()
        NSUserDefaults.standardUserDefaults().registerDefaults(appDefaults)
        */
        
        let d = UserDefaults.standard.dictionaryRepresentation()
        for k in d.keys {
            if k.hasSuffix("_preference") {
                print("(key, value) = (\(k), \(d[k]))")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

