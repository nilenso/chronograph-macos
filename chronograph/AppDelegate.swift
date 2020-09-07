//
//  AppDelegate.swift
//  timetracker-macos
//
//  Created by Govind krishna Joshi on 18/08/20.
//  Copyright © 2020 nilenso. All rights reserved.
//
import Cleanse
import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    var factory: ComponentFactory<Application.Component>?
    var application: Application!;

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        self.factory = try! ComponentFactory.of(Application.Component.self)
        self.application = factory!.build(())
        self.application.start(title: "TT")
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        
    }
}
