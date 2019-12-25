//
//  Calculator.swift
//  CountOnMe
//
//  Created by E&M Life Project on 25/12/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation
extension Notification.Name {
  static let result = Notification.Name("result")
  static let error = Notification.Name("error")
}

class Calculator {
    let checking = Checking()
    
    var elementTextView: String = "1 + 1 = 2" {
        didSet {
            NotificationCenter.default.post(name: .result, object: nil)
        }
    }
    
    func addNumber(number: String) {
        if checking.expressionHaveResult {
            elementTextView = ""
        } else {
            elementTextView.append(number)
        }
    }
    
    func addOperator(operationSymbol: String) {
        // if is already a result, we can add Operator, but restore the last result
        if checking.expressionHaveResult {
            guard let lastElement = checking.elements.last else {
                return elementTextView = "0"
            }
            elementTextView = lastElement
        }
        if checking.canAddOperator {
            switch operationSymbol {
            case "+":
                elementTextView = OperationSymbol.plusSymbol.rawValue
            case "-":
                elementTextView = OperationSymbol.lessSymbol.rawValue
            case "x":
                elementTextView = OperationSymbol.multiplySymbol.rawValue
            case "÷":
                elementTextView = OperationSymbol.divisionSymbol.rawValue
            default:
                NotificationCenter.default.post(name: .error, object: nil, userInfo: ["Error": DefaultSituation.isIncorrect])
            }
        } else {
            NotificationCenter.default.post(name: .error, object: nil, userInfo: ["Error": DefaultSituation.operatorIsAlredySet])
        }
    }
    
    func calculate() {
        guard checking.expressionIsCorrect else {
            return NotificationCenter.default.post(name: .error, object: nil, userInfo: ["Error": DefaultSituation.isIncorrect])
        }
        guard checking.expressionHaveEnoughElement else {
            return NotificationCenter.default.post(name: .error, object: nil, userInfo: ["Error": DefaultSituation.haveNotEnoughElement])
        }
//                // Create local copy of operations
//                var operationsToReduce = elements
//        
//                // Calcul only X and / operation and build a new operationsToReduce Array
//                var m = 0
//                while m < operationsToReduce.count {
//                    print("En cours de traitement de : \(operationsToReduce[m])")
//                    if operationsToReduce[m] == "x" || operationsToReduce[m] == "÷"  {
//                        let left = Double(operationsToReduce[m-1])!
//                        let operand = operationsToReduce[m]
//                        let right = Double(operationsToReduce[m+1])!
//                        let result: Double
//                        switch operand {
//                        case "x":
//                            result = left * right
//                        case "÷":
//                            if right == 0 {
//                                let alertVC = UIAlertController(title: "Division par Zéro", message: "La division par zéro n'existe pas", preferredStyle: .alert)
//                                alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//                                self.present(alertVC, animated: true, completion: nil)
//                                textView.text = ""
//                            }
//                            result = left / right
//                        default: fatalError("Unknown operator !")
//                        }
//                        print(operationsToReduce)
//                        operationsToReduce.remove(at: m-1)
//                        operationsToReduce.remove(at: m-1)
//                        operationsToReduce.remove(at: m-1)
//                        operationsToReduce.insert("\(result)", at: m-1)
//                        m = m - 1
//                        print(operationsToReduce)
//                    }
//                    m += 1
//                }
//        
//                // Iterate over operations while an operand still here
//                while operationsToReduce.count > 1 {
//                    let left = Double(operationsToReduce[0])!
//                    let operand = operationsToReduce[1]
//                    let right = Double(operationsToReduce[2])!
//        
//                    let result: Double
//                    switch operand {
//                    case "+": result = left + right
//                    case "-": result = left - right
//                    default: fatalError("Unknown operator !")
//                    }
//                    print(operationsToReduce)
//                    operationsToReduce = Array(operationsToReduce.dropFirst(3))
//                    operationsToReduce.insert("\(result)", at: 0)
//                    print(operationsToReduce)
//                }
//                textView.text.append(" = \(operationsToReduce.first!)")
//            }

    }
}
