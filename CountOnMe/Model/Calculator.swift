//
//  Calculator.swift
//  CountOnMe
//
//  Created by E&M Life Project on 25/12/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation
protocol ModelDelegate: class {
    func didReceiveData(_ data: String)
}

class Calculator {
    
    weak var delegate: ModelDelegate?
    
    func sendToController(data: String) {
        delegate?.didReceiveData(data)
    }
    
    enum OperationSymbol: String {
        case plusSymbol = " + "
        case lessSymbol = " - "
        case multiplySymbol = " x "
        case divisionSymbol = " ÷ "
    }
    
    enum ShowSituation: String {
        case isIncorrect = " Expression is incorrect "
        case haveNotEnoughElement = " Missing element to generate calcul "
        case haveResult = " Result is already showed on screen "
        case divisionByZero = " Sorry, you can't make a division by 0 "
        case unknowOperator = " Sorry, this symbol do not exist "
        case result = "result"
    }
    
    var elements: [String] {
        return elementTextView.split(separator: " ").map { "\($0)" }
    }
    
    var elementTextView: String = "1 + 1 = 2" {
        didSet {
            sendToController(data: ShowSituation.result.rawValue)
        }
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
    
    func addNumber(number: String) {
        if expressionHaveResult(expression: elementTextView) {
            elementTextView = ""
        }
            elementTextView += number
    }
    
    func addOperator(operationSymbol: String) {
        restoreLastResult(operationSymbol: operationSymbol)
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
                delegate?.didReceiveData(ShowSituation.isIncorrect.rawValue)
            }
        } else {
            // Change the operator Symbol
            elementTextView.removeLast(3)
            elementTextView += (" \(operationSymbol) ")
        }
    }
    
    func restoreLastResult(operationSymbol: String) {
        if expressionHaveResult(expression: elementTextView) {
            if elementTextView.prefix(7) == "= Error" {
                delegate?.didReceiveData(ShowSituation.isIncorrect.rawValue)
            } else {
                guard let lastElement = elements.last else {
                    return elementTextView = ""
                }
                elementTextView = lastElement
            }
        }
    }
    
    func checkBeforeCalculate() {
        guard isExpressionCorrect else {
            return sendToController(data: ShowSituation.isIncorrect.rawValue)
        }
        guard expressionHaveEnoughElement else {
            return sendToController(data: ShowSituation.haveNotEnoughElement.rawValue)
        }
        if expressionHaveResult(expression: elementTextView) {
            return sendToController(data: ShowSituation.haveResult.rawValue)
        }
        // create a local copy of elements
        var operationsToReduce = elements
        calculate(operationsToReduce: &operationsToReduce)
    }
    
    // using inout to permitt transform operationsToReduce in this function and in his caller
    func calculate(operationsToReduce: inout [String]) {
        //                 Create local copy of operations
        while operationsToReduce.count > 1 {
            var place = 0
            if let index = operationsToReduce.firstIndex(where: { $0 == "x" || $0 == "÷"}) {
                place = index - 1
            }
            let left = Double(operationsToReduce[place])!
            let operatorSymbol = operationsToReduce[place + 1]
            let right = Double(operationsToReduce[place + 2])!
            var operationResult: Double = 0.00
            switch operatorSymbol {
            case "+":
                operationResult = left + right
            case "-":
                operationResult = left - right
            case "x":
                operationResult = left * right
            case "÷":
                operationResult = left / right
            default:
                sendToController(data: ShowSituation.unknowOperator.rawValue)
            }
            operationsToReduce.remove(at: place)
            operationsToReduce.remove(at: place)
            operationsToReduce.remove(at: place)
            operationsToReduce.insert("\(operationResult)", at: place)
            checkAfterCalculate(operationsToReduce: operationsToReduce)
        }
    }
    
    func checkAfterCalculate(operationsToReduce: [String]) {
        if operationsToReduce.first == "inf" || operationsToReduce.first == "-inf" {
            sendToController(data: ShowSituation.divisionByZero.rawValue)
            elementTextView = "= Error"
        } else {
            elementTextView += " = \(operationsToReduce.first ?? "= Error")"
        }
    }
    
    func reset() {
        elementTextView = ""
    }
}
