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
        super.setUp()
        calculator = Calculator()
    }
    
    override func tearDown() {
        calculator = nil
    }
    
    // MARK: - NUMBER TEST
    func testGivenStringNumber4_WhenAddingNumber_ThenNumberIsShowed() {
        let stringNumber = "4"
        calculator.addStringNumber(stringNumber: stringNumber)
        XCTAssertEqual(calculator.elementTextView, "4")
    }
    
    func testGivenStringNumber4and2_WhenAddingNumbers_ThenNumberIsShowed() {
        calculator.addStringNumber(stringNumber: "4")
        calculator.addStringNumber(stringNumber: "2")
        XCTAssertEqual(calculator.elementTextView, "42")
    }
    
    func testGivenStringNumber4and2Dot1_WhenAddingNumber_ThenNumberIsShowed() {
        calculator.addStringNumber(stringNumber: "4")
        calculator.addStringNumber(stringNumber: "2")
        calculator.addStringNumber(stringNumber: ".")
        calculator.addStringNumber(stringNumber: "1")
        XCTAssertEqual(calculator.elementTextView, "42.1")
    }
    
    func testGivenStringNumber3AfterReset_WhenAddingNumber_ThenNumberIsShowed() {
        calculator.reset()
        calculator.addStringNumber(stringNumber: "3")
        XCTAssertEqual(calculator.elementTextView, "3")
    }
    
    // MARK: - OPERATOR TEST
    func testGivenOperatorX_WhenAddingOperator_ThenTwoAndOperatorIsShowed() {
        calculator.addOperator(operationSymbol: "x")
        XCTAssertEqual(calculator.elementTextView, "2 x ")
    }
    
    func testGivenOperatorXandLess_WhenAddingOperators_ThenTwoAndLastOperatorIsShowed() {
        calculator.addOperator(operationSymbol: "x")
        calculator.addOperator(operationSymbol: "-")
        XCTAssertEqual(calculator.elementTextView, "2 - ")
    }
    
    func testGivenBadOperator_WhenAddingOperator_ThenErrorIsShowed() {
        calculator.addOperator(operationSymbol: "/")
        XCTAssertEqual(calculator.elementTextView, "= Error")
    }
    
    
    // MARK: - RESET TEST
    func testGivenAC_WhenResetIsAsked_ThenScreenResultBecomeEmpty() {
        calculator.reset()
        XCTAssertEqual(calculator.elementTextView, "")
    }
    
    
    // MARK: - CHECK BEFORE CALCUL TEST
    func testGivenInputIsEmpty_WhenIncorrectExpressionIsWritten_ThenScreenResultEraseEgal() {
        calculator.addStringNumber(stringNumber: "1")
        calculator.addOperator(operationSymbol: "+")
        calculator.checkBeforeCalculate()
        XCTAssertEqual(calculator.elementTextView, "1 + ")
    }
    
    func testGivenInputIsEmpty_WhenExpressionIsEnough_ThenScreenResultEraseEgal() {
        calculator.addStringNumber(stringNumber: "1")
        calculator.checkBeforeCalculate()
        XCTAssertEqual(calculator.elementTextView, "1")
    }
    
    func testGivenHaveAlreadyResult_WhenEgalTapIsAsked_ThenScreenResultIsTheSame() {
        testGivenAddition1and4_WhenCalculIsAsked_ThenScreenGiveTheResult()
        calculator.checkBeforeCalculate()
        XCTAssertEqual(calculator.elementTextView, "1 + 4 = 5.0")
    }
    
    // MARK: - CALCUL TEST
    func testGivenAddition1and4_WhenCalculIsAsked_ThenScreenGiveTheResult() {
        calculator.addStringNumber(stringNumber: "1")
        calculator.addOperator(operationSymbol: "+")
        calculator.addStringNumber(stringNumber: "4")
        calculator.checkBeforeCalculate()
        XCTAssertEqual(calculator.elementTextView, "1 + 4 = 5.0")
        XCTAssertEqual(calculator.elements.last, "5.0")
    }
    
    func testGivenSoustraction5and1_WhenCalculIsAsked_ThenScreenGiveTheResult() {
        calculator.addStringNumber(stringNumber: "5")
        calculator.addOperator(operationSymbol: "-")
        calculator.addStringNumber(stringNumber: "1")
        calculator.checkBeforeCalculate()
        XCTAssertEqual(calculator.elementTextView, "5 - 1 = 4.0")
        XCTAssertEqual(calculator.elements.last, "4.0")
    }
    
    func testGivenMultiplication5and2_WhenCalculIsAsked_ThenScreenGiveTheResult() {
        calculator.addStringNumber(stringNumber: "5")
        calculator.addOperator(operationSymbol: "x")
        calculator.addStringNumber(stringNumber: "2")
        calculator.checkBeforeCalculate()
        XCTAssertEqual(calculator.elementTextView, "5 x 2 = 10.0")
        XCTAssertEqual(calculator.elements.last, "10.0")
    }
    
    func testGivenDivision10and2_WhenCalculIsAsked_ThenScreenGiveTheResult() {
        calculator.addStringNumber(stringNumber: "10")
        calculator.addOperator(operationSymbol: "÷")
        calculator.addStringNumber(stringNumber: "2")
        calculator.checkBeforeCalculate()
        XCTAssertEqual(calculator.elementTextView, "10 ÷ 2 = 5.0")
        XCTAssertEqual(calculator.elements.last, "5.0")
    }
    
    // MARK: - OTHERS SITUATION TEST
    func testGivenAddition_WhenAlreadyHaveAResult_ThenScreenAddOperatorAndLastResult() {
        testGivenDivision10and2_WhenCalculIsAsked_ThenScreenGiveTheResult()
        calculator.addOperator(operationSymbol: "+")
        XCTAssertEqual(calculator.elementTextView, "5.0 + ")
    }
    
    func testGivenSoustraction_WhenAlreadyHaveAResult_ThenScreenAddOperatorAndLastResult() {
        testGivenDivision10and2_WhenCalculIsAsked_ThenScreenGiveTheResult()
        calculator.addOperator(operationSymbol: "-")
        XCTAssertEqual(calculator.elementTextView, "5.0 - ")
    }
    
    func testGivenMultiplication_WhenAlreadyHaveAResult_ThenScreenAddOperatorAndLastResult() {
        testGivenDivision10and2_WhenCalculIsAsked_ThenScreenGiveTheResult()
        calculator.addOperator(operationSymbol: "x")
        XCTAssertEqual(calculator.elementTextView, "5.0 x ")
    }
    
    func testGivenDivision_WhenAlreadyHaveAResult_ThenScreenAddOperatorAndLastResult() {
        testGivenDivision10and2_WhenCalculIsAsked_ThenScreenGiveTheResult()
        calculator.addOperator(operationSymbol: "÷")
        XCTAssertEqual(calculator.elementTextView, "5.0 ÷ ")
    }
    
    // MARK: - ERROR SITUATION TEST
    func testGivenDivision10By0_WhenCalculIsAsked_ThenScreenReturnError() {
        calculator.addStringNumber(stringNumber: "10")
        calculator.addOperator(operationSymbol: "÷")
        calculator.addStringNumber(stringNumber: "0")
        calculator.checkBeforeCalculate()
        XCTAssertEqual(calculator.elementTextView, "= Error")
        XCTAssertEqual(calculator.elements.last, "Error")
    }
    
    func testGivenDivision0By0_WhenCalculIsAsked_ThenScreenReturnError() {
        calculator.addStringNumber(stringNumber: "0")
        calculator.addOperator(operationSymbol: "÷")
        calculator.addStringNumber(stringNumber: "0")
        calculator.checkBeforeCalculate()
        XCTAssertEqual(calculator.elementTextView, "= Error")
        XCTAssertEqual(calculator.elements.last, "Error")
    }
    
    func testGivenAdditionOperator_WhenScreenDisplayError_ThenScreenDislayError() {
        testGivenDivision10By0_WhenCalculIsAsked_ThenScreenReturnError()
        calculator.addOperator(operationSymbol: "+")
        XCTAssertEqual(calculator.elementTextView, "= Error + ")
    }
    
    func testGivenSoustractionOperator_WhenScreenDisplayError_ThenScreenDislayError() {
        testGivenDivision10By0_WhenCalculIsAsked_ThenScreenReturnError()
        calculator.addOperator(operationSymbol: "-")
        XCTAssertEqual(calculator.elementTextView, "= Error - ")
    }
    
    func testGivenMultiplicationOperator_WhenScreenDisplayError_ThenScreenDislayError() {
        testGivenDivision10By0_WhenCalculIsAsked_ThenScreenReturnError()
        calculator.addOperator(operationSymbol: "x")
        XCTAssertEqual(calculator.elementTextView, "= Error x ")
    }
    
    func testGivenDivisionOperator_WhenScreenDisplayError_ThenScreenDislayError() {
        testGivenDivision10By0_WhenCalculIsAsked_ThenScreenReturnError()
        calculator.addOperator(operationSymbol: "÷")
        XCTAssertEqual(calculator.elementTextView, "= Error ÷ ")
    }
    
    func testGivenAddition_WhenScreenIsEmpty_ThenScreenDisplayError() {
        testGivenAC_WhenResetIsAsked_ThenScreenResultBecomeEmpty()
        calculator.addOperator(operationSymbol: "+")
        XCTAssertEqual(calculator.elementTextView, "= Error + ")
    }
    
    func testGivenSoustraction_WhenScreenIsEmpty_ThenScreenDisplayError() {
        testGivenAC_WhenResetIsAsked_ThenScreenResultBecomeEmpty()
        calculator.addOperator(operationSymbol: "-")
        XCTAssertEqual(calculator.elementTextView, "= Error - ")
    }
    
    func testGivenMultiplication_WhenScreenIsEmpty_ThenScreenDisplayError() {
        testGivenAC_WhenResetIsAsked_ThenScreenResultBecomeEmpty()
        calculator.addOperator(operationSymbol: "x")
        XCTAssertEqual(calculator.elementTextView, "= Error x ")
    }
    
    func testGivenDivision_WhenScreenIsEmpty_ThenScreenDisplayError() {
        testGivenAC_WhenResetIsAsked_ThenScreenResultBecomeEmpty()
        calculator.addOperator(operationSymbol: "÷")
        XCTAssertEqual(calculator.elementTextView, "= Error ÷ ")
    }
}
