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
    let calculator = Calculator()
    
    //MARK : - Test Button à enlever
    @IBOutlet weak var testButton: UIButton!
    
    @IBAction func testButtonAction(_ sender: UIButton) {
  
    }
    
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal)
           else {return}
        calculator.addNumber(number: numberText)
    }
    
    
    @IBAction func tappedACButton(_ sender: Any) {

    }
    
    
    @IBAction func tappedOperationButton(_ sender: UIButton) {
        guard let symbol = sender.title(for: .normal)
        else {return}
        calculator.addOperator(operationSymbol: symbol)
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        calculator.calculate()
    }
//        // Create local copy of operations
//        var operationsToReduce = elements
//
//        // Calcul only X and / operation and build a new operationsToReduce Array
//        var m = 0
//        while m < operationsToReduce.count {
//            print("En cours de traitement de : \(operationsToReduce[m])")
//            if operationsToReduce[m] == "x" || operationsToReduce[m] == "÷"  {
//                let left = Double(operationsToReduce[m-1])!
//                let operand = operationsToReduce[m]
//                let right = Double(operationsToReduce[m+1])!
//                let result: Double
//                switch operand {
//                case "x":
//                    result = left * right
//                case "÷":
//                    if right == 0 {
//                        let alertVC = UIAlertController(title: "Division par Zéro", message: "La division par zéro n'existe pas", preferredStyle: .alert)
//                        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//                        self.present(alertVC, animated: true, completion: nil)
//                        textView.text = ""
//                    }
//                    result = left / right
//                default: fatalError("Unknown operator !")
//                }
//                print(operationsToReduce)
//                operationsToReduce.remove(at: m-1)
//                operationsToReduce.remove(at: m-1)
//                operationsToReduce.remove(at: m-1)
//                operationsToReduce.insert("\(result)", at: m-1)
//                m = m - 1
//                print(operationsToReduce)
//            }
//            m += 1
//        }
//
//        // Iterate over operations while an operand still here
//        while operationsToReduce.count > 1 {
//            let left = Double(operationsToReduce[0])!
//            let operand = operationsToReduce[1]
//            let right = Double(operationsToReduce[2])!
//
//            let result: Double
//            switch operand {
//            case "+": result = left + right
//            case "-": result = left - right
//            default: fatalError("Unknown operator !")
//            }
//            print(operationsToReduce)
//            operationsToReduce = Array(operationsToReduce.dropFirst(3))
//            operationsToReduce.insert("\(result)", at: 0)
//            print(operationsToReduce)
//        }
//        textView.text.append(" = \(operationsToReduce.first!)")
//    }
//
//    func alertMessage(title: String, message: String, action: String) {
//        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        alertVC.addAction(UIAlertAction(title: action, style: .cancel, handler: nil))
//        return self.present(alertVC, animated: true, completion: nil)
//    }

}


