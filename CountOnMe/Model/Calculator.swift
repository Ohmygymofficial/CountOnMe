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
    var elementTextView: String = "1 + 1 = 2" {
        didSet {
            NotificationCenter.default.post(name: .result, object: nil)
        }
    }
}
