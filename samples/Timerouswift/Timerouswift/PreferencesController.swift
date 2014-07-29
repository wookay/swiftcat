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

    @IBOutlet var firstTextField : NSTextField
    @IBOutlet var secondTextField : NSTextField
    @IBOutlet var volumeSlider : NSSlider

    @IBAction func firstTextFieldChanged(textField : NSTextField) {
        let minutes = textField.stringValue
        NSUserDefaults.standardUserDefaults().setInteger(minutes.toInt()!, forKey: "First")
        timerController!.firstButton.title = "\(minutes)분"
    }

    @IBAction func secondTextFieldChanged(textField : NSTextField) {
        let minutes = textField.stringValue
        NSUserDefaults.standardUserDefaults().setInteger(minutes.toInt()!, forKey: "Second")
        timerController!.secondButton.title = "\(minutes)분"
    }

    @IBAction func volumeSliderChanged(volumeSlider : NSSlider) {
        let volume = volumeSlider.floatValue
        NSUserDefaults.standardUserDefaults().setFloat(volume, forKey: "Volume")
        timerController!.timer.audioPlayer.player.volume = volume
    }
    
    override func windowDidLoad() {
        firstTextField.integerValue = NSUserDefaults.standardUserDefaults().integerForKey("First")
        secondTextField.integerValue = NSUserDefaults.standardUserDefaults().integerForKey("Second")
        volumeSlider.floatValue = NSUserDefaults.standardUserDefaults().floatForKey("Volume")
        volumeSlider.minValue = 0.0
        volumeSlider.maxValue = 1.0
    }
    
}
