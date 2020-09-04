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
    var app: Application!;
    var window = NSWindow();


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let store = Store(appState: AppState())
        let contentView = ContentView().environment(\.store, store)
        let viewController = NSHostingController(rootView: contentView)
        
        let statusBarIcon = NSStatusBar.system.statusItem(
            withLength: CGFloat(NSStatusItem.variableLength)
        );
        self.app = Application(statusBarIcon: statusBarIcon)
        app.setupContainer(viewController: viewController, height: 500, width: 400);
        app.setupStatusBarIcon(title: "TT");
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        
    }
}

struct StoreKey: EnvironmentKey {
    typealias Value = Store;
    
    static var defaultValue: Store = Store(appState: AppState());
}

extension EnvironmentValues {
    var store: Store {
        get { self[StoreKey.self] }
        set { self[StoreKey.self] = newValue }
    }
}
