

// 공정하고 투명한 추첨을 위해 소스를 공개합니다

// https://github.com/wookay/swiftcat/blob/master/slide/examples/TShirts.playground/section-1.swift


import Cocoa
import XCPlayground

var str = "OSXDEV 티샤스 추첨"

let M = [34, 55, 92, 65, 23, 94, 81, 28, 9, 89, 57, 75, 79, 39, 58, 67, 19, 22]
let XL = [25, 51, 45, 78, 49, 101, 17, 5, 31, 56, 18, 36, 35]
let L = [53, 91, 37, 74, 64, 20, 7, 12, 3, 4, 6, 54, 65, 88, 11, 50, 41, 99, 26, 42, 72, 102, 47, 73, 70, 21, 63, 77, 10, 44, 61, 30]

func 뽑기(div:Int) -> Int {
    return Int(arc4random() % UInt32(div))
}

let 티 = M
let 갯수 = 5
let 시작할까요 = true

//let 티 = L
//let 갯수 = 5
//let 시작할까요 = false

//let 티 = XL
//let 갯수 = 5
//let 시작할까요 = false

if 시작할까요 {
for 번 in 0..갯수+5 {
    let n = 뽑기(countElements(티))
    var text = NSText(frame: NSRect(x: 0, y: 0, width: 900, height: 700))
    text.font = NSFont.systemFontOfSize(150)
    let 안쪽 = 갯수 > 번
    let 결과 = 안쪽 ? "😍 당첨자" : "😭 흑 아쉽다"
    text.string = "\(번+1)번째\n\(결과): \(티[n])"
    XCPCaptureValue("누구", 티[n])
    if 안쪽 {
        XCPCaptureValue("축하합니다", text)
    } else {
        XCPCaptureValue("저런", text)
    }
}
}