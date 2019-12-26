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
        guard checking.expressionHaveResult else {
            return NotificationCenter.default.post(name: .error, object: nil, userInfo: ["Error": DefaultSituation.haveResult])
        }
        var operationsToReduce = checking.elements
        readyForCalculate(operationsToReduce: &operationsToReduce)
        elementTextView.append(" = \(operationsToReduce.first ?? "Error")")
    }
    
    // using inout to permitt transform operationsToReduce in this function and in his caller
    func readyForCalculate(operationsToReduce: inout [String]) {
        //                 Create local copy of operations
        while operationsToReduce.count > 1 {
            var place = 0
            if let index = operationsToReduce.firstIndex(where: { $0 == "*" || $0 == "÷"}) {
                place = index - 1
            }
            let left = Double(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Double(operationsToReduce[2])!
            var operationResult: Double = 0.00
            switch operand {
            case "+":
                operationResult = left + right
            case "-":
                operationResult = left - right
            case "x":
                operationResult = left * right
            case "÷":
                if right == 0 {
                    NotificationCenter.default.post(name: .error, object: nil, userInfo: ["Error": DefaultSituation.divisionByZero])
                }
                operationResult = left / right
            default:
                NotificationCenter.default.post(name: .error, object: nil, userInfo: ["Error": DefaultSituation.unknowOperator])
            }
            print(operationsToReduce)
            operationsToReduce.remove(at: place)
            operationsToReduce.remove(at: place)
            operationsToReduce.remove(at: place)
            operationsToReduce.insert("\(operationResult)", at: place)
            print(operationsToReduce)
        }
    }
    
    func reset() {
        elementTextView = ""
    }
}
