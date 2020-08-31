//
//  Application.swift
//  chronograph
//
//  Created by Govind krishna Joshi on 27/08/20.
//  Copyright © 2020 nilenso. All rights reserved.
//
import SwiftUI

class Application {
    var statusBarIcon: NSStatusItem!;
    var container: NSPopover!;
    
    init( statusBarIcon: NSStatusItem) {
        self.statusBarIcon = statusBarIcon;
    }
    
    func setupContainer<V: View>(viewController: NSHostingController<V>, height: Int, width: Int) {
        self.container = NSPopover();
        self.container.contentSize = NSSize(width: width, height: height);
        self.container.behavior = .transient;
        self.container.contentViewController = viewController;
        showContainer(button: self.statusBarIcon.button!)
    }
    
    func setupStatusBarIcon(title: String) {
        if let button = self.statusBarIcon.button {
            button.target = self;
            button.title = title;
            button.action = #selector(toggleContainer(_:));
        }
    }
    
    @objc private func toggleContainer(_ sender: AnyObject?) {
        if let button = self.statusBarIcon.button {
            if self.container.isShown {
                self.container.performClose(sender);
            } else {
                showContainer(button: button)
            }
        }
    }
    
    func showContainer(button: NSButton) {
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
    
    func hideContainer(_ sender: AnyObject?) {
        self.container.performClose(sender);
    }
}
