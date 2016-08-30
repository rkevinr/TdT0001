//
//  TDTActivitiesViewCtlr.swift
//  TDT
//
//  Created by Kevin on 8/29/16.
//  Copyright © 2016 R. Kevin Ryan. All rights reserved.
//

import UIKit

class TDTActivitiesViewCtlr: UIViewController,
                    UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet weak var activsTblVw: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        TDTAppDelegate.setTableView(activsTblVw)
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
    
    // MARK:  Table View Data Source methods
    func tableView(tableView: UITableView,
                     cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ActivityCell")
                            as! TDTActivityCell
        
        //let delegate = UIApplication.sharedApplication().delegate
        //       as! TDTAppDelegate
        // let ar = TDTAppDelegate.globals!.activitiesList
        let ar = TDTAppDelegate.activitiesList
        let arraySize = ar.count
        if arraySize > 0 {
            let activ = ar[indexPath.row]
            cell.durationLabel.text = String(activ.durationMinutes)
            cell.activityDescriptionLabel.text = activ.description
        }
        return cell
    }
    
    func tableView(tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        //let delegate = UIApplication.sharedApplication().delegate
        //    as! TDTAppDelegate
        // return TDTAppDelegate.globals!.activitiesList.count
        return TDTAppDelegate.activitiesList.count
    }
    
    // MARK:  Table View Delegate methods
    
    

}
