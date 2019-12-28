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
    
    var calculate: Calculator!
    
    override func setUp() {
        // initialize with setUp each test with Instance calculate
        super.setUp()
        calculate = Calculator()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    //    Given : Etant donné que... [Situation de départ]
    //    When : Quand... [Action]
    //    Then : Alors... [Situation d'arrivée]
    // Test ONLY public var and func : That is the list
    //    internal protocol ModelDelegate : AnyObject {
    //
    //        func didReceiveData(_ data: String)
    //    }
    //
    //    internal class Calculator {
    //
    //        weak internal var delegate: ModelDelegate?
    //
    //    internal var elements: [String] { get }
    //
    //        internal var elementTextView: String { get set }
    //
    //        internal func addNumber(number: String)
    //
    //        internal func addOperator(operationSymbol: String)
    //
    //        internal func checkBeforeCalculate()
    //
    //        internal func reset()
    
    
    // MARK: - Number TEST
    func testAddOneNumber() {
        calculate.addNumber(number: "6")
        XCTAssertEqual(calculate.elementTextView, "6")
    }
    
    func testAddTwoNumber() {
        calculate.addNumber(number: "6")
        calculate.addNumber(number: "9")
        XCTAssertEqual(calculate.elementTextView, "69")
    }
    
    func testAddTwoNumberAndDotNumber() {
        calculate.addNumber(number: "6")
        calculate.addNumber(number: "9")
        calculate.addNumber(number: ".")
        calculate.addNumber(number: "9")
        XCTAssertEqual(calculate.elementTextView, "69.9")
    }
    
    func testAddNumberAfterReset() {
        calculate.reset()
        calculate.addNumber(number: "6")
        XCTAssertEqual(calculate.elementTextView, "6")
    }
    
    
    
    // MARK: - Operator TEST
    func testAddOneOperator() {
        calculate.addOperator(operationSymbol: "x")
        XCTAssertEqual(calculate.elementTextView, "2 x ")
    }
    
    func testAddTwoOperator() {
        calculate.addOperator(operationSymbol: "x")
        calculate.addOperator(operationSymbol: "+")
        XCTAssertEqual(calculate.elementTextView, "2 + ")
    }
    
    func testAddBadOperator() {
        calculate.addOperator(operationSymbol: "/")
        XCTAssertEqual(calculate.elementTextView, "= Error")
    }
    

    
    
    // MARK: - Reset TEST
    func testReset() {
        calculate.reset()
        XCTAssertEqual(calculate.elementTextView, "")
    }
    
    
    // MARK: - CheckBefore Calcul TEST
    func testIsExpressionIncorrect() {
        calculate.addNumber(number: "1")
        calculate.addOperator(operationSymbol: "+")
        calculate.checkBeforeCalculate()
        XCTAssertEqual(calculate.elementTextView, "1 + ")
    }
    
    func testIsExpressionEnough() {
        calculate.addNumber(number: "1")
        calculate.checkBeforeCalculate()
        XCTAssertEqual(calculate.elementTextView, "1")
    }
    
    func testIsExpressionHaveResult() {
         testSimpleAddition()
        calculate.checkBeforeCalculate()
        XCTAssertEqual(calculate.elementTextView, "1 + 4 = 5.0")
     }
    
    // MARK: - Calcul TEST
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
    
    func testDivisionByZero() {
        calculate.addNumber(number: "10")
        calculate.addOperator(operationSymbol: "÷")
        calculate.addNumber(number: "0")
        calculate.checkBeforeCalculate()
        XCTAssertEqual(calculate.elementTextView, "= Error")
        XCTAssertEqual(calculate.elements.last, "Error")
    }
    
    func testRestoreLastResult() {
        testSimpleDivision()
        calculate.addOperator(operationSymbol: "+")
        XCTAssertEqual(calculate.elementTextView, "5.0 + ")
    }
    
    func testTryToRestoreLastResultWithErrorOnScreen() {
        testDivisionByZero()
        calculate.addOperator(operationSymbol: "+")
        XCTAssertEqual(calculate.elementTextView, "= Error + ")
    }
    
    func testTryToRestoreLastResultAfterACTapInside() {
        testReset()
        calculate.addOperator(operationSymbol: "+")
        XCTAssertEqual(calculate.elementTextView, "= Error + ")
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
