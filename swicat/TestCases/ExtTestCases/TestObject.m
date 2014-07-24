//
//  TestObject.m
//  TestApp
//
//  Created by ssukcha on 06/09/13.
//  Copyright (c) 2013 factorcat. All rights reserved.
//

#import "NSObjectExt.h"
#import "UnitTest.h"

@interface TestObject : NSObject @end


@implementation TestObject

-(void) test_methods {
    assert_equal(@"TestObject", self.className);
    assert_equal(@[@"+(id) class_method:(int)intValue ;"], self.classMethods);
    assert_equal(@[@"-(void) test_methods ;"], self.Methods);
}


+(NSString*) class_method:(int)n {
    return @"hello";
}

@end