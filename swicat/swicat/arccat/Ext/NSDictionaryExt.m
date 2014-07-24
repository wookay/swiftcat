//
//  NSDictionaryExt.m
//  TestApp
//
//  Created by ssukcha on 05/09/13.
//  Copyright (c) 2013 factorcat. All rights reserved.
//

#import "NSDictionaryExt.h"
#import "NSStringExt.h"
#import "NSArrayExt.h"

@implementation NSDictionary (Ext)

-(NSArray*) to_array {
    NSMutableArray* ary = [NSMutableArray array];
    for (id key in [self allKeys]) {
        id value = [self valueForKey:key];
        [ary addObject:@[key, value]];
    }
    return ary;
}

-(BOOL) hasKey:(id)key {
    NSEnumerator* enumerator = [self keyEnumerator];
    id k;
    while ((k = [enumerator nextObject])) {
        if ([k isEqual:key]) {
            return true;
        }
    }
    return false;
}

-(id) keyForObject:(id)obj {
	NSEnumerator* enumerator = [self keyEnumerator];
	id key;
	while ((key = [enumerator nextObject])) {
		id objectForKey = [self objectForKey:key];
		if ([objectForKey isEqual:obj]) {
			return key;
		}
	}
	return nil;
}

@end



@implementation NSDictionary (CapitalizedExt)

-(NSString*) To_s {
    NSMutableArray* ary = [NSMutableArray array];
    SEL sel  = @selector(To_s);
    for (id key in [self allKeys]) {
        NSArray* pair;
        id value = [self valueForKey:key];
        if ([value respondsToSelector:sel]) {
            pair = @[key, [value To_s]];
        } else {
            pair = @[key, [value description]];
        }
        [ary addObject:[pair Join:@": "]];
    }
    return [NSString stringWithFormat:@"{%@}", [ary Join:COMMA_SPACE]];
}

-(id) Fetch:(id)key {
    return [self objectForKey:key];
}
-(NSArray*) Keys {
    return [self allKeys];
}

-(NSArray*) Values {
    return [self allValues];
}


@end


@implementation NSMutableDictionary (Ext)

-(id) storeKey:(id)key value:(id)value {
    [self setObject:value forKey:key];
    return value;
}

-(void) merge:(NSDictionary*)other {
    [self addEntriesFromDictionary:other];
}

-(id) delete:(id)key {
    id obj = [self objectForKey:key];
    [self removeObjectForKey:key];
    return obj;
}

-(void) clear {
    [self removeAllObjects];
}

@end


