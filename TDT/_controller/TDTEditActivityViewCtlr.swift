//
//  TDTEditActivityViewCtlr.swift
//  TDT
//
//  Created by Kevin on 6/22/16.
//  Copyright © 2016 R. Kevin Ryan. All rights reserved.
//

import UIKit

class TDTEditActivityViewCtlr: UIViewController
                    /* , UITextFieldDelegate */
                    , UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var activityTextFld: UITextField!
    @IBOutlet weak var durationStackVw: UIStackView!
    @IBOutlet weak var durationMinsTextFld: UITextField!
    @IBOutlet weak var durationChanger: UIStepper!
    @IBOutlet weak var durEditingToolbar: UIToolbar!
    @IBOutlet weak var valCategCtrl: UISegmentedControl!
    
    let HEIGHT_iPh4S: CGFloat = 480.0
    let LHS_INSET_RGLR_HORIZ_SZ_CLS: CGFloat = 80.0
    
    let DEFAULT_DURATION = 15.0   // minutes
    let MAX_DURATION = 600.0      // minutes (ten hours)

    
    // var currValCateg = TDTActivity.valueCategory
    
    var currActivText = ""
    var lookupTermsPhrases = [String]()
    
    
    func checkScreenHeight() {
        // FIXME:  INVALID tests; "height" still same after rotation
        let scrn = UIScreen.mainScreen()
        if scrn.traitCollection.verticalSizeClass == .Regular &&
                scrn.bounds.height > HEIGHT_iPh4S {
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
    
    @IBAction func doNothing(sender: AnyObject?) {
        print("\(self.dynamicType).\(#function) called")
    }
    
    func addMenuItemToTextField() {
        // FIXME:  add stuff for copying selection to known words/phrases list
        print("\(self.dynamicType).\(#function) called")
        // FIXME:  this currently returns nil, so probably not active till text field is active?
        /*
        guard let items = UIMenuController.sharedMenuController().menuItems else {
            return
        }
        */
        UIMenuController.sharedMenuController().menuItems = [UIMenuItem]()
        UIMenuController.sharedMenuController().menuItems?.append(
                    UIMenuItem(title: "AddToKB", action: #selector(doNothing)))
        UIMenuController.sharedMenuController().menuItems?.forEach {
            print("    item: \($0)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // print("\(self.dynamicType).\(#function) called")
        checkScreenHeight()
        addMenuItemToTextField()  // FIXME: will this work AFTER text fld becomes 1st responder?
        activityTextFld.becomeFirstResponder()
        
        durationMinsTextFld.inputAccessoryView = durEditingToolbar
        // FIXME:  also handle CANCEL button
        let doneButton = durEditingToolbar.items![2]
        doneButton.target = self
        doneButton.action = #selector(durationChanged)
        
        // FIXME:  set value of duration text field based on current underlying value
        // FIXME:  and/or settings bundle
        durationChanger.value = DEFAULT_DURATION
        durationChanger.maximumValue = MAX_DURATION
        durationChanger.addTarget(self,
                                  action: #selector(updateDurationViaStepper),
                                  forControlEvents: .AllEvents)
        
        // FIXME: TODO: check whether today's log file exists; if so, read it
        // FIXME:   in on a separate queue; if not, create it
        /*
        NSString *f = [[NSBundle mainBundle]
            pathForResource: @"winedb_v68_wdb" ofType: @"txt"];
        */
    }
    
    override func viewWillTransitionToSize(size: CGSize,
                        withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        checkScreenHeight()
    }
    
    override func viewWillDisappear(animated: Bool) {
        print("EditActivVCtlr: nd to write new activs & lookup terms to disk before we go")
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
    
    func validateFields() -> Bool {
        
        return true
    }
    
    @IBAction func textEntryDone(sender: UITextField) {
        let tf = sender
        let enteredText = tf.text!
        print("input:  \(enteredText)")
        // 'commit' the activity when text field's dismissed (use defaults
        //    or curr. settings for all other fields, unless in 'new user' mode)
        // FIXME: in 'new user' mode, PROMPT to set/verify categ/duration, etc.
        // FIXME: even w/o sel, both "lets" succeed?  need better logic here
        guard let r = tf.selectedTextRange else {return }
        guard let substr = tf.textInRange(r) else {return }
        // add this selected text to our "look-up terms" dictionary
        // ...
        if substr.characters.count > 0 {
            print("    selected:  [\(substr)]")
            // FIXME:  add check for dupe/relative of existing entry
            lookupTermsPhrases.append(substr)
        }
        if enteredText != currActivText {  // FIXME: also trim whitespace first
            print("entered: [\(enteredText)], curr: [\(currActivText)]")
            // save new entry
            print("TO_DO:  save new activity into file/DB/structure(s)")
            currActivText = enteredText
        }
        dismissViewControllerAnimated(true, completion: {} )
        
    }
    
    @IBAction func grabFocusFromActivTextFld(sender: AnyObject) {
        // FIXME:  factor out textEntryDone()'s text-retrieval parts into
        // FIXME:     a function that we can also use here
        activityTextFld.resignFirstResponder()
        print("text fld conts: \(activityTextFld.text!)")
    }
    
    @IBAction func valCategChanged(sender: UISegmentedControl) {
        print("valCateg chgd to: \(valCategCtrl.titleForSegmentAtIndex(valCategCtrl.selectedSegmentIndex)!)")
        grabFocusFromActivTextFld(self)
    }
    
    @IBAction func durationChanged(sender: AnyObject) {
        // FIXME:  fires TWICE if DONE button used, since we're also
        // FIXME:     trapping "editingDidEnd" event (to finish by simply leaving text field)
        print("duration chgd to \(durationMinsTextFld.text!)")
        durationMinsTextFld.resignFirstResponder()
        grabFocusFromActivTextFld(self)
    }
    
    @IBAction func updateDurationViaStepper(sender: UIStepper) {
        // print("dur'n. inc/decr'd to:  \(durationChanger.value)")
        durationMinsTextFld.text = String(Int(durationChanger.value))
        grabFocusFromActivTextFld(self)
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ChangeStartTimeSegue" {
            let dest = segue.destinationViewController
            if let pop = dest.popoverPresentationController {
                pop.delegate = self
                // FIXME:  consider adding delay macro, and passthroughViews
                print("segue-ing to change start time...")
                
                // from Neuburg PROG'G iOS9
                let vc = TDTChgStartTimeVCtlr()
                vc.modalPresentationStyle = .Popover
                self.presentViewController( vc, animated: true, completion: nil)
            }
        }
    }
    
    func popoverPresentationControllerDidDismissPopover(
        popoverPresentationController: UIPopoverPresentationController) {
        print("...popover dismissed")
        updateStartTime()
    }
    
    func updateStartTime() {
        print("updateStartTime() called... need to change start time...")
        grabFocusFromActivTextFld(self)
    }
    
    
}
