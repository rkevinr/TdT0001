//
//  TDTActivityViewCtlr.swift
//  TDT
//
//  Created by Kevin on 6/22/16.
//  Copyright © 2016 R. Kevin Ryan. All rights reserved.
//

import UIKit

class TDTActivityViewCtlr: UIViewController
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
    
    static let DEFAULT_DURATION = 15   // minutes
    static let MAX_DURATION = 600      // minutes (ten hours)
    
    var activityRecordIsDirty = false
    var confirmUseOfDefaultParams = true
    
    var currActivityText = ""
    var currValCateg = defaultValueCategory // FIXME: settings may prefer "last used categ"
    var currDuration = TDTActivityViewCtlr.DEFAULT_DURATION  // FIXME: settings may change this
    var currStartTime = NSDate(timeIntervalSinceNow: NSTimeInterval(0))
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
        // FIXME:  menuItems holds only custom items; standard ones not accessible by app (?)
        UIMenuController.sharedMenuController().menuItems = [UIMenuItem]()
        UIMenuController.sharedMenuController().menuItems?.append(
                    UIMenuItem(title: "AddToKB", action: #selector(doNothing)))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkScreenHeight()  // FIXME: nd more-accurate calcs, and in transitionToSize()
        addMenuItemToTextField()  // FIXME: will this work AFTER text fld becomes 1st responder?
        activityTextFld.becomeFirstResponder()
        
        durationMinsTextFld.inputAccessoryView = durEditingToolbar
        // FIXME:  also handle CANCEL button
        let doneButton = durEditingToolbar.items![2]
        doneButton.target = self
        doneButton.action = #selector(durationChanged)
        
        // FIXME:  set value of duration text field based on current underlying value
        // FIXME:  and/or settings bundle
        durationChanger.value = Double(TDTActivityViewCtlr.DEFAULT_DURATION)
        durationChanger.maximumValue = Double(TDTActivityViewCtlr.MAX_DURATION)
        durationChanger.addTarget(self,
                                  action: #selector(updateDurationViaStepper),
                                  forControlEvents: .AllEvents)
        
        // FIXME: TODO: check whether today's log file exists; if so, read it
        // FIXME:   in on a separate queue; if not, create it
    }
    
    override func viewWillTransitionToSize(size: CGSize,
                        withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        checkScreenHeight()  // FIXME:  "height" does not change with orientation change
    }
    
    override func viewWillDisappear(animated: Bool) {
        if self.activityRecordIsDirty {
            print("need to write TDTActivity record, if 'dirty'")
        }
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
    
    func saveActivityRecord() {
        // TODO: construct and commit the record/structure, and write to log file
        // create the new TDTActivity record:
        var ar = TDTActivity(
            description:  currActivityText,
            valueCategory: currValCateg,
            durationMins: currDuration,
            startTime: currStartTime
        )
        
        // let df = NSDateFormatter()
        // df.dateFormat = "yyyy_MMdd HH:mm ZZ (zz)" // FIXME: pull out as constant
        let fh = (UIApplication.sharedApplication().delegate
                    as! TDTAppDelegate).globals!.logFileHandle
        // let d = encode(&ar)  // TODO: eventually use this, or obj w/NSCoding
        // fh.writeData(d)
        
        // write each field of rec individually, for first, crude approximation
        let df = NSDateFormatter()
        df.dateFormat = "yyyy_MMdd HH:mm ZZ (zz)"
        var d: NSData?
        
        d = (String(currDuration)+"|").dataUsingEncoding(NSUTF8StringEncoding)
        fh.seekToEndOfFile()
        fh.writeData(d!)
        d = (currValCateg+"|").dataUsingEncoding(NSUTF8StringEncoding)
        fh.seekToEndOfFile()
        fh.writeData(d!)
        d = (currActivityText+"|").dataUsingEncoding(NSUTF8StringEncoding)
        fh.seekToEndOfFile()
        fh.writeData(d!)
        d = (df.stringFromDate(currStartTime)+"|").dataUsingEncoding(NSUTF8StringEncoding)
        fh.seekToEndOfFile()
        fh.writeData(d!)
        d = "\n".dataUsingEncoding(NSUTF8StringEncoding)
        fh.seekToEndOfFile()
        fh.writeData(d!)
    }
    
    func validateFields() -> Bool {
        return true
    }
    
    @IBAction func textEntryDone(sender: UITextField) {
        let tf = sender
        let enteredText = tf.text!
        // 'commit' the activity when text field's dismissed (use defaults
        //    or curr. settings for all other fields, unless in 'new user' mode)
        // FIXME: in 'new user' mode, PROMPT to set/verify categ/duration, etc.
        // FIXME: even w/o sel, both "lets" succeed?  need better logic here
        guard let r = tf.selectedTextRange else {return }
        guard let substr = tf.textInRange(r) else {return }
        // add this selected text to our "look-up terms" dictionary
        // ...
        if substr.characters.count > 0 {
            // FIXME:  add check for dupe/relative of existing entry
            lookupTermsPhrases.append(substr)
        }
        if enteredText != currActivityText {  // FIXME: also trim whitespace first
            // save new entry
            print("TO_DO:  save new activity into file/DB/structure(s)")
            if confirmUseOfDefaultParams { // FIXME: add to user settings
                // TODO: force validation of other possibly-not-set activity fields
            }
            currActivityText = enteredText
            saveActivityRecord()
            self.activityRecordIsDirty = false
        }
        
        dismissViewControllerAnimated(true, completion: {} )
    }
    
    @IBAction func grabFocusFromActivTextFld(sender: AnyObject) {
        // FIXME:  factor out textEntryDone()'s text-retrieval parts into
        // FIXME:     a function that we can also use here
        activityTextFld.resignFirstResponder()
        // print("text fld conts: \(activityTextFld.text!)")
    }
    
    @IBAction func valCategChanged(sender: UISegmentedControl) {
        grabFocusFromActivTextFld(self)
        currValCateg = valCategCtrl.titleForSegmentAtIndex(
                                    valCategCtrl.selectedSegmentIndex)!
        print("valCateg chgd to: \(currValCateg)")
    }
    
    @IBAction func durationChanged(sender: AnyObject) {
        grabFocusFromActivTextFld(self)
        // FIXME:  fires TWICE if DONE button used, since we're also
        // FIXME:     trapping "editingDidEnd" event (to finish by simply leaving text field)
        // FIXME:  add error checking for null text field, extra whitespace, etc.
        currDuration = Int(durationMinsTextFld.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()))!
        print("duration chgd to \(currDuration)")
        durationMinsTextFld.resignFirstResponder()
    }
    
    @IBAction func updateDurationViaStepper(sender: UIStepper) {
        grabFocusFromActivTextFld(self)
        print("dur'n. inc/decr'd to:  \(durationChanger.value)")
        currDuration = Int(durationChanger.value)
        durationMinsTextFld.text = String(currDuration)
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ChangeStartTimeSegue" {
            let dest = segue.destinationViewController
            if let pop = dest.popoverPresentationController {
                pop.delegate = self
                // FIXME:  consider adding delay macro, and passthroughViews
                // from Neuburg's PROG'G iOS9
                let vc = TDTActivChgStartTimeVCtlr()
                vc.modalPresentationStyle = .Popover
                self.presentViewController( vc, animated: true, completion: nil)
            }
        }
    }
    
    func popoverPresentationControllerDidDismissPopover(
        popoverPresentationController: UIPopoverPresentationController) {
        print("[this does NOT get called; FIXME] Back in the U.S.S.R.") // FIXME
    }
    
    func updateStartTime(newStartTime: NSDate) {
        grabFocusFromActivTextFld(self)
        let df = NSDateFormatter()
        df.dateFormat = "yyyy_MMdd HH:mm ZZ (zz)"
        print("updateStartTime(NSDate) called...with \(df.stringFromDate(newStartTime))")
        // FIXME: validate new start time before overwriting current value
        currStartTime = newStartTime
    }
    
}

/*
    UIMenuController.sharedMenuController().menuItems?.forEach {
        // print("    item: \($0.title)")
    }
*/
