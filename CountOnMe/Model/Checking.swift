//
//  Checking.swift
//  CountOnMe
//
//  Created by E&M Life Project on 23/12/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Checking {
        var number = [String]()
    
    // Error check computed variables
    func expressionIsCorrect(lastCharacter: String?) -> Bool {
        guard let lastCharacter = lastCharacter else {
            print("Erreur expressionIsCorrect")
            return false
        }
        return lastCharacter != "+" && lastCharacter != "-" && lastCharacter != "x" && lastCharacter != "÷"
    }
}
