//
//  TestSuite.swift
//  BigCalendar
//
//  Created by WooKyoung Noh on 8/13/14.
//  Copyright (c) 2014 factorcat. All rights reserved.
//

import Foundation

class Logger : NSObject {
    class var sharedInstance: Logger {
        struct Static {
            static var instance: Logger?
            static var token: dispatch_once_t = 0
        }
        dispatch_once(&Static.token) {
            Static.instance = Logger()
        }
        return Static.instance!
    }
}

let LF = "\n"
func log_info(
    a: AnyObject,
    function: String = __FUNCTION__,
    file: String = __FILE__,
    line: Int = __LINE__,
    column: Int = __COLUMN__) {
    print(NSString(format: "%@ #%03d,%02d %@ ", file, line, column, function))
    print(a)
    print(LF)
}

func assert_equal(
        expected: AnyObject,
        got: AnyObject,
        function: String = __FUNCTION__,
        file: String = __FILE__,
        line: Int = __LINE__,
        column: Int = __COLUMN__) {
    var equals : Bool = false
    equals = expected.isEqual(got)
    if equals {
        UnitTestManager.sharedInstance().assertions += 1;
        if (UnitTestManager.sharedInstance().dot_if_passed) {
            print(".");
        } else {
            print("passed: ")
            print(got)
            print("\n")
        }
    } else {
        UnitTestManager.sharedInstance().failures += 1;
        print("\n")
        print(NSString(format: "%@ #%03d,%02d %@\nAssertion failed\nExpected: ", file, line, column, function))
        print(expected)
        print("\nGot: ")
        print(got)
    }
}

func assert_true(condition: Bool,
    function: String = __FUNCTION__,
    file: String = __FILE__,
    line: Int = __LINE__,
    column: Int = __COLUMN__) {
        assert_equal(true, condition, function: function, file: file, line: line, column: column)
}