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

    //    lazy var persistentContainer: NSPersistentContainer = {
    //      let container = NSPersistentContainer(name: "Chronograph")
    //      container.loadPersistentStores { _, error in
    //        if let error = error as NSError? {
    //          fatalError("Unresolved error \(error), \(error.userInfo)")
    //        }
    //      }
    //      return container
    //    }();

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let contentView = ContentView().environment(\.store, Store(appState: AppState()));
        let viewController = NSHostingController(rootView: contentView);
        let statusBarIcon = NSStatusBar.system.statusItem(
            withLength: CGFloat(NSStatusItem.variableLength)
        );
        self.app = Application(statusBarIcon: statusBarIcon)
        app.setupContainer(viewController: viewController, height: 500, width: 400);
        app.setupStatusBarIcon(title: "TT");
        
        // saveContext();
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        
    }
    
//    func saveContext() {
//      let context = persistentContainer.viewContext
//      if context.hasChanges {
//        do {
//          try context.save()
//        } catch {
//          let nserror = error as NSError
//          fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//        }
//      }
//    }

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
