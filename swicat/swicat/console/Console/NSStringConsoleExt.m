//
//  NSStringConsoleExt.m
//  TestAppTabBar
//
//  Created by ssukcha on 2013. 12. 9..
//  Copyright (c) 2013년 factorcat. All rights reserved.
//

#import "NSStringConsoleExt.h"

@implementation NSString (ConsoleExt)

-(NSString*) escapeHTML {
    NSString* str = self;
    NSDictionary* dict = @{@"&" : @"&amp;",
                           @"<" : @"&lt;",
                           @">" : @"&gt;"
                           };
    for (NSString* key in dict) {
		str = [str stringByReplacingOccurrencesOfString:key withString:[dict objectForKey:key]];
	}
	return str;
}

@end
