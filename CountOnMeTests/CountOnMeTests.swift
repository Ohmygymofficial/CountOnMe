//
//  CountOnMeTests.swift
//  CountOnMeTests
//
//  Created by E&M Life Project on 27/12/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CountOnMeTests: XCTestCase {
    
    var calculate = Calculator()

    override func setUp() {
        super.setUp()
        calculate = Calculator()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSimpleAddition() {
        calculate.addNumber(number: "1")
        calculate.addOperator(operationSymbol: "+")
        calculate.addNumber(number: "4")
        calculate.checkBeforeCalculate()
        XCTAssertEqual(calculate.elementTextView, "1 + 4 = 5.0")
        XCTAssertEqual(calculate.elements.last, "5.0")
    }
    
    func testSimpleSoustraction() {
        calculate.addNumber(number: "5")
        calculate.addOperator(operationSymbol: "-")
        calculate.addNumber(number: "1")
        calculate.checkBeforeCalculate()
        XCTAssertEqual(calculate.elementTextView, "5 - 1 = 4.0")
        XCTAssertEqual(calculate.elements.last, "4.0")
    }
    
    func testSimpleMultiplication() {
        calculate.addNumber(number: "5")
        calculate.addOperator(operationSymbol: "x")
        calculate.addNumber(number: "2")
        calculate.checkBeforeCalculate()
        XCTAssertEqual(calculate.elementTextView, "5 x 2 = 10.0")
        XCTAssertEqual(calculate.elements.last, "10.0")
    }
    
    func testSimpleDivision() {
        calculate.addNumber(number: "10")
        calculate.addOperator(operationSymbol: "÷")
        calculate.addNumber(number: "2")
        calculate.checkBeforeCalculate()
        XCTAssertEqual(calculate.elementTextView, "10 ÷ 2 = 5.0")
        XCTAssertEqual(calculate.elements.last, "5.0")
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
