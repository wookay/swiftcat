//
//  NSArray+Extension.m
//  TestApp
//
//  Created by ssukcha on 2014. 1. 10..
//  Copyright (c) 2014년 factorcat. All rights reserved.
//

#import "NSArray+Extension.h"
#import "NSArrayExt.h"

@implementation NSArray (Extension)

-(NSString*) to_s {
    return [self To_s];
}
-(NSString*) join {
    return [self Join];
}
-(NSString*) join:(NSString*)sep {
    return [self Join:sep];
}
-(id) first {
    return [self First];
}
-(id) last {
    return [self Last];
}
-(NSArray*) reverse {
    return [self Reverse];
}

@end