//
//  Application.swift
//  chronograph
//
//  Created by Govind krishna Joshi on 27/08/20.
//  Copyright © 2020 nilenso. All rights reserved.
//

import SwiftUI

class Application<V: View> {
    let view: V;
    let height: Int;
    let width: Int;
    
    var container: NSPopover!;
    var statusBarIcon: NSStatusItem!;
    
    init(view: V, height: Int, width: Int) {
        self.view = view;
        self.height = height;
        self.width = width;
    }
    
    func start() {
        createContainer()
        createStatusBarIcon()
    }
    
    private func createContainer() {
        self.container = NSPopover();
        self.container.contentSize = NSSize(width: 400, height: 500);
        self.container.behavior = .transient;
        self.container.contentViewController = NSHostingController(
            rootView: self.view
        );
    }
    
    private func createStatusBarIcon() {
        self.statusBarIcon = NSStatusBar.system.statusItem(
            withLength: CGFloat(NSStatusItem.variableLength)
        );
        
        if let button = self.statusBarIcon.button {
            button.target = self;
            button.title = "TT";
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
    
    private func showContainer(button: NSButton) {
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
    
    private func hideContainer(_ sender: AnyObject?) {
        self.container.performClose(sender);
    }
}
