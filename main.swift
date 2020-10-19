//
//  main.swift
//  chronograph
//
//  Created by Govind krishna Joshi on 27/08/20.
//  Copyright © 2020 nilenso. All rights reserved.
//

import Cocoa

var delegate: NSApplicationDelegate!

if NSClassFromString("chronographTests.TestAppDelegate") != nil {
    let aClass = NSClassFromString("TestAppDelegate") as? NSObject.Type
    delegate = aClass?.init() as? NSApplicationDelegate
} else {
    delegate = AppDelegate()
}

NSApplication.shared.delegate = delegate
_ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
