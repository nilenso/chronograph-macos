//
//  chronographUITests.swift
//  chronographUITests
//
//  Created by Govind krishna Joshi on 20/08/20.
//  Copyright © 2020 nilenso. All rights reserved.
//

import XCTest

class chronographUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
 
    }
    
    func testStatusBarIconIsPresent() throws {
        let app = XCUIApplication()
        app.launch();
        
        let statusBarIcon = app.statusItems.element;
        XCTAssertTrue(statusBarIcon.waitForExistence(timeout: 5));
        XCTAssertEqual(statusBarIcon.title, "TT");
    }
}
