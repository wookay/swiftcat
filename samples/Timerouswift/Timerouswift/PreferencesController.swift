//
//  PreferencesController.swift
//  Timerouswift
//
//  Created by WooKyoung Noh on 7/28/14.
//  Copyright (c) 2014 factorcat. All rights reserved.
//

import Cocoa

class PreferencesController : NSWindowController {
    var timerController : TimerController? = nil
    
    @IBOutlet var volumeSlider : NSSlider
    
    @IBAction func volumeSliderChanged(volumeSlider : NSSlider) {
        let volume = volumeSlider.floatValue
        NSUserDefaults.standardUserDefaults().setFloat(volume, forKey: "Volume")
        NSUserDefaults.standardUserDefaults().synchronize()
        timerController!.timer.audioPlayer.player.volume = volume
    }
    
    override func windowDidLoad() {
        volumeSlider.floatValue = NSUserDefaults.standardUserDefaults().floatForKey("Volume")
    }
    
}
