//
//  ViewController.swift
//  Calculator
//
//  Created by Edgar Gonzalez on 3/28/17.
//  Copyright © 2017 Edgar Gonzalez. All rights reserved.
//

import UIKit

enum modes {
    case not_set
    case subtraction
    case addition
    case multiply
}

class ViewController: UIViewController {
    @IBOutlet weak var text: UILabel!
    
    var labelString:String="0";
    var currentModes:modes = .not_set;
    var savedNum:Int = 0;
    var lastButtonWasMode:Bool = false;
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func didPressPlus(_ sender: Any) {
        changeMode(newMode: .addition)
    }
    @IBAction func didPressSubtract(_ sender: Any) {
        changeMode(newMode: .subtraction)
    }
    @IBAction func didPressEquals(_ sender: Any) {
        guard let labelInt:Int = Int(labelString) else {
            return
        }
        if(currentModes == .not_set || lastButtonWasMode){
            return
        }
        if(currentModes == .addition){
            savedNum += labelInt;
        }
        else if(currentModes == .subtraction){
            savedNum-=labelInt;
        }
        else if(currentModes == .multiply)
        {
            savedNum *= labelInt;
        }
        currentModes = .not_set;
        labelString = "\(savedNum)";
        updateText();
        lastButtonWasMode = true;
    }
    @IBAction func didPressClear(_ sender: Any) {
        labelString="0";
        currentModes = .not_set;
        savedNum = 0;
        lastButtonWasMode = false;
        text.text = "0";
    }
    @IBAction func didPressNumber(_ sender: UIButton) {
        let stringValue:String? = sender.titleLabel?.text
        if (lastButtonWasMode) {
            lastButtonWasMode = false;
            labelString="0";
        }
        labelString = labelString.appending(stringValue!)
        updateText()
    }
    @IBAction func didPressMultiply(_ sender: Any) {
        changeMode(newMode: .multiply);
    }
    
    func updateText() {
        guard let labelInt:Int = Int(labelString) else {
            return
        }
        if(currentModes == .not_set){
            savedNum = labelInt;
        }
        let formatter:NumberFormatter = NumberFormatter();
        formatter.numberStyle = .decimal
        let num:NSNumber = NSNumber(value: labelInt);
        text.text = formatter.string(from: num);
        
        
        
    }
    
    func changeMode(newMode:modes) {
        if(savedNum == 0)
        {
            return
        }
        currentModes = newMode;
        lastButtonWasMode = true;
        
        
    }


}

