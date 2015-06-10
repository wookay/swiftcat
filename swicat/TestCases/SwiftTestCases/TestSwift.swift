//
//  TestSwift.swift
//  TestApp
//
//  Created by WooKyoung Noh on 8/13/14.
//  Copyright (c) 2014 factorcat. All rights reserved.
//

@objc(TestSwift)
class TestSwift : NSObject {

    func test_number() {
        assert_equal(3, got: 1+2)
    }
    
    func test_string() {
        assert_equal("abc", got: "a"+"b"+"c")
    }

    func test_array() {
        assert_equal([1,2,3], b: [1,2]+[3])
    }

    func test_dictionary() {
        assert_equal(["a": 5], got: ["a": 5])
    }

}