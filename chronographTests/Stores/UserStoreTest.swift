//
//  UserStoreTest.swift
//  chronograph
//
//  Created by Govind krishna Joshi on 31/08/20.
//  Copyright © 2020 nilenso. All rights reserved.
//

import Foundation
import XCTest
@testable import chronograph

class UserStoreTest: XCTestCase {
    var userStore: UserStore!;
    
    override func setUp() {
        self.userStore = UserStore();
    }
    
    override func tearDown() {
        self.userStore = nil;
    }
    
}
