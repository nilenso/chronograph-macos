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
        // let store = UserStore();
        let viewController = NSHostingController(
            rootView: ContentView() // .environment(\.managedObjectContext, store)
        );
        
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

