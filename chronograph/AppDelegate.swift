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

    var app: Application<ContentView>!;

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let contentView = ContentView();
        
        self.app = Application(view: contentView, height: 400, width: 500);
        app.start();
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        
    }
}

