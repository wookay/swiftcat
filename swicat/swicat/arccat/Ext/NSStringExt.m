//
//  NSStringExt.m
//  TestApp
//
//  Created by ssukcha on 05/09/13.
//  Copyright (c) 2013 factorcat. All rights reserved.
//

#import "NSStringExt.h"
#import "NSArrayExt.h"
#import "Logger.h"


NSString* SWF(NSString* format, ...) {
    va_list args;
    va_start(args, format);
    NSString* alloc_str = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    NSString* ret = [NSString stringWithFormat:@"%@", alloc_str];
    //[alloc_str release];
    return ret;
}

NSArray* _w(NSString* str) {
    return [[str Strip] componentsSeparatedByString:SPACE];
}

NSString* unichar_to_string(unichar ch) {
	return [NSString stringWithFormat:@"%C", ch];
}



@implementation NSString (Ext)

-(NSString*) slice:(int)loc :(int)length_ {
    NSRange range;
    if (self.length > loc + length_) {
        range = NSMakeRange(loc, length_);
    } else {
        range = NSMakeRange(loc, self.length - loc);
    }
    return [self substringWithRange:range];
}

-(NSString*) slice:(int)loc backward:(int)backward {
    return [self slice:loc :(int)self.length + backward + 1];
}

-(NSString*) gsub:(NSString*)str to:(NSString*)to {
    return [self stringByReplacingOccurrencesOfString:str withString:to];
}

-(BOOL) include:(NSString*)str {
    NSRange range = [self rangeOfString:str];
    return NSNotFound != range.location;
}

-(NSString*) repeat:(int)times {
    NSMutableArray* ary = [NSMutableArray array];
    for (int idx = 0; idx < times; idx++) {
        [ary addObject:self];
    }
    return [ary componentsJoinedByString:Empty];
}

-(int) to_int {
    return [self intValue];
}

-(float) to_float {
    return [self floatValue];
}

-(double) to_double {
    return [self doubleValue];
}

-(unichar) to_unichar {
	return [self characterAtIndex:0];
}

-(NSString*) stringAtIndex:(int)idx {
	return [self substringWithRange:NSMakeRange(idx, 1)];
}

-(BOOL) isEmpty {
    return [Empty isEqualToString:self];
}
@end



@implementation NSString (CapitalizedExt)
-(NSString*) To_s {
    return self;
}
-(NSArray*) Split:(NSString*)sep {
    if ([Empty isEqualToString:self]) {
        return [NSArray array];
    }
    if ([Empty isEqualToString:sep]) {
        NSMutableArray* ary = [NSMutableArray array];
        for (int idx=0; idx<self.length; idx++) {
            NSRange range = NSMakeRange(idx, 1);
            NSString* ch = [self substringWithRange:range];
            [ary addObject:ch];
        }
        return ary;
    } else {
        return [self componentsSeparatedByString:sep];
    }
}

-(NSArray*) Each_char {
	return [self Split:Empty];
}

-(NSString*) Ljust:(int)justified {
    if (self.length < justified) {
        NSString* padStr = SPACE;
        return SWF(@"%@%@", self, [padStr repeat:justified - (int)self.length]);
    } else {
        return self;
    }
}


-(NSString*) Strip {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

-(NSString*) Reverse {
    return [[[self Split:Empty] Reverse] Join:Empty];
}

-(NSString*) Concat:(NSString*)str {
    return [self stringByAppendingString:str];
}

@end