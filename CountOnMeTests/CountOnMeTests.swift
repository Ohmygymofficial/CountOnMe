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
    
    var calculator: Calculator!
    
    override func setUp() {
        // initialize with setUp each test with Instance calculate
        super.setUp()
        calculator = Calculator()
    }
    
    override func tearDown() {
        calculator = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: - NUMBER TEST
    func testGivenInputIsEmpty_WhenAddingOneNumber_ThenNumberIsShowed() {
        calculator.addNumber(number: "4")
        XCTAssertEqual(calculator.elementTextView, "4")
    }
    
    func testGivenInputIsEmpty_WhenAddingTwoNumbers_ThenNumberIsShowed() {
        calculator.addNumber(number: "4")
        calculator.addNumber(number: "2")
        XCTAssertEqual(calculator.elementTextView, "42")
    }
    
    func testGivenInputIsEmpty_WhenAddingNumberWithDot_ThenNumberIsShowed() {
        calculator.addNumber(number: "4")
        calculator.addNumber(number: "2")
        calculator.addNumber(number: ".")
        calculator.addNumber(number: "1")
        XCTAssertEqual(calculator.elementTextView, "42.1")
    }
    
    func testGivenInputAfterReset_WhenAddingOneNumber_ThenNumberIsShowed() {
        calculator.reset()
        calculator.addNumber(number: "3")
        XCTAssertEqual(calculator.elementTextView, "3")
    }
    
    // MARK: - OPERATOR TEST
    func testGivenAppIsStarted_WhenAddingOneOperator_ThenTwoAndOperatorIsShowed() {
        calculator.addOperator(operationSymbol: "x")
        XCTAssertEqual(calculator.elementTextView, "2 x ")
    }
    
    func testGivenAppIsStarted_WhenAddingTwoOperators_ThenTwoAndLastOperatorIsShowed() {
        calculator.addOperator(operationSymbol: "x")
        calculator.addOperator(operationSymbol: "-")
        XCTAssertEqual(calculator.elementTextView, "2 - ")
    }
    
    func testGivenAppIsStarted_WhenAddingBadOperator_ThenErrorIsShowed() {
        calculator.addOperator(operationSymbol: "/")
        XCTAssertEqual(calculator.elementTextView, "= Error")
    }
    
    
    // MARK: - RESET TEST
    func testGivenWhenever_WhenResetIsAsked_ThenScreenResultBecomeEmpty() {
        calculator.reset()
        XCTAssertEqual(calculator.elementTextView, "")
    }
    
    
    // MARK: - CHECK BEFORE CALCUL TEST
    func testGivenInputIsEmpty_WhenIncorrectExpressionIsWritten_ThenScreenResultEraseEgal() {
        calculator.addNumber(number: "1")
        calculator.addOperator(operationSymbol: "+")
        calculator.checkBeforeCalculate()
        XCTAssertEqual(calculator.elementTextView, "1 + ")
    }
    
    func testGivenInputIsEmpty_WhenExpressionIsEnough_ThenScreenResultEraseEgal() {
        calculator.addNumber(number: "1")
        calculator.checkBeforeCalculate()
        XCTAssertEqual(calculator.elementTextView, "1")
    }
    
    func testGivenHaveAlreadyResult_WhenEgalTapIsAsked_ThenScreenResultIsTheSame() {
        testSimpleAddition()
        calculator.checkBeforeCalculate()
        XCTAssertEqual(calculator.elementTextView, "1 + 4 = 5.0")
    }
    
    // MARK: - CALCUL TEST
    func testGivenInputIsEmpty_WhenAdditionIsAsked_ThenScreenGiveTheResult() {
        calculator.addNumber(number: "1")
        calculator.addOperator(operationSymbol: "+")
        calculator.addNumber(number: "4")
        calculator.checkBeforeCalculate()
        XCTAssertEqual(calculator.elementTextView, "1 + 4 = 5.0")
        XCTAssertEqual(calculator.elements.last, "5.0")
    }
    
    func testGivenInputIsEmpty_WhenSoustractionIsAsked_ThenScreenGiveTheResult() {
        calculator.addNumber(number: "5")
        calculator.addOperator(operationSymbol: "-")
        calculator.addNumber(number: "1")
        calculator.checkBeforeCalculate()
        XCTAssertEqual(calculator.elementTextView, "5 - 1 = 4.0")
        XCTAssertEqual(calculator.elements.last, "4.0")
    }
    
    func testGivenInputIsEmpty_WhenMultiplicationIsAsked_ThenScreenGiveTheResult() {
        calculator.addNumber(number: "5")
        calculator.addOperator(operationSymbol: "x")
        calculator.addNumber(number: "2")
        calculator.checkBeforeCalculate()
        XCTAssertEqual(calculator.elementTextView, "5 x 2 = 10.0")
        XCTAssertEqual(calculator.elements.last, "10.0")
    }
    
    func testGivenInputIsEmpty_WhenDivisionIsAsked_ThenScreenGiveTheResult() {
        calculator.addNumber(number: "10")
        calculator.addOperator(operationSymbol: "÷")
        calculator.addNumber(number: "2")
        calculator.checkBeforeCalculate()
        XCTAssertEqual(calculator.elementTextView, "10 ÷ 2 = 5.0")
        XCTAssertEqual(calculator.elements.last, "5.0")
    }
    
    func testGivenInputIsEmpty_WhenDivisionByZeroIsAsked_ThenScreenReturnError() {
        calculator.addNumber(number: "10")
        calculator.addOperator(operationSymbol: "÷")
        calculator.addNumber(number: "0")
        calculator.checkBeforeCalculate()
        XCTAssertEqual(calculator.elementTextView, "= Error")
        XCTAssertEqual(calculator.elements.last, "Error")
    }
    
    func testGivenHaveAlreadyResult_WhenOperatorIsAdded_ThenScreenAddOperatorAndLastResult() {
        testGivenInputIsEmpty_WhenDivisionIsAsked_ThenScreenGiveTheResult()
        calculator.addOperator(operationSymbol: "+")
        XCTAssertEqual(calculator.elementTextView, "5.0 + ")
    }
    
    func testGivenScreenHaveError_WhenOperatorIsAdded_ThenScreenReturnError() {
        testGivenInputIsEmpty_WhenDivisionIsAsked_ThenScreenGiveTheResult()
        calculator.addOperator(operationSymbol: "+")
        XCTAssertEqual(calculator.elementTextView, "= Error + ")
    }
    
    func testGivenScreenIsEmpty_WhenOperatorIsAdded_ThenScreenReturnError() {
        testGivenWhenever_WhenResetIsAsked_ThenScreenResultBecomeEmpty()
        calculator.addOperator(operationSymbol: "+")
        XCTAssertEqual(calculator.elementTextView, "= Error + ")
    }
}
