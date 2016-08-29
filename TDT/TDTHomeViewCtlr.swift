//
//  TDTHomeViewCtlr.swift
//  TDT
//
//  Created by Kevin on 6/13/16.
//  Copyright © 2016 R. Kevin Ryan. All rights reserved.
//

import UIKit

class TDTHomeViewCtlr: UIViewController {
    
    @IBAction func updateSettings(sender: UIButton) {
        // FIXME:  this is crummy code; here just as a starting point
        // FIXME:  add a setting for 'new' user to be prompted for categ/duration
        let settingsRead =
            UIApplication.sharedApplication().openURL(NSURL(string:UIApplicationOpenSettingsURLString)!)
        
        /*
        let appDefaults = [String:AnyObject]()
        NSUserDefaults.standardUserDefaults().registerDefaults(appDefaults)
        */
        
        let d = NSUserDefaults.standardUserDefaults().dictionaryRepresentation()
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

