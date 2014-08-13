//
//  TestSuite.swift
//  BigCalendar
//
//  Created by WooKyoung Noh on 8/13/14.
//  Copyright (c) 2014 factorcat. All rights reserved.
//

import Foundation

func assert_equal(
        expected: AnyObject,
        got: AnyObject,
        function: String = __FUNCTION__,
        file: String = __FILE__,
        line: Int = __LINE__) {
    var equals : Bool = false
    if expected is String {
        equals = expected.isEqual(got)
    } else {
        equals = expected === got
    }
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
        print(NSString(format: "%@ #%03d %@\nAssertion failed\nExpected: ", file, line, function))
        print(expected)
        print("\nGot: ")
        print(got)
    }
}
