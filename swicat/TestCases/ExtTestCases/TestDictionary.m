//
//  TestDictionary.m
//  TestApp
//
//  Created by ssukcha on 05/09/13.
//  Copyright (c) 2013 factorcat. All rights reserved.
//

#import "UnitTest.h"
#import "NSDictionaryExt.h"

@interface TestDictionary : NSObject @end



@implementation TestDictionary

-(void) test_mutable_dictionary {
    assert_equal(false, [@{} isKindOfClass:[NSMutableDictionary class]]);
    assert_equal(true, [@{} isKindOfClass:[NSDictionary class]]);
    
    NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithDictionary:@{@"cat": @2, @"dog": @1}];
    NSDictionary* expectedDictionary = @{@"cat": @2, @"dog": @1};
    assert_equal(expectedDictionary, dict);
    [dict storeKey:@"horse" value:@5];
    assert_equal(@"{cat: 2, dog: 1, horse: 5}", dict.To_s);
    [dict delete:@"apple"];
    assert_equal(@"{cat: 2, dog: 1, horse: 5}", dict.To_s);
    [dict delete:@"cat"];
    assert_equal(@"{dog: 1, horse: 5}", dict.To_s);
    [dict merge:@{@"cow": @7}];
    assert_equal(@"{cow: 7, dog: 1, horse: 5}", dict.To_s);
    [dict clear];
    assert_equal(@{}, dict);
}

-(void) test_dictionary {
    assert_equal(@{}, [NSDictionary dictionary]);
    assert_equal(0, @{}.count);
    NSDictionary* expectedDictionary = @{@"k": @"v"};
    NSDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:@"v", @"k", nil];
    assert_equal(expectedDictionary, dict);
    assert_equal(@[@"k"], dict.Keys);
    assert_equal(@[@"v"], dict.Values);
    assert_equal(@"{k: v}", dict.To_s);
    NSArray* expectedPairs = @[@[@"k", @"v"]];
    assert_equal(expectedPairs, dict.to_array);

    assert_equal(true, [dict hasKey:@"k"]);
    assert_equal(@"v", [dict Fetch:@"k"]);
    assert_equal(1, dict.count);
}

-(void) test_dictionary_dul {
    NSDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:@1, @"a", @2, @"b", nil];
    assert_equal(@"{a: 1, b: 2}", dict.To_s);
    assert_equal(2, dict.count);
}

@end
