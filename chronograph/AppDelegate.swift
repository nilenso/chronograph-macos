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

    var container: NSPopover!;
    var statusBarIcon: NSStatusItem!;

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let contentView = ContentView();
        
        self.container = NSPopover();
        self.container.contentSize = NSSize(width: 400, height: 500);
        self.container.behavior = .transient;
        self.container.contentViewController = NSHostingController(
            rootView: contentView
        );
        
        self.statusBarIcon = NSStatusBar.system.statusItem(
            withLength: CGFloat(NSStatusItem.variableLength)
        );
        
        if let button = self.statusBarIcon.button {
            button.title = "TT";
            button.action = #selector(toggleContainer(_:))
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        
    }

    @objc func toggleContainer(_ sender: AnyObject?) {
        if let button = self.statusBarIcon.button {
            if self.container.isShown {
                self.container.performClose(sender);
            } else {
                self.container.show(
                    relativeTo: button.bounds,
                    of: button,
                    preferredEdge: NSRectEdge.minY
                );
                
                self.container.contentViewController?
                    .view
                    .window?
                    .becomeKey();
            }
        }
    }
}

