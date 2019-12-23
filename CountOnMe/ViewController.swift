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
    var model = Model()
    
    var elements: [String] {
        return textView.text.split(separator: " ").map { "\($0)" }
    }
    
    // Error check computed variables
    var expressionIsCorrect: Bool {
        //ERWAN : a ajouter les autres conditions : signe divisé, signe multiplié
        return elements.last != "+" && elements.last != "-"
    }
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "÷"
    }
    
    var expressionHaveResult: Bool {
        return textView.text.firstIndex(of: "=") != nil
    }
    
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
    
//    @IBAction func tappedAdditionButton(_ sender: UIButton) {
//        if canAddOperator {
//            textView.text.append(" + ")
//        } else {
//            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
//            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//            self.present(alertVC, animated: true, completion: nil)
//        }
//    }
//
//    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
//        if canAddOperator {
//            textView.text.append(" - ")
//        } else {
//            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
//            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//            self.present(alertVC, animated: true, completion: nil)
//        }
//    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard expressionIsCorrect else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        guard expressionHaveEnoughElement else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        // Create local copy of operations
        var operationsToReduce = elements
        
        // Erwan : calcul only X and / operation and build a new operationsToReduce Array
        var m = 0
        while m < operationsToReduce.count {
            print("En cours de traitement de : \(operationsToReduce[m])")
            if operationsToReduce[m] == "x" || operationsToReduce[m] == "÷"  {
                let left = Double(operationsToReduce[m-1])!
                let operand = operationsToReduce[m]
                let right = Double(operationsToReduce[m+1])!
                let result: Double
                switch operand {
                case "x": result = left * right
                case "÷": result = left / right
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

}

