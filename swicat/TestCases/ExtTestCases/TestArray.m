//
//  TestArray.m
//  TestApp
//
//  Created by ssukcha on 05/09/13.
//  Copyright (c) 2013 factorcat. All rights reserved.
//

#import "UnitTest.h"
#import "NSArrayExt.h"
#import "NSStringExt.h"

@interface TestArray : NSObject @end


@implementation TestArray

-(void) test_mutable_array {
    assert_equal([@[] isKindOfClass:[NSMutableArray class]], false);
    assert_equal(false, [@[] isKindOfClass:[NSMutableArray class]]);
    assert_equal(true, [@[] isKindOfClass:[NSArray class]]);
    
    NSMutableArray* ary = [NSMutableArray array];
    id obj = [ary push:@"a"];
    assert_equal(@[@"a"], obj);
    assert_equal(@[@"a"], ary);
    
    id pop = [ary pop];
    assert_equal(@"a", pop);
    assert_equal(@[], ary);
    
    [ary push:@"a"];
    [ary push:@"a"];
    [ary clear];
    assert_equal(@[], ary);
}

-(void) test_array {
    assert_equal(@[], [NSArray array]);
    NSArray* ary = [NSArray arrayWithObjects:@"a", @"b", @"c", nil];
    assert_equal(@"[a, b, c]", ary.To_s);
    assert_equal(3, ary.count);

    NSArray* numbers = [NSArray arrayWithObjects:@1, @2, @3, nil];
    assert_equal(@"[1, 2, 3]", numbers.To_s);

    assert_equal(@"1,2,3", [numbers Join:COMMA]);
    assert_equal(true, [numbers include:@2]);
    //assert_equal(@[], [ary slice:0 :-1]);
    assert_equal(@[], [ary slice:3 :1]);
    assert_equal(@"b,c", [[ary slice:1 :2] Join:COMMA]);
    assert_equal(@"c b a", [ary.Reverse Join:SPACE]);
    assert_equal(@"a", ary.First);
    assert_equal(@"b", ary.second);
    assert_equal(@"c", ary.third);
    assert_equal(@"c", ary.Last);
}

@end
