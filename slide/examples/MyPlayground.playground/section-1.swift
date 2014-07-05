// Playground - noun: a place where people can play

import Cocoa

var str = "안녕 세미"
let color = NSColor.blueColor()

// 주아체
var font : NSFont! = NSFont(name: "BM JUA_TTF", size: 50)
if !font {
    font = NSFont.systemFontOfSize(50)
}

let attrStr = NSAttributedString(string: str, attributes:[NSForegroundColorAttributeName: color, NSFontAttributeName: font])

let imageView = NSImageView(frame: NSRect(x: 0, y: 0, width: 512, height: 512))
imageView.imageScaling = .ImageScaleProportionallyUpOrDown
let myImage = NSImage(named: "semi")
imageView.image = myImage

