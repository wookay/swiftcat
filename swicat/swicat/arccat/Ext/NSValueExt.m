//
//  NSValueExt.m
//  FindTheWords
//
//  Created by wookay on 13. 10. 6..
//  Copyright (c) 2013년 factorcat. All rights reserved.
//

#import "NSValueExt.h"
#import "objc/runtime.h"
#import "Logger.h"

@implementation NSValue (Ext)

+(id) valueWithAny:(const void *)value objCType:(const char *)type {
	switch (*type) {
		case _C_CHR: // BOOL, char
			if (1 == (size_t)value) {
				return [NSNumber numberWithBool:TRUE];
			} else if (NULL == value) {
				return [NSNumber numberWithBool:FALSE];
			} else {
				return [NSNumber numberWithChar:*(char *)value];
			}
		case _C_UCHR: return [NSNumber numberWithUnsignedChar:*(unsigned char *)value];
		case _C_SHT: return [NSNumber numberWithShort:*(short *)value];
		case _C_USHT: return [NSNumber numberWithUnsignedShort:*(unsigned short *)value];
		case _C_INT:
			return [NSNumber numberWithInt:*(int *)value];
		case _C_UINT: return [NSNumber numberWithUnsignedInt:*(unsigned *)value];
		case _C_LNG: return [NSNumber numberWithLong:*(long *)value];
		case _C_ULNG: return [NSNumber numberWithUnsignedLong:*(unsigned long *)value];
		case _C_LNG_LNG: return [NSNumber numberWithLongLong:*(long long *)value];
		case _C_ULNG_LNG: return [NSNumber numberWithUnsignedLongLong:*(unsigned long long *)value];
		case _C_FLT:
			return [NSNumber numberWithFloat:*(float *)value];
		case _C_DBL:
            return [NSNumber numberWithDouble:*(double *)value];
		case _C_ID:
        case _C_CLASS:
			if (nil == value) {
				return nil;
			} else {
                NSValue* val =  [NSValue valueWithBytes:value objCType:type];
                return [val nonretainedObjectValue];
			}
		case _C_PTR:
		case _C_STRUCT_B:
		case _C_ARY_B:
			if (NULL == value) {
				return nil;
			} else {
				return [NSValue valueWithBytes:value objCType:type];
			}
	}
	return [NSValue valueWithBytes:value objCType:type];
}

+(id) stringWithAny:(const void *)value objCType:(const char *)type {
	switch (*type) {
		case _C_CHR: // BOOL, char
			if (1 == (size_t)value) {
				return [[NSNumber numberWithBool:TRUE] description];
			} else if (NULL == value) {
				return [[NSNumber numberWithBool:FALSE] description];
			} else {
				return [[NSNumber numberWithChar:*(char *)value] description];
			}
		case _C_UCHR: return [[NSNumber numberWithUnsignedChar:*(unsigned char *)value] description];
		case _C_SHT: return [[NSNumber numberWithShort:*(short *)value] description];
		case _C_USHT: return [[NSNumber numberWithUnsignedShort:*(unsigned short *)value] description];
		case _C_INT:
			return [[NSNumber numberWithInt:*(int *)value] description];
		case _C_UINT: return [[NSNumber numberWithUnsignedInt:*(unsigned *)value] description];
		case _C_LNG: return [[NSNumber numberWithLong:*(long *)value] description];
		case _C_ULNG: return [[NSNumber numberWithUnsignedLong:*(unsigned long *)value] description];
		case _C_LNG_LNG: return [[NSNumber numberWithLongLong:*(long long *)value] description];
		case _C_ULNG_LNG: return [[NSNumber numberWithUnsignedLongLong:*(unsigned long long *)value] description];
		case _C_FLT:
			return [[NSNumber numberWithFloat:*(float *)value] description];
		case _C_DBL:
            return [[NSNumber numberWithDouble:*(double *)value] description];
		case _C_ID:
        case _C_CLASS:
			if (nil == value) {
				return @"nil";
			} else {
                id obj = [[NSValue valueWithBytes:value objCType:type] nonretainedObjectValue];
                if (nil == obj) {
                    return @"nil";
                } else if ([obj isKindOfClass:[NSNumber class]]) {
                    return [NSString stringWithFormat:@"@%@", [obj description]];
                } else if ([obj isKindOfClass:[NSArray class]] || [obj isKindOfClass:[NSDictionary class]]) {
                    return [obj To_s];
                } else {
                    return [obj description];
                }
			}
		case _C_PTR:
            if (nil == [[NSValue valueWithBytes:value objCType:type] nonretainedObjectValue]) {
                return @"nil";
            } else {
                return [[NSValue valueWithPointer:value] description];
            }
		case _C_STRUCT_B:
		case _C_ARY_B:
			if (NULL == value) {
				return @"nil";
			} else {
				return [[NSValue valueWithBytes:value objCType:type] description];
			}
	}
	return [[NSValue valueWithBytes:value objCType:type] description];
}

@end