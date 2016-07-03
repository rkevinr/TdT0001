//
//  TDTEditActivityViewCtlr.swift
//  TDT
//
//  Created by Kevin on 6/22/16.
//  Copyright © 2016 R. Kevin Ryan. All rights reserved.
//

import UIKit

class TDTEditActivityViewCtlr: UIViewController
                    /* , UITextFieldDelegate */ {

    
    @IBOutlet weak var activityTextFld: UITextField!
    @IBOutlet weak var durationMinsTextFld: UITextField!
    @IBOutlet weak var durEditingToolbar: UIToolbar!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // activityTextFld.autocorrectionType = .No  // set via IB, instead
        activityTextFld.becomeFirstResponder()
        durationMinsTextFld.inputAccessoryView = durEditingToolbar
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: activity text field methods
    @IBAction func textEntryDone(textField: UITextField) {
        print("input:  \(textField.text!)")
    }
    
    /*  NOT USED
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return true
    }
    */
    
}
