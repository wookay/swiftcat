// Playground - noun: a place where people can play



// Franz Heinfling
// Published June 27, 2014
// Building a simple multi-player Swift game in Playground
// http://letvar.com/blog/2014/06/building-a-simple-multi-player-swift-spritekit-game-in-playground/

import Cocoa
import SpriteKit
import XCPlayground

var textures = Array(0..6).map { SKTexture(imageNamed: "horse-run-0\($0)") }

let sprite = SKSpriteNode(imageNamed: "horse")
sprite.position = CGPoint(x: 80, y: 80)
let walk : SKAction = SKAction.animateWithTextures(textures, timePerFrame: 0.08)
sprite.runAction(SKAction.repeatActionForever(walk))
let gameRect = NSRect(x: 0, y: 0, width: 200, height: 200)
let scene = SKScene(size: gameRect.size)
scene.backgroundColor =  NSColor.whiteColor()
scene.addChild(sprite)
let resultView = SKView(frame: gameRect)
resultView.presentScene(scene)
XCPShowView("말달리자", resultView)