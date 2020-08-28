//
//  AppDelegate.swift
//  timetracker-macos
//
//  Created by Govind krishna Joshi on 18/08/20.
//  Copyright © 2020 nilenso. All rights reserved.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var app: Application!;

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let viewController = NSHostingController( rootView: ContentView());
        
        let statusBarIcon = NSStatusBar.system.statusItem(
            withLength: CGFloat(NSStatusItem.variableLength)
        );
        
        let container = NSPopover();
        
        self.app = Application(container: container, statusBarIcon: statusBarIcon);
        app.setupStatusBarIcon(title: "TT");
        app.setupContainer(
            viewController: viewController,
            height: 500,
            width: 400
        );
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        
    }
}

