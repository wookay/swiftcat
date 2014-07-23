//
//  StopWatchController.swift
//  Timerouswift
//
//  Created by WooKyoung Noh on 7/23/14.
//  Copyright (c) 2014 factorcat. All rights reserved.
//

import Cocoa

class StopWatchController: NSWindowController {
    @IBOutlet var display: NSTextField
    @IBOutlet var startButton: NSButton
    @IBOutlet var stopButton: NSButton
    @IBOutlet var resetButton: NSButton
    
    var accumulated : NSTimeInterval = 0
    var started : NSDate? = NSDate()
    var stopped : NSDate? = NSDate()

    override func windowDidLoad() {
        NSTimer.scheduledTimerWithTimeInterval(
            0.01,
            target: self,
            selector: Selector("updateTimers"),
            userInfo: nil,
            repeats: true)
    }
    
    @IBAction func start(sender : AnyObject) {
        started = NSDate()
        stopped = nil

    }

    @IBAction func stop(sender : AnyObject) {
        stopped = NSDate()
        if stopped && started {
            accumulated += stopped!.timeIntervalSinceDate(started!)
        }
    }

    @IBAction func reset(sender : AnyObject) {
        accumulated = 0
        started = nil
        stopped = nil
    }
    
    func elapsed() -> NSTimeInterval {
        var result : NSTimeInterval = accumulated
        if started != nil && stopped == nil {
            result -= started!.timeIntervalSinceNow
        }
        return result
    }
    
    func updateTimers() {
        self.updateDisplay()
    }
    
    func updateDisplay() {
        var elapsed : Int = Int(self.elapsed())
        let seconds : Int = elapsed % 60
        let minutes : Int = (elapsed / 60) % 60
        let hours : Int = (elapsed / 60) / 60
        display.stringValue = NSString(format:"%02u:%02u:%02u", hours, minutes, seconds)
    }
}