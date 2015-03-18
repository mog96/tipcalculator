//
//  SettingsTableViewController.swift
//  tipcalculator
//
//  Created by Mateo Garcia on 3/17/15.
//  Copyright (c) 2015 Mateo Garcia. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    @IBOutlet weak var minTipControl: UISegmentedControl!
    @IBOutlet weak var purpleModeSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        tableView.tableFooterView = UIView(frame:CGRectZero)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        var defaults = NSUserDefaults.standardUserDefaults()
        var minTip = defaults.objectForKey("minTip") as? Double
        if (minTip == nil || minTip == 0.18) {
            minTipControl.selectedSegmentIndex = 1;
        } else {
            minTipControl.selectedSegmentIndex = 0;
        }
        purpleModeSwitch.on = defaults.boolForKey("switchStatus")
    }
    
    @IBAction func onTouchUpInside(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onPinkModeChanged(sender: AnyObject) {
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(purpleModeSwitch.on, forKey: "switchStatus")
        toggleBackgroundColor()
        defaults.synchronize()
    }
    
    func toggleBackgroundColor() {
        var defaults = NSUserDefaults.standardUserDefaults()
        if (tipCalculator.view.backgroundColor == UIColor.whiteColor()) {
            defaults.setInteger(1, forKey: "backgroundColor")
        } else {
            defaults.setInteger(0, forKey: "backgroundColor")
        }
    }
    
    @IBAction func onMinTipChanged(sender: AnyObject) {
        globalVars.tipPercentages = globalVars.minTipPercentages[minTipControl.selectedSegmentIndex]
        toggleTipControl()
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setDouble(globalVars.tipPercentages[0], forKey: "minTip")
        defaults.synchronize()
    }
    
    func toggleTipControl() {
        tipCalculator.minTip15View.hidden = !tipCalculator.minTip15View.hidden
        if (tipCalculator.minTip15View.hidden) {
            tipControl = tipCalculator.minTip18Control
        } else {
            tipControl = tipCalculator.minTip15Control
        }
    }

//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell
//
//        cell.selectionStyle = UITableViewCellSelectionStyleNone
//
//        return cell
//    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
