//
//  NSArrayExt.m
//  TestApp
//
//  Created by ssukcha on 05/09/13.
//  Copyright (c) 2013 factorcat. All rights reserved.
//

#import "NSArrayExt.h"
#import "NSStringExt.h"


NSInteger sortByFirstObjectComparator(id uno, id dos, void* context) {
    if ([uno isKindOfClass:NSArray.class]) {
        return [[uno First] compare:[dos First]];
    } else if ([uno isKindOfClass:NSString.class]) {
        return [uno compare:dos];
    } else {
        return 0;
    }
}


@implementation NSArray (Ext)

-(BOOL) include:(id)obj {
    return [self containsObject:obj];
}

-(NSArray*) slice:(int)loc :(int)length_ {
    NSRange range;
    if (self.count > loc + length_) {
        range = NSMakeRange(loc, length_);
    } else {
        range = NSMakeRange(loc, self.count - loc);
    }
    return [self subarrayWithRange:range];
}

-(NSArray*) slice:(int)loc backward:(int)backward {
    return [self slice:loc :(int)self.count + backward + 1];
}

-(id) second {
    return [self objectAtIndex:1];
}

-(id) third {
    return [self objectAtIndex:2];
}

-(NSArray*) append:(NSArray*)ary {
    return [self arrayByAddingObjectsFromArray:ary];
}

-(NSArray*) sort {
	return [self sortedArrayUsingSelector:@selector(compare:)];
}

@end



@implementation NSArray (CapitalizedExt)
-(NSString*) To_s {
    NSMutableArray* ary = [NSMutableArray array];
    for (id obj in self) {
        SEL sel  = @selector(To_s);
        if ([obj respondsToSelector:sel]) {
            [ary addObject:[obj To_s]];
        } else {
            [ary addObject:[obj description]];
        }
    }
    return [NSString stringWithFormat:@"[%@]", [ary Join:COMMA_SPACE]];
}
-(NSString*) Join {
    return [self componentsJoinedByString:Empty];
}
-(NSString*) Join:(NSString*)sep {
    return [self componentsJoinedByString:sep];
}

-(id) First {
    return [self objectAtIndex:0];
}

-(id) Last {
    return [self lastObject];
}
-(NSArray*) Reverse {
    return [[self reverseObjectEnumerator] allObjects];
}
@end



@implementation NSMutableArray (Ext)

- (id) push:(id)obj {
    [self addObject:obj];
    return self;
}

- (id) pop {
    if (0 == [self count]) {
        return nil;
    }
    id obj = [self lastObject];
    [self removeLastObject];
    return obj;
}

-(void) clear {
    [self removeAllObjects];
}

@end

