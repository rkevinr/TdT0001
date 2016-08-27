//
//  TDTActivChgStartTimeVCtlr.swift
//  TDT
//
//  Created by Kevin on 8/4/16.
//  Copyright © 2016 R. Kevin Ryan. All rights reserved.
//

import UIKit

class TDTActivChgStartTimeVCtlr: UIViewController {
    @IBOutlet weak var dateTimePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let navBar = self.navigationController else { return }
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            navBar.navigationBarHidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissPopover(sender: UIButton) {
        let parent = self.presentingViewController!
        // TODO: why can't dynamicType (vs. specific class name) be used for typecast?
        (parent as! TDTActivityViewCtlr).updateStartTime(dateTimePicker.date)
        parent.dismissViewControllerAnimated(true, completion: nil)
    }
}
