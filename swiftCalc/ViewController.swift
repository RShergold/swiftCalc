//
//  ViewController.swift
//  swiftCalc
//
//  Created by Hatch on 31/10/2014.
//  Copyright (c) 2014 Hatch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    enum Operator {
        case Add, Minus, Times, Devide
    }
    
    var currentOperator: Operator?
    var leftNumber: Double = 0.0
    var rightNumber: Double = 0.0
    var resultNumber: Double = 0.0
    var inputNumber: Double?
    var inputText: String = ""
    
    
    @IBOutlet weak var label: UILabel!
    
    @IBAction func numberButton(sender: UIButton) {
        add_number(Array(sender.currentTitle!)[0])
    }
    @IBAction func ButtonDot(sender: AnyObject) {
        if inputText.rangeOfString(".") == nil {
            add_number(".")
        }
    }
    
    @IBAction func buttonAdd(sender: AnyObject) {
        calculate()
        currentOperator = Operator.Add
    }
    @IBAction func buttonMinus(sender: AnyObject) {
        calculate()
        currentOperator = Operator.Minus
    }
    @IBAction func buttonTimes(sender: AnyObject) {
        calculate()
        currentOperator = Operator.Times
    }
    @IBAction func buttonDevide(sender: AnyObject) {
        calculate()
        currentOperator = Operator.Devide
    }
    
    @IBAction func buttonCalc(sender: AnyObject) {
        calculate(requireInput: false)
    }
    
    @IBAction func buttonClear(sender: AnyObject) {
        inputText = ""
        inputNumber = nil
        label.text = "0"
        
        leftNumber = 0.0
        rightNumber = 0.0
        
        currentOperator = nil
    }
    
    func add_number(newNumber: Character) {
        
        inputText.append(newNumber)
        label.text = inputText

        inputNumber = (inputText as NSString).doubleValue
        
    }
    
    func calculate( requireInput: Bool = true ) {
    
        if requireInput && inputNumber == nil {
            return
        }
        
        if inputNumber != nil {
            rightNumber = inputNumber!
        }
        
        
        if let theOperator = currentOperator {

            switch theOperator {
            case .Add:
                resultNumber = leftNumber + rightNumber
            case .Minus:
                resultNumber = leftNumber - rightNumber
            case .Times:
                resultNumber = leftNumber * rightNumber
            case .Devide:
                resultNumber = leftNumber / rightNumber
            }
            
            
            leftNumber = resultNumber
            
            // dont print .00 if result is and integer
            var resultText = "\(resultNumber)"
            
            if resultText.hasSuffix(".0") {
                label.text = resultText.substringToIndex( advance(resultText.startIndex, countElements(resultText)-2) )
            } else {
                // float
                label.text = resultText
            }
            
        } else {
            leftNumber = rightNumber
        }
        
        inputNumber = nil
        inputText = ""
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

