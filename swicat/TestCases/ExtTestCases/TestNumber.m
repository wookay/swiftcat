//
//  TestNumber.m
//  TestApp
//
//  Created by ssukcha on 05/09/13.
//  Copyright (c) 2013 factorcat. All rights reserved.
//

#import "UnitTest.h"
#import "NSNumberExt.h"
#import <UIKit/UIKit.h>

@interface TestNumber : NSObject @end



@implementation TestNumber

-(void) test_number_ext {
    assert_equal(@1, [@1.3 roundUp]);
    assert_equal(@2, [@1.6 roundUp]);

    assert_equal(@2, [@1.3 ceiling]);
    assert_equal(@2, [@1.6 ceiling]);

    assert_equal(@1, [@1.3 floorDown]);
    assert_equal(@1, [@1.6 floorDown]);
}

-(void) test_enum {
#if TARGET_OS_IPHONE
    assert_equal([NSNumber numberWithInt:NSTextAlignmentCenter], Enum(NSTextAlignmentCenter));
#endif
}

-(void) test_number {
    assert_equal(3, 1+2);
    assert_equal(3.14, 3.14);
    assert_equal([NSNumber numberWithInt:5], @5);
    assert_equal(true, [@0 isKindOfClass:[NSNumber class]]);
    assert_equal((double)5, (int)5);
    assert_equal((int)5, (double)5);
    assert_equal([NSNumber numberWithDouble:5], @5);
}

@end



