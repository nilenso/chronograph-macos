//
//  StoreTest.swift
//  chronographTests
//
//  Created by Govind krishna Joshi on 10/09/20.
//  Copyright © 2020 nilenso. All rights reserved.
//
import XCTest
@testable import chronograph

class StoreTest: XCTestCase {
    var appState: AppState!;
    var store: Store!;

    override func setUpWithError() throws {
        self.appState = AppState();
        self.store = Store(appState: appState);
    }

    override func tearDownWithError() throws {
        self.store = nil;
    }

    func testLoginUserIsSuccessful() throws {
        // If Login user is successful, the users access token
        // is present in the app state
        
        store.loginUser()
        XCTAssert(appState.accessToken != nil);
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
