//
//  AppDelegate.swift
//  Timerouswift
//
//  Created by WooKyoung Noh on 7/23/14.
//  Copyright (c) 2014 factorcat. All rights reserved.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    
    var timerController = TimerController(windowNibName: "Timer")
    var preferencesController = PreferencesController(windowNibName: "Preferences")
    
    func applicationDidFinishLaunching(aNotification: NSNotification?) {
        
        NSUserDefaults.standardUserDefaults().registerDefaults(["Volume": 0.5])
        
        timerController.showWindow(self)
    }
    
    @IBAction func preferencesMenuClicked(sender : AnyObject) {
        preferencesController.timerController = timerController
        preferencesController.showWindow(self)
    }

    func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication!) -> Bool {
        return true
    }
    
    func applicationWillTerminate(aNotification: NSNotification?) {
    }
        
}

