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
        assert_equal(3, 1+2)
    }
    
    func test_string() {
        assert_equal("abc", "a"+"b"+"c")
    }
    
}