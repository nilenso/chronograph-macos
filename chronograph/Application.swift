//
//  Application.swift
//  chronograph
//
//  Created by Govind krishna Joshi on 27/08/20.
//  Copyright © 2020 nilenso. All rights reserved.
//
import SwiftUI

class Application {
    let statusItem: NSStatusItem;
    let popover: NSPopover;
    let viewController: ViewController;
    let store: Store;

    init() {
        self.statusItem = NSStatusBar.system.statusItem(
            withLength: CGFloat(NSStatusItem.variableLength)
        );
        
        self.popover = NSPopover();
        self.popover.contentSize = NSSize(width: 400, height: 500);
        self.popover.behavior = .transient
        
        self.store = Store(appState: AppState());
         
        self.viewController = ViewController(
            rootView: ContentView(store: self.store)
        );
    }
    
    func start(title: String) {
        self.popover.contentViewController = viewController;
        if let button = self.statusItem.button {
            button.target = self;
            button.title = title;
            button.action = #selector(toggleContainer(_:));
        }
        self.store.presentationContext = viewController;
        showContainer();
    }

    @objc private func toggleContainer(_ sender: AnyObject?) {
        if self.popover.isShown {
            self.popover.performClose(sender);
        } else {
            showContainer()
        }
    }
    
    func showContainer() {
        if let button = self.statusItem.button {
            self.popover.show(
                relativeTo: button.bounds,
                of: button,
                preferredEdge: NSRectEdge.minY
            );
            
            self.popover.contentViewController?
                .view
                .window?
                .becomeKey();
        }
    }
    
    func hideContainer(_ sender: AnyObject?) {
        self.popover.performClose(sender);
    }
}
