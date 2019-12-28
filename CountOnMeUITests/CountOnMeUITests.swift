//
//  CountOnMeUITests.swift
//  CountOnMeUITests
//
//  Created by E&M Life Project on 28/12/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CountOnMeUITests: XCTestCase {
    var app: XCUIApplication!

       override func setUp() {
        super.setUp()
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
       }

//    func testNumberButtons() {
//        app.buttons["2"].tap()
//        app.buttons["4"].tap()
//        app.buttons["5"].tap()
//        //essai 1
////        let result = app.textViews.containing(.staticText, identifier: "45")
////        XCTAssertTrue(result)
//        
//        //essai 2
////        XCTAssertEqual(app.textViews["Text View"].value as? String, "245")
//
//        //essai 3
////        let button = app.segmentedControls.buttons [ "1" ]
////        app.buttons["1"].tap()
////        XCTAssertTrue(button.exists)
//    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
