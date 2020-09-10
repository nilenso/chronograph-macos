//
//  Application.swift
//  chronograph
//
//  Created by Govind krishna Joshi on 27/08/20.
//  Copyright © 2020 nilenso. All rights reserved.
//
import Cleanse
import SwiftUI

class Application {
    let statusItem: NSStatusItem;
    let popover: NSPopover;
    let viewController: ViewController;
    let store: Store;

    init(statusItem: NSStatusItem, popover: NSPopover, viewController: ViewController, store: Store) {
        self.statusItem = statusItem;
        self.popover = popover;
        self.viewController = viewController;
        self.store = store;
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
    
    struct Component: Cleanse.RootComponent {
        typealias Root = Application;
        
        static func configure(binder: Binder<Singleton>) {
            binder.bind(NSStatusItem.self)
                .sharedInScope()
                .to { () -> NSStatusItem in
                    NSStatusBar.system.statusItem(
                        withLength: CGFloat(NSStatusItem.variableLength)
                    )
            }
            
            binder.bind(NSPopover.self)
                .sharedInScope()
                .to { () -> NSPopover in
                    let popover = NSPopover();
                    popover.contentSize = NSSize(width: 400, height: 500);
                    popover.behavior = .transient
                    return popover;
            }
            
            binder.include(module: ViewController.Module.self)
            
            binder.include(module: Store.Module.self)
        }
        
        static func configureRoot(binder bind: ReceiptBinder<Application>) -> BindingReceipt<Application> {
            return bind.to(factory: Application.init)
        }
    }
}
