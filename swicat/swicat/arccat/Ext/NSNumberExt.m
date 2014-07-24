//
//  NSNumberExt.m
//  TestApp
//
//  Created by ssukcha on 06/09/13.
//  Copyright (c) 2013 factorcat. All rights reserved.
//

#import "NSNumberExt.h"


int get_random(int div) {
	return (arc4random() % div);
}

@implementation NSNumber (Ext)

-(NSNumber*) next {
    return [NSNumber numberWithInt:[self intValue] + 1];
}

-(NSNumber*) roundUp {
    double value = round([self doubleValue]);
    return [NSNumber numberWithDouble:value];
}

-(NSNumber*) ceiling {
    double value = ceil([self doubleValue]);
    return [NSNumber numberWithDouble:value];
}

-(NSNumber*) floorDown {
    double value = floor([self doubleValue]);
    return [NSNumber numberWithDouble:value];
}

@end


@implementation NSNumber (CapitalizedExt)
-(NSString*) To_s {
    return [self description];
}
@end