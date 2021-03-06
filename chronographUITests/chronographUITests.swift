//
//  chronographUITests.swift
//  chronographUITests
//
//  Created by Govind krishna Joshi on 20/08/20.

//

import XCTest

class chronographUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        self.app = XCUIApplication()
        self.app.activate()
    }

    override func tearDownWithError() throws {
        app.terminate()
    }

    func testStatusBarIconIsPresent() throws {
        let statusBarIcon = app.statusItems.element
        XCTAssertTrue(statusBarIcon.waitForExistence(timeout: 5))
        XCTAssertEqual(statusBarIcon.title, "TT")
    }
}
