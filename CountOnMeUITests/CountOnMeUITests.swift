////
////  CountOnMeUITests.swift
////  CountOnMeUITests
////
////  Created by E&M Life Project on 28/12/2019.
////  Copyright © 2019 Vincent Saluzzo. All rights reserved.
////
//

import XCTest

class CountOnMeUiTests: XCTestCase {
    var app: XCUIApplication!
    override func setUp() {
        super.setUp()
        continueAfterFailure = true
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        app = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCalcul() {
        app.buttons["4"].tap()
        app.buttons["2"].tap()
        app.buttons["1"].tap()
        let TextView = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textView).element
        
        XCTAssertEqual(TextView.value as? String, "421")
    }

    func testTime() {
        measure {
            app.buttons["4"].tap()
            app.buttons["2"].tap()
            app.buttons["1"].tap()
            app.buttons["AC"].tap()
        }
    }
}
