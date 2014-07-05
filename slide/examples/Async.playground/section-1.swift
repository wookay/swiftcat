// Playground - noun: a place where people can play

import Cocoa

let url = NSURL(string: "http://www.osxdev.org/")

class SessionDelegate: NSObject, NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate {
    var bytesExpected: Int = 0
    var bytesReceived: Int = 0
    let receivedData = NSMutableData()
    func URLSession(session: NSURLSession!, dataTask: NSURLSessionDataTask!, didReceiveResponse response: NSURLResponse!, completionHandler: ((NSURLSessionResponseDisposition) -> Void)!) {
        bytesExpected = Int(response.expectedContentLength)
        completionHandler(.Allow)
    }
    
    func URLSession(session: NSURLSession!, dataTask: NSURLSessionDataTask!, didReceiveData data: NSData!) {
        bytesReceived += data.length
        println("Received \(data.length) bytes")
        receivedData.appendData(data)
    }
    
    func URLSession(session: NSURLSession!, dataTask: NSURLSessionDataTask!, didCompleteWithError:NSError!) {
        bytesReceived
    }
}

let delegate = SessionDelegate()
let session = NSURLSession(configuration: NSURLSessionConfiguration.ephemeralSessionConfiguration(), delegate: delegate, delegateQueue: NSOperationQueue.mainQueue())
let task = session.dataTaskWithURL(url)
task.resume()

import XCPlayground
XCPSetExecutionShouldContinueIndefinitely()