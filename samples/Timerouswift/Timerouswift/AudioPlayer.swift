//
//  Sound.swift
//  Timerouswift
//
//  Created by WooKyoung Noh on 7/24/14.
//  Copyright (c) 2014 factorcat. All rights reserved.
//

import Foundation
import AVFoundation

class AudioPlayer {
    
    var player : AVAudioPlayer;
    
    init() {
        let path = NSBundle.mainBundle().pathForResource("d3_legendary_sound", ofType: "wav")
        let url = NSURL(fileURLWithPath: path)
        player = AVAudioPlayer(contentsOfURL: url, error:nil)
        player.prepareToPlay()
    }
    
    func play() {
        player.play()
    }
    
}