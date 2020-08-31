//
//  ApplicationTest.swift
//  chronographTests
//
//  Created by Govind krishna Joshi on 27/08/20.
//  Copyright © 2020 nilenso. All rights reserved.
//

import Foundation
import SwiftUI
import XCTest
@testable import chronograph

class ApplicationTest: XCTestCase {
    var application: Application!;
    
    override func setUp() {
        let container = NSPopover();
        let statusBarIcon = NSStatusBar.system.statusItem(
            withLength: CGFloat(NSStatusItem.variableLength)
        );
        
        application = Application(viewController: ViewController(), statusBarIcon: statusBarIcon);
    }
    
    override func tearDown() {
        application = nil;
    }
    
    func testSetupContainer() throws {
        let viewController =  NSHostingController(rootView: Text("Helllo"));
        let width = 10;
        let height = 15;
        application.setupContainer(
            height: height,
            width: width
        );
        
        let container = application.container;
        
        XCTAssertEqual(
            container?.contentSize,
            NSMakeSize(CGFloat(width), CGFloat(height)),
            "Container size does not match expected size"
        );
    }
    
    func testSetupStatusBarIcon() throws {
        let title = "Chronograph Test"
        application.setupStatusBarIcon(title: title)
        
        let container = application.statusBarIcon;
        
        XCTAssertEqual(
            container?.button?.title,
            title,
            "Status bar icon title does not match expected title"
        );
    }
}
