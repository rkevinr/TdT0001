//
//  TDTActivChgStartTimeVCtlr.swift
//  TDT
//
//  Created by Kevin on 8/4/16.
//  Copyright © 2016 R. Kevin Ryan. All rights reserved.
//

import UIKit

class TDTActivChgStartTimeVCtlr: UIViewController {

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
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
