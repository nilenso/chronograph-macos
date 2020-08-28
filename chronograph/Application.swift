//
//  Application.swift
//  chronograph
//
//  Created by Govind krishna Joshi on 27/08/20.
//  Copyright © 2020 nilenso. All rights reserved.
//
import SwiftUI

class Application {
    var container: NSPopover!;
    var statusBarIcon: NSStatusItem!;   
    
    init(container: NSPopover, statusBarIcon: NSStatusItem) {
        self.container = container;
        self.statusBarIcon = statusBarIcon;
    }
    
    func setupContainer<V: View>(viewController: NSHostingController<V>, height: Int, width: Int) {
        self.container.contentSize = NSSize(width: width, height: height);
        self.container.behavior = .transient;
        self.container.contentViewController = viewController;
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
