//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet var operatorButtons: [UIButton]!
    @IBOutlet weak var ACbutton: UIButton!
    let checking = Checking()
    
    
    //MARK : - Test Button à enlever
    @IBOutlet weak var testButton: UIButton!
    
    @IBAction func testButtonAction(_ sender: UIButton) {
  
    }
    

//    // Error check computed variables
//    var expressionIsCorrect: Bool {
//        return checking.expressionIsCorrect(lastCharacter: elements.last)
//    }
    
//    
//    var expressionHaveEnoughElement: Bool {
//        return elements.count >= 3
//    }
    
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "÷"
    }
    
    var expressionHaveResult: Bool {
        return textView.text.firstIndex(of: "=") != nil
    }
    
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        // reset textView.text
        if expressionHaveResult {
            textView.text = ""
        }
        textView.text.append(numberText)
    }
    
    
    @IBAction func tappedACButton(_ sender: Any) {
        textView.text = ""
    }
    
    
    @IBAction func tappedOperationButton(_ sender: UIButton) {
        if canAddOperator {
            guard let numberText = sender.title(for: .normal) else {
                return
            }
            textView.text.append(" \(numberText) ")
        } else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        checking.expressionIsCorrect(lastCharacter: elements.last)
        checking.expressionHaveEnoughElement(elementsCount: elements.count)
        
        // Create local copy of operations
        var operationsToReduce = elements
        
        // Calcul only X and / operation and build a new operationsToReduce Array
        var m = 0
        while m < operationsToReduce.count {
            print("En cours de traitement de : \(operationsToReduce[m])")
            if operationsToReduce[m] == "x" || operationsToReduce[m] == "÷"  {
                let left = Double(operationsToReduce[m-1])!
                let operand = operationsToReduce[m]
                let right = Double(operationsToReduce[m+1])!
                let result: Double
                switch operand {
                case "x":
                    result = left * right
                case "÷":
                    if right == 0 {
                        let alertVC = UIAlertController(title: "Division par Zéro", message: "La division par zéro n'existe pas", preferredStyle: .alert)
                        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                        self.present(alertVC, animated: true, completion: nil)
                        textView.text = ""
                    }
                    result = left / right
                default: fatalError("Unknown operator !")
                }
                print(operationsToReduce)
                operationsToReduce.remove(at: m-1)
                operationsToReduce.remove(at: m-1)
                operationsToReduce.remove(at: m-1)
                operationsToReduce.insert("\(result)", at: m-1)
                m = m - 1
                print(operationsToReduce)
            }
            m += 1
        }
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let left = Double(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Double(operationsToReduce[2])!
            
            let result: Double
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            default: fatalError("Unknown operator !")
            }
            print(operationsToReduce)
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
            print(operationsToReduce)
        }
        textView.text.append(" = \(operationsToReduce.first!)")
    }
    
    func alertMessage(title: String, message: String, action: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: action, style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }

}


