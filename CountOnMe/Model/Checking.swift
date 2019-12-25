//
//  Checking.swift
//  CountOnMe
//
//  Created by E&M Life Project on 23/12/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Checking {
    let calculator = Calculator()
    
    enum CheckingSituation {
      case IsCorrect, haventEnoughElement, haveResult, divisionByZero, operatorIsAlredySet
    }
    
    var elements: [String] {
        return calculator.elementTextView.split(separator: " ").map { "\($0)" }
    }
    
    // different checking error possible
    var expressionIsCorrect: Bool {
      return elements.last != "+" && elements.last != "-" && elements.last != "*" && elements.last != "/"
    }
    var expressionHaveEnoughElement: Bool {
      return elements.count >= 3
    }
    var canAddOperator: Bool {
      return elements.last != "+" && elements.last != "-" && elements.last != "*" && elements.last != "/"
    }
    var expressionHaveResult: Bool {
      return calculator.elementTextView.firstIndex(of: "=") != nil
    }
}
