//
//  AppDelegate.swift
//  Timerouswift
//
//  Created by WooKyoung Noh on 7/23/14.
//  Copyright (c) 2014 factorcat. All rights reserved.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    
    var viewController = StopWatchController(windowNibName: "StopWatch")
    
    func applicationDidFinishLaunching(aNotification: NSNotification?) {
        viewController.showWindow(self)
    }

    func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication!) -> Bool {
        return true
    }
    
    func applicationWillTerminate(aNotification: NSNotification?) {
    }
    
}

