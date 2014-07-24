//
//  NSString+Extension.m
//  TestApp
//
//  Created by ssukcha on 2014. 1. 10..
//  Copyright (c) 2014년 factorcat. All rights reserved.
//

#import "NSString+Extension.h"
#import "NSStringExt.h"

@implementation NSString (Extension)
-(NSString*) to_s {
    return [self To_s];
}
-(NSArray*) split:(NSString*)sep {
    return [self Split:sep];
}
-(NSArray*) each_char {
    return [self Each_char];
}
-(NSString*) ljust:(int)justified {
    return [self Ljust:justified];
}
-(NSString*) strip {
    return [self Strip];
}
-(NSString*) reverse {
    return [self Reverse];
}
@end
