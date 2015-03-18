//
//  ViewController.swift
//  tipcalculator
//
//  Created by Mateo Garcia on 3/17/15.
//  Copyright (c) 2015 Mateo Garcia. All rights reserved.
//

import UIKit

struct globalVars {
    static var minTipPercentage15 = [0.15, 0.18, 0.2]
    static var minTipPercentage18 = [0.18, 0.2, 0.22]
    static var minTipPercentages = [minTipPercentage15, minTipPercentage18]
    static var tipPercentages = globalVars.minTipPercentage18
    static var backgroundColors = [UIColor.whiteColor(), UIColor.magentaColor()]
}

var tipCalculator = TipCalculatorViewController()
var tipControl = tipCalculator.minTip18Control

class TipCalculatorViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var minTip18Control: UISegmentedControl!
    @IBOutlet weak var minTip15Control: UISegmentedControl!
    @IBOutlet weak var minTip15View: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        tipCalculator = self
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setDouble(0.18, forKey: "minTip")
        defaults.setBool(false, forKey: "switchStatus")
        defaults.setInteger(0, forKey: "backgroundColor")
        defaults.synchronize()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        var defaults = NSUserDefaults.standardUserDefaults()
        tipControl.selectedSegmentIndex = defaults.integerForKey("tipControlSelectedIndex")
        onEditingChanged(self)
        var backgroundColor = globalVars.backgroundColors[defaults.integerForKey("backgroundColor")]
        view.backgroundColor = backgroundColor
        minTip15View.backgroundColor = backgroundColor
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(tipControl.selectedSegmentIndex, forKey: "tipControlSelectedIndex")
        defaults.synchronize()
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        var tipPercentage = globalVars.tipPercentages[tipControl.selectedSegmentIndex]
        var billAmount = billField.text._bridgeToObjectiveC().doubleValue
        var tip = billAmount * tipPercentage
        var total = billAmount + tip
        
        tipLabel.text = "\(tip)"
        totalLabel.text = "\(total)"
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
}

