//
//  ViewController.swift
//  TipCalculator
//
//  Created by Shoaib Huq on 11/23/21.
//

import UIKit

class ViewController: UIViewController {
    
    var tipPercentage: Double = 0.1
    var bill: Double = 0.0
    var partySize: Double = 1
    
    @IBOutlet weak var billTextField: UITextField!
    
    @IBOutlet weak var customTipTextField: UITextField!
    
    @IBOutlet weak var billLabel: UITextField!
    
    @IBOutlet weak var tipSelector: UISegmentedControl!
    
    @IBOutlet weak var customTipLabel: UILabel!
    
    @IBOutlet weak var partySizeLabel: UILabel!
    
    @IBOutlet weak var tipTotal: UILabel!
    
    @IBOutlet weak var billTotal: UILabel!
    
    @IBOutlet weak var splitTotal: UILabel!
    
    @IBOutlet weak var customTipTextfield: UITextField!
    
    @IBOutlet weak var partySizeStepper: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideCustomUI()
        
        partySizeStepper.value = 1
        
        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        self.view.endEditing(true)
    }
    
    @IBAction func billTotalDidEndEditing(_ sender: UITextField) {
        bill = Double(sender.text!) ?? 0.0
        updateTotals()
    }
    
    
    @IBAction func customTipTextfieldEditingEnded(_ sender: UITextField) {
        if let percent = Double(sender.text!){
            tipPercentage = percent / 100
            updateTotals()
        } else {
            print("Invalid Value Entered")
        }
    }
    
    @IBAction func tipSelectorChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            tipPercentage = 0.1
            hideCustomUI()
        case 1:
            tipPercentage = 0.15
            hideCustomUI()

        case 2:
            tipPercentage = 0.2
            hideCustomUI()
            
        case 3:
            customTipLabel.isHidden = false
            customTipTextfield.isHidden = false
        default:
            customTipLabel.isHidden = true
            tipPercentage = 0.1
        }
    }
    
    
    
    @IBAction func stepperChanged(_ sender: UIStepper) {
        partySize = sender.value
        partySizeLabel.text = "\(Int(partySize))"
        updateTotals()
        
    }
    
    
    func hideCustomUI() -> Void {
        customTipLabel.isHidden = true
        customTipTextfield.isHidden = true
        customTipTextfield.text = ""
        updateTotals()
    }
    
    func updateTotals() -> Void {
        let sum = bill + bill*tipPercentage
        let totalTip = String(format: "%.2f", (bill*tipPercentage))
        let totalBill = String(format: "%.2f", sum)
        let totalSplit = String(format: "%.2f", (sum / partySize))
        
        
        tipTotal.text = "$\(totalTip)"
        billTotal.text = "$\(totalBill)"
        splitTotal.text = "$\(totalSplit) per person"
    }
    

}


extension ViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.resignFirstResponder()
    }
}

