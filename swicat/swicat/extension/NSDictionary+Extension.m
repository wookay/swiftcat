//
//  NSDictionary+Extension.m
//  TestApp
//
//  Created by ssukcha on 2014. 1. 10..
//  Copyright (c) 2014년 factorcat. All rights reserved.
//

#import "NSDictionary+Extension.h"
#import "NSDictionaryExt.h"

@implementation NSDictionary (Extension)
-(NSString*) to_s {
    return [self To_s];
}
-(id) fetch:(id)key {
    return [self Fetch:key];
}
-(NSArray*) keys {
    return [self Keys];
}
-(NSArray*) values {
    return [self Values];
}
@end
