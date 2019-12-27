//
//  Calculator.swift
//  CountOnMe
//
//  Created by E&M Life Project on 25/12/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calculator {
    
    enum OperationSymbol: String {
        case plusSymbol = " + "
        case lessSymbol = " - "
        case multiplySymbol = " x "
        case divisionSymbol = " ÷ "
    }
    
    enum DefaultSituation: String {
        case isIncorrect = " Expression is incorrect "
        case haveNotEnoughElement = " Missing element to generate calcul "
        case haveResult = " Result is already showed on screen "
        case divisionByZero = " Sorry, you can't make a division by 0 "
        case unknowOperator = " Sorry, this symbol do not exist "
    }
    
    var elements: [String] {
        return elementTextView.split(separator: " ").map { "\($0)" }
    }
    
    // different checking error possible
    var isExpressionCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "÷"
    }
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    func expressionHaveResult(expression: String) -> Bool {
        return expression.firstIndex(of: "=") != nil
    }
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "÷"
    }
    
    var elementTextView: String = "1 + 1 = 2" {
        didSet {
            NotificationCenter.default.post(name: .result, object: nil)
        }
    }
    
    func addNumber(number: String) {
        if expressionHaveResult(expression: elementTextView) {
            elementTextView = ""
        }
        elementTextView.append(number)
    }
    
    func addOperator(operationSymbol: String) {
        // if is already a result, we can add Operator, but restore the last result
        if expressionHaveResult(expression: elementTextView) {
            guard let lastElement = elements.last else {
                return elementTextView = ""
            }
            elementTextView = lastElement
        }
        if canAddOperator {
            switch operationSymbol {
            case "+":
                elementTextView += OperationSymbol.plusSymbol.rawValue
            case "-":
                elementTextView += OperationSymbol.lessSymbol.rawValue
            case "x":
                elementTextView += OperationSymbol.multiplySymbol.rawValue
            case "÷":
                elementTextView += OperationSymbol.divisionSymbol.rawValue
            default:
                NotificationCenter.default.post(name: .error, object: nil, userInfo: ["Error": DefaultSituation.isIncorrect])
            }
        } else {
            // Change the operator Symbol
            elementTextView.removeLast(3)
            elementTextView += (" \(operationSymbol) ")
        }
    }
    
    func isExpressionIncorrect() -> String? {
        guard isExpressionCorrect else {
            return DefaultSituation.isIncorrect.rawValue
        }
        guard expressionHaveEnoughElement else {
            return DefaultSituation.haveNotEnoughElement.rawValue
        }
        if expressionHaveResult(expression: elementTextView) {
            return DefaultSituation.haveResult.rawValue
        }
        return nil
    }
    
    func defaultSituation(defaultCase: DefaultSituation.RawValue) -> String {
        return defaultCase
    }
    
    func calculate() {
        var operationsToReduce = elements
        readyForCalculate(operationsToReduce: &operationsToReduce)
        elementTextView.append(" = \(operationsToReduce.first ?? "Error")")
    }
    
    // using inout to permitt transform operationsToReduce in this function and in his caller
    func readyForCalculate(operationsToReduce: inout [String]) {
        //                 Create local copy of operations
        while operationsToReduce.count > 1 {
            var place = 0
            if let index = operationsToReduce.firstIndex(where: { $0 == "x" || $0 == "÷"}) {
                place = index - 1
            }
            let left = Double(operationsToReduce[place])!
            let operand = operationsToReduce[place + 1]
            let right = Double(operationsToReduce[place + 2])!
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
        elementTextView = "Mise a zero"
    }
}

extension Notification.Name {
    static let result = Notification.Name("result")
    static let error = Notification.Name("error")
}
