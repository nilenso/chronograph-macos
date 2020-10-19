//
//  AppDelegate.swift
//  timetracker-macos
//
//  Created by Govind krishna Joshi on 18/08/20.
//  Copyright © 2020 nilenso. All rights reserved.
//
import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    var application: Application!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        self.application = Application()
        self.application.start(title: "TT")
    }

    func applicationWillTerminate(_ aNotification: Notification) {

    }
}
