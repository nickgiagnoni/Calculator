//
//  ViewController.swift
//  Calculator3
//
//  Created by Nicholas Giagnoni on 2/16/20.
//  Copyright © 2020 Nicholas Giagnoni. All rights reserved.
//

import UIKit

enum modes {
    case notSet
    case addition
    case subtraction
    case multiplication
}

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    var labelString: String = "0"
    var currentMode: modes = .notSet
    var savedNum: Int = 0
    var lastButtonWasMode:Bool = false

    func updateText() {
        guard let labelInt: Int = Int(labelString) else {
            label.text = "Error"
            return
        }
        
        if currentMode == .notSet {
            savedNum = labelInt
        }
        
        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let num: NSNumber = NSNumber(value: labelInt)
        
        label.text = formatter.string(from: num)
    }
    
    func changeModes(newMode: modes) {
        if savedNum == 0 {
            return
        }
        
        currentMode = newMode
        lastButtonWasMode = true
    }
    
    @IBAction func didPressPlus(_ sender: Any) {
        changeModes(newMode: .addition)
    }
    
    @IBAction func didPressMinus(_ sender: Any) {
        changeModes(newMode: .subtraction)
    }
    
    @IBAction func didPressMultiply(_ sender: Any) {
        changeModes(newMode: .multiplication)
    }
    
    @IBAction func didPressEquals(_ sender: Any) {
        guard let labelInt: Int = Int(labelString) else {
            label.text = "Error"
            return
        }
        
        if currentMode == .notSet || lastButtonWasMode {
            return
        }
        
        if currentMode == .addition {
            savedNum += labelInt
        } else if currentMode == .subtraction {
            savedNum -= labelInt
        } else if currentMode == .multiplication {
            savedNum *= labelInt
        }
        
        currentMode = .notSet
        labelString = "\(savedNum)"
        updateText()
        lastButtonWasMode = true
    }
    
    @IBAction func didPressClear(_ sender: Any) {
        labelString = "0"
        currentMode = .notSet
        savedNum = 0
        lastButtonWasMode = false
        label.text = "0"
    }
    
    @IBAction func didPressNumber(_ sender: UIButton) {
        guard let stringValue: String = sender.titleLabel?.text else {
            label.text = "Error"
            return
        }
        
        if lastButtonWasMode {
            lastButtonWasMode = false
            labelString = "0"
        }
        
        labelString = labelString.appending(stringValue)
        updateText()
    }
    
}
