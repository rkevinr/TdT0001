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
    @IBOutlet weak var durationStackVw: UIStackView!
    @IBOutlet weak var durationMinsTextFld: UITextField!
    @IBOutlet weak var durEditingToolbar: UIToolbar!
    
    let DEV_HEIGHT_iPh4S: CGFloat = 480.0
    let LHS_INSET_RGLR_HORIZ_SZ_CLS: CGFloat = 80.0

    func checkScreenHeight() {
        let scrn = UIScreen.mainScreen()
        if scrn.traitCollection.verticalSizeClass == .Regular &&
                scrn.bounds.height > DEV_HEIGHT_iPh4S {
            activityTextFld.autocorrectionType = .Yes
        } else {
            activityTextFld.autocorrectionType = .No
        }
        
        if scrn.traitCollection.horizontalSizeClass == .Regular {
            activityTextFld.bounds =
                CGRect(
                    origin: CGPoint(
                        x: scrn.bounds.origin.x + LHS_INSET_RGLR_HORIZ_SZ_CLS,
                        y: activityTextFld.bounds.origin.y
                    ),
                    size: CGSize(
                        width: scrn.bounds.width - LHS_INSET_RGLR_HORIZ_SZ_CLS,
                        height: activityTextFld.bounds.height
                    )
                )
        }
    }
    
    func addMenuItemToTextField() {
        // FIXME:  add stuff for copying selection to known words/phrases list
        print("\(self.dynamicType).\(#function) called")
        guard let items = UIMenuController.sharedMenuController().menuItems else {
            return
        }
        items.forEach {
            print("    item: \($0)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkScreenHeight()
        addMenuItemToTextField()
        activityTextFld.becomeFirstResponder()
        durationMinsTextFld.inputAccessoryView = durEditingToolbar
    }
    
    override func viewWillTransitionToSize(size: CGSize,
                        withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        checkScreenHeight()
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
    
    @IBAction func textEntryDone(sender: UITextField) {
        let tf = sender
        print("input:  \(tf.text!)")
        
        // FIXME: even w/o sel, both "lets" succeed?  need better logic here
        guard let r = tf.selectedTextRange else {return }
        guard let substr = tf.textInRange(r) else {return }
        print("    selected:  [\(substr)]")
        
    }
    
}
