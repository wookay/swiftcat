//
//  TestString.m
//  TestApp
//
//  Created by ssukcha on 05/09/13.
//  Copyright (c) 2013 factorcat. All rights reserved.
//

#import "UnitTest.h"
#import "NSStringExt.h"
#import <UIKit/UIKit.h>

@interface TestString : NSObject @end



@implementation TestString

-(void) test_string {
    assert_equal(@"a", [@" a " Strip]);
    assert_equal(@"cba", [@"abc" Reverse]);
    assert_equal(@"bc", [@"abc" slice:1 :2]);
    assert_equal(@"abcd", [@"abcff" gsub:@"ff" to:@"d"]);
    assert_equal(3, @"abc".length);
    assert_equal(true, [@"abc" include:@"a"]);
    assert_equal(@"aB", SWF(@"a%@", @"B"));
    assert_equal(@"aaaaa", [@"a" repeat:5]);
    assert_equal(3, [@"3" to_int]);
    assert_equal(3, @"3".to_int);
    assert_equal(3.14f, @"3.14".to_float);
    assert_equal(3.14f, @"3.14f".to_float);
    assert_equal(3.14, @"3.14".to_double);
    
    NSArray* expected = @[@"a", @"b", @"c"];
    assert_equal(expected, [@"a b c" Split:@" "]);
    assert_equal(expected, [@"abc" Each_char]);
}

-(void) test_to_s {
#if TARGET_OS_IPHONE
    CGRect rect = CGRectFromString(@"NSRect: {{1, 2}, {3, 5}}");
    assert_equal(@"NSRect: {{1, 2}, {3, 5}}", to_s(rect));
    assert_equal(@"1", to_s(1));
    assert_equal(@"3.14", to_s(3.14));
    assert_equal(@"@1", to_s(@1));
    assert_equal(@"@3.14", to_s(@3.14));
    assert_equal(@"[]", to_s(@[]));
    assert_equal(@"{}", to_s(@{}));
    assert_equal(@"1", to_s(NSTextAlignmentCenter));
    assert_equal(@"NSObject", to_s([NSObject class]));
    assert_equal(@"nil", to_s(nil));
    NSString* p;
    assert_equal(@"nil", to_s(p));
    NSNumber* n;
    assert_equal(@"nil", to_s(n));
    assert_equal(nil, nil);
    assert_equal(false, false);
#endif
}

@end